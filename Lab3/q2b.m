function[]=q2b()
    %Median Filter
    variance=10;
    for i=1:10
       filter_size(i)=2*i+1;
        MSE(i)=q2b_sub(filter_size(i),variance);
        x(i)=i;
        display(i);
    end
    figure;plot(filter_size,MSE);title(['MSE vs filter_size for variance' num2str(variance)]);
end

function[Avg_MSE]=q2b_sub(filter_size,variance)
    D0=filter_size;
    f=double(imread('CircleSquare.tif'));
    MSE(1:10)=0;x(1:10)=0;%initialisation 
    fmax = max(f(:));
    I = 100;
    a = 1.1;
    f = f/fmax*I;
    fmin = 0;
    fmax = max(f(:));
    orignal_image=f;
     for i=1:10
        snr = I^2/variance; % = I^2/sigma^2
        sigma = sqrt(I^2/snr);
        gaussian_noise = randn(size(f))*sigma;
        noisy_image=f+gaussian_noise;
       [filtered_image,MSE(i)]=median_filter(noisy_image,orignal_image,D0,sigma);
%        figure;imagesc(f);
%        figure;imagesc(noisy_image);
%        figure;imagesc(filtered_image);title(['MSE=' num2str(MSE(i))]);
%        pause(20);
       x(i)=i;
     end
    Avg_MSE=sum(MSE(:))/size(MSE,1);
end

function[f2,MSE]=median_filter(noisy_image,orignal_image,D0,sigma)
    neighborhood_size=D0;
    f=double(noisy_image);
    
    
    [s1,s2]=size(orignal_image);
    f2(1:s1+2*floor(neighborhood_size/2),1:s2+2*floor(neighborhood_size/2))=0;
    g=padarray(noisy_image,[floor(neighborhood_size/2),floor(neighborhood_size/2)],'symmetric');
    
    for m=1+floor(neighborhood_size/2):s1+floor(neighborhood_size/2)
        for n= 1+floor(neighborhood_size/2):s2+floor(neighborhood_size/2)
             sub=g(m-floor(neighborhood_size/2):m+floor(neighborhood_size/2),n-floor(neighborhood_size/2):n+floor(neighborhood_size/2));
             f2(m,n)=median(sub(:));
        end
    end
          
   
    f2=f2(1+floor(neighborhood_size/2):s1+floor(neighborhood_size/2),1+floor(neighborhood_size/2):s2+floor(neighborhood_size/2));

    diff=orignal_image-f2;
    MSE=sum(diff(:).*diff(:))/(s1*s2);  
%     figure;imagesc(orignal_image);
%     figure;imagesc(noisy_image);
%     figure;imagesc(f2);
%     pause(20);
%    
end
