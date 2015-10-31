function[]=q2c()
    variance=10; 
    for i=1:10
       filter_size(i)=2*i+1;
        MSE(i)=MSE_bilateral_fn(variance,filter_size(i));
        x(i)=i;
        display(i);
    end
    figure;plot(filter_size,MSE);title(['MSE vs filter_size for variance' num2str(variance)]);
end

function[MSE_avg]=MSE_bilateral_fn(variance, neighborhood_size)
%     tic;
     image=double(imread('CircleSquare.tif'));
    intensity_cutoff=100;
    num_iterations=10;MSE_avg=0;
    [s1,s2]=size(image);
    f=double(image);
    MSE(1:10)=0;x(1:10)=0;%initialisation 
    fmax = max(f(:));
    I = 100;
    a = 1.1;
    f = f/fmax*I;
    MSE(1:num_iterations)=0;
    %neighborhood_size=3;
    f2(1:s1+2*floor(neighborhood_size/2),1:s2+2*floor(neighborhood_size/2))=0;
    
    for k=1:num_iterations
%         fprintf('slice number=%d \n',k);
        snr = I^2/variance; % = I^2/sigma^2
        sigma = sqrt(I^2/snr);
        gaussian_noise = randn(size(f))*sigma;
        noisy_image=f+gaussian_noise;
        g=noisy_image;
        g=padarray(g,[floor(neighborhood_size/2),floor(neighborhood_size/2)],'symmetric');
      
      
        for i=1+floor(neighborhood_size/2):s1+floor(neighborhood_size/2)
            for j=1+floor(neighborhood_size/2):s2+floor(neighborhood_size/2)
                sub_g=g(i-floor(neighborhood_size/2):i+floor(neighborhood_size/2),j-floor(neighborhood_size/2):j+floor(neighborhood_size/2));
                count=0;%will be zero for the central pixel anyways
                sum_of_pixels=0;
                for m=1:2*floor(neighborhood_size/2)+1
                    for n=1:2*floor(neighborhood_size/2)+1
                       w=1*(sqrt((sub_g(m,n)-g(i,j))^2)<intensity_cutoff);
                       if(w==1)
                          sum_of_pixels=sum_of_pixels+sub_g(m,n); count=count+1;
                       end
                    end
                end
                f2(i,j)=sum_of_pixels/count;
%                 display(w);pause(5);
                
            end
        end
        f2=f2(1+floor(neighborhood_size/2):s1+floor(neighborhood_size/2),1+floor(neighborhood_size/2):s2+floor(neighborhood_size/2));
       % display(size(f2));
        diff=f-f2;
        MSE(k)=sum(diff(:).*diff(:))/(s1*s2);
        %figure;imshow(uint8(f2));
    end
    MSE_avg=sum(MSE(:))/num_iterations;
%     toc;
end