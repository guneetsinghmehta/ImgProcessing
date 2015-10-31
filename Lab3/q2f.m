function[]=q2f()
    noise_variance=10;
    %thresholding using Fourier Coefficients
    for i=1:10
        percentile=0.9+0.01*i;
        MSE(i)=q2b_sub(percentile,noise_variance);
        x(i)=percentile;
    end
    figure;plot(x,MSE);title('MSE vs percentile energy kept');
end

function[Avg_MSE]=q2b_sub(percentile_thresh,noise_variance)
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
        snr = I^2/noise_variance; % = I^2/sigma^2
        sigma = sqrt(I^2/snr);
        gaussian_noise = randn(size(f))*sigma;
        noisy_image=f+gaussian_noise;
       [filtered_image,MSE(i)]=fourier_thresholding_filter(noisy_image,orignal_image,percentile_thresh);
%        figure;imagesc(f);
%        figure;imagesc(noisy_image);
%        figure;imagesc(filtered_image);title(['MSE=' num2str(MSE(i))]);
%        pause(20);
       x(i)=i;
       if(i==1)
%             figure;imagesc(noisy_image);title('noisy_image');
%             figure;imagesc(orignal_image);title('orignal_image');
%             figure;imagesc(filtered_image);title('filtered image');
%              pause(1);
%             close all;
       end
     end
    Avg_MSE=sum(MSE(:))/size(MSE,1);
end

function[filtered_image,MSE]=fourier_thresholding_filter(noisy_image,orignal_image,percentile_thresh)
% percentile_thresh is the percent of energy which would remain in filtered
% image
    F_noisy_image=fftshift(fft2(noisy_image));
    F_orignal_image=fftshift(fft2(orignal_image));
%     figure;imagesc(log(1+abs(F_noisy_image)));colorbar;
%     figure;imagesc(log(1+abs(F_orignal_image)));colorbar;
    X=abs(F_noisy_image).*abs(F_noisy_image);
    max_X=max(X(:));
%     figure;hist(X(:),100);title('histogram');
    [s1,s2]=size(noisy_image);
    sum_X=sum(X(:));
    X=X/sum_X;
    F_filtered_image=F_noisy_image;F_filtered_image(:,:)=0;
    default_radius=50;
    for default_radius=1:30
        energy_sum=0;    
        for i=-default_radius:default_radius
            for j=-default_radius:default_radius
                D=sqrt((i)^2+(j)^2);
                if(D<default_radius)
                    energy_sum=energy_sum+X(floor(s1/2)+i,floor(s1/2)+j);
                end
            end
        end
%         display(energy_sum);
        if(energy_sum>percentile_thresh)
           break; 
        end
    end
        for i=-default_radius:default_radius
            for j=-default_radius:default_radius
                D=sqrt((i)^2+(j)^2);
                if(D<default_radius)
                    F_filtered_image(floor(s1/2)+i,floor(s2/2)+j)=F_noisy_image(floor(s1/2)+i,floor(s2/2)+j);
                end
            end
        end
    filtered_image=real(ifft2(fftshift(F_filtered_image)));
   
%     
    diff=orignal_image-filtered_image;
    MSE=sum(diff(:).*diff(:))/(s1*s2); 

end