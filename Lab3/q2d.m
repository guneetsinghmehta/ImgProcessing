function[]=q2d()
    variance=10;
    n_size=15;
    for i=1:4
       p_size=5+2*i;
       display(i);
       MSE(i)=q2d_sub(variance,n_size,p_size);
       x(i)=p_size;
    end
    figure;plot(x,MSE);title(['MSE vs filter_size for variance' num2str(variance)]);
end

function[MSE_avg]=q2d_sub(noise_variance, n_size,p_size)
    f=double(imread('CircleSquare.tif'));
    f=f(1:4:end,1:4:end);% done so as to reduce the time
    MSE(1:10)=0;x(1:10)=0;%initialisation 
    fmax = max(f(:));
    I = 100;
    a = 1.1;
    f = f/fmax*I;
    orignal_image=f;
    filtered_image=f;filtered_image(:)=0;
     for i=1:10
        snr = I^2/noise_variance; % = I^2/sigma^2
        sigma = sqrt(I^2/snr);
        gaussian_noise = randn(size(f))*sigma;
%         display(size(f));display(size(gaussian_noise));
        noisy_image=f+gaussian_noise;
       [filtered_image,MSE(i)]=nlm_filter(noisy_image,orignal_image,n_size,p_size);
       if(i==1)            
%             figure;imagesc(noisy_image);title('noisy_image');
%             figure;imagesc(orignal_image);title('orignal_image');
%             figure;imagesc(filtered_image);title('filtered image');
%             pause(5);
%      
       end
              %figure;imagesc(filtered_image);title('filtered image');pause(2);
     end
    MSE_avg=sum(MSE(:))/size(MSE,1);
end

function[imout,MSE]=nlm_filter(noisy_image,orignal_image,n_size,p_size)
    threshold=100;
    [s1,s2]=size(orignal_image);
    imout(1:s1,1:s2)=0;
    %n_size=7;p_size=3;
    %f1=figure;
    
%    f=padarray(f,[floor(n_size/2),floor(n_size/2)]);
    noisy_image=padarray(noisy_image,[floor(n_size/2),floor(n_size/2)],'symmetric');
    for m=1+floor(n_size/2):s1+floor(n_size/2)
        for n=1+floor(n_size/2):s1+floor(n_size/2)
%             sub_g=f(m-floor(n_size/2):m+floor(n_size/2),n-floor(n_size/2):n+floor(n_size/2));
            patch_mn=noisy_image(m-floor(p_size/2):m+floor(p_size/2),n-floor(p_size/2):n+floor(p_size/2));
            
           % f(m-floor(p_size/2):m+floor(p_size/2),n-floor(p_size/2):n+floor(p_size/2))=1;
%            f(m-floor(n_size/2):m+floor(n_size/2),n-floor(n_size/2):n+floor(n_size/2))=2; 
%            f(m-floor(p_size/2):m+floor(p_size/2),n-floor(p_size/2):n+floor(p_size/2))=4;
%            figure(f1);imagesc(f);pause(0.1);
           sum=0;count=0;
            for s=1+floor(p_size/2):n_size-floor(p_size/2)
                for t=1+floor(p_size/2):n_size-floor(p_size/2)
                    a=m-1-floor(n_size/2);b=n-1-floor(n_size/2);
%                     f(a+s-floor(p_size/2):a+s+floor(p_size/2),b+t-floor(p_size/2):b+t+floor(p_size/2))=1;
                    patch_st=noisy_image(a+s-floor(p_size/2):a+s+floor(p_size/2),b+t-floor(p_size/2):b+t+floor(p_size/2));
                    diff=abs(patch_mn-patch_st);
%                     display(size(diff));pause(10);
                    if(diff(:).*diff(:)<threshold)
                       sum=sum+noisy_image(a+s,b+t);count=count+1; 
                    end
%                     figure(f1);imagesc(f);pause(0.01);
                end
            end
            imout(m-floor(n_size/2),n-floor(n_size/2))=sum/count;
        end
    end
%     noisy_image=noisy_image(1+floor(n_size/2):s1+floor(n_size/2),1+floor(n_size/2):s2+floor(n_size/2));
    %display(size(imout));display(size(orignal_image));
    diff2=orignal_image-imout;
    MSE=diff2(:).*diff2(:)/(s1*s2);
    %display(size(MSE));
    %display(size(diff2));
    MSE_sum=0;
    for k=1:size(MSE,1)
        MSE_sum=MSE_sum+MSE(k,1);
    end
    MSE=MSE_sum;
%     figure;imagesc(orignal_image);
%     figure;imagesc(imout);
end