function[MSE_avg]=MSE_bilateral_fn(image,variance, neighborhood_size)
    tic;
    intensity_cutoff=100;
    num_iterations=10;MSE_avg=0;
    [s1,s2]=size(image);
    f=double(image);
    MSE(1:num_iterations)=0;
    %neighborhood_size=3;
    f2(1:s1+2*floor(neighborhood_size/2),1:s2+2*floor(neighborhood_size/2))=0;
    
    for k=1:num_iterations
        fprintf('slice number=%d \n',k);
        g=imnoise(f,'gaussian',0,variance);
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
        MSE(k)=sum(diff(:).*diff(:));
        %figure;imshow(uint8(f2));
    end
    MSE_avg=sum(MSE(:))/num_iterations;
    toc;
end