function[]=q2i()
    num_iterations=10;
    assignin ('base','num_iterations',num_iterations);
    matlabpool('open');% if previous run was stopped. write matlabpool('close') on command window and then rerun
    parfor i=1:num_iterations
       variance=i;
       fprintf('%d',i);
       MSE_gaussian(i)=q2a(variance);display('done gaussian');
       MSE_median(i)=q2b(variance);display('done median');
       MSE_bilateral(i)=q2c(variance);display('done bilateral');
       MSE_nlm(i)=q2d(variance);display('done nlm');
       MSE_fourier(i)=q2f(variance);display('done fourier');
       MSE_wavelet(i)=q2g(variance);display('done wavelet');
       x(i)=variance;
    end
    matlabpool('close');
    assignin ('base','MSE_gaussian3',MSE_gaussian);
    assignin ('base','MSE_median3',MSE_median);
    assignin ('base','MSE_bilateral3',MSE_bilateral);
    assignin ('base','MSE_nlm3',MSE_nlm);
    assignin ('base','MSE_fourier3',MSE_fourier);
    assignin ('base','MSE_wavelet3',MSE_wavelet);
    assignin ('base','x3',x);
    %figure;plot(x,MSE_gaussian,x,MSE_median,x,MSE_bilateral);
    figure;plot(x,MSE_gaussian,x,MSE_median,x,MSE_bilateral,x,MSE_nlm,x,MSE_fourier,x,MSE_wavelet);
    legend('Gaussian','Median','Bilateral','NLM','Fourier','wavelet');
    xlabel('Variance');
    ylabel('MSE');
    title('MSE vs Variance for Different filters');

end

function[MSE]=q2a(variance)
%     Comment - optimum neighborhood for removing gaussian noise is 3*3 size, which results in minimum MSE
%     Thus we choose a 3*3 gaussian filter
    %variance=10;
    filter_size=9;
    MSE=q2a_sub(filter_size,variance);
    %figure;plot(filter_size,MSE);title(['MSE vs filter_size for variance' num2str(variance)]);
end

function[Avg_MSE]=q2a_sub(filter_size,variance)
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
       % generating noise
        snr = I^2/variance; % = I^2/sigma^2
        
        sigma = sqrt(I^2/snr);
        gaussian_noise = randn(size(f))*sigma;
        noisy_image=f+gaussian_noise;
       [filtered_image,MSE(i)]=gaussian_filter(noisy_image,orignal_image,D0,sigma);
%        figure;imagesc(f);
%        figure;imagesc(noisy_image);
%        figure;imagesc(filtered_image);title(['MSE=' num2str(MSE)]);
%        pause(20);
       x(i)=i;
    end
    Avg_MSE=sum(MSE(:))/size(MSE,1);
%     fpritnf('Average Error =%f',Avg_MSE);
%     figure;plot(x,MSE);
end

function[imout,MSE]=gaussian_filter(noisy_image,orignal_image,D0,sigma)
    
    f=double(noisy_image);
    h=fspecial('gaussian',D0,double(sigma));
    imout=conv2(f,h,'same');
    diff=orignal_image-imout;
    MSE=sum(diff(:).*diff(:) )/(size(noisy_image,1)*size(noisy_image,2));
end

function[MSE]=q2b(variance)
    %Median Filter
    filter_size=9;
     MSE=q2b_sub(filter_size,variance);
    %figure;plot(filter_size,MSE);title(['MSE vs filter_size for variance' num2str(variance)]);
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

function[MSE]=q2c(variance)
     filter_size=9;
    MSE=MSE_bilateral_fn(variance,filter_size);
   % figure;plot(filter_size,MSE);title(['MSE vs filter_size for variance' num2str(variance)]);
end

function[MSE_avg]=MSE_bilateral_fn(variance, neighborhood_size)
    %tic;
    intensity_cutoff=100;
    num_iterations=10;MSE_avg=0;
    f=double(imread('CircleSquare.tif'));
    [s1,s2]=size(f);
    MSE(1:10)=0;x(1:10)=0;%initialisation 
    fmax = max(f(:));
    I = 100;
    a = 1.1;
    f = f/fmax*I;
    MSE(1:num_iterations)=0;
    %neighborhood_size=3;
    f2(1:s1+2*floor(neighborhood_size/2),1:s2+2*floor(neighborhood_size/2))=0;
    
    for k=1:num_iterations
       % fprintf('slice number=%d \n',k);
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
        MSE(k)=sum(diff(:).*diff(:));
        MSE(k)=MSE(k)/(s1*s2);
        %figure;imshow(uint8(f2));
    end
    MSE_avg=sum(MSE(:))/num_iterations;
    %toc;
end

function[MSE]=q2d(variance)
    n_size=13;   p_size=9;
    MSE=q2d_sub(variance,n_size,p_size);
    %figure;plot(x,MSE);title(['MSE vs filter_size for variance' num2str(variance)]);
end

function[MSE_avg]=q2d_sub(noise_variance, n_size,p_size)
    f=double(imread('CircleSquare.tif'));
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

function[MSE]=q2f(noise_variance)
    %thresholding using Fourier Coefficients
    percentile=0.998;
        MSE=q2f_sub(percentile,noise_variance);
   % figure;plot(x,MSE);title('MSE vs percentile energy kept');
end

function[Avg_MSE]=q2f_sub(percentile_thresh,noise_variance)
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
            figure;imagesc(filtered_image);title('filtered image');
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

function [MSE] = q2g(variance)
    %Wavelet thresholding with thresh=10;
    % as the threshold reaches 10 the MSE decreases after that is starts
    % increasing again. This value 10 is due to the specific noise level 
    threshold=10;
    
    MSE= q2g_sub(threshold,variance);
%    figure;plot(x,MSE);title('MSE vs Threshold in wavelet filtering');
    %display(MSE);
end

function[Avg_MSE]=q2g_sub(absolute_thresh,noise_variance)
    f=double(imread('CircleSquare.tif'));
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
       [filtered_image,MSE(i)]=wavelet_thresholding_filter(noisy_image,orignal_image,absolute_thresh);
       if(i==1)            
%             figure;imagesc(noisy_image);title('noisy_image');
%             figure;imagesc(orignal_image);title('orignal_image');
%             figure;imagesc(filtered_image);title('filtered image');
%             pause(2);
%             close all;
       end
       
     end
    Avg_MSE=sum(MSE(:))/size(MSE,1);
end

function[filtered_image,MSE]=wavelet_thresholding_filter(noisy_image,orignal_image,absolute_thresh)
    [s1,s2]=size(orignal_image);
    w=haar_LLevel(noisy_image,log2(s1));
    for i=1:s1
        for j=1:s1%assuming s1 and s2 are same, since haar wavelet is applicable to images of size as powers of 2
            if(abs(w(i,j))<absolute_thresh)
                w(i,j)=0;
            end
        end
    end
%     figure;plot(w(:));
    filtered_image=invhaar_LLevel(w,log2(s1));
%     figure;imagesc(noisy_image);title('noisy_image');
%     figure;imagesc(orignal_image);title('orignal_image');
%     figure;imagesc(filtered_image);title('filtered image');
%     pause(5);
%     close all;
    diff=filtered_image-orignal_image;
    MSE=diff(:).*diff(:)/(s1*s1);
    MSE=sum(MSE(:));
end

function[w]=haar_LLevel(f,steps)
    s1=size(f,1);
    w=haar_oneLevel(f);
    for k=1:steps-1
        w(1:s1/2,1:s1/2)=haar_oneLevel(w(1:s1/2,1:s1/2));
        s1=s1/2;
    end
    
end

function w = haar_oneLevel(x)
    [M,N] = size(x);
    if M~=N
       error('image must be square');
    end

    if 2^round(log2(M))~=M
       error('sidelength must be power of two');
    end

    h00 = [1 1; 1 1]/2;
    h01 = [-1 1; -1 1]/2;
    h10 = [-1 -1; 1 1]/2;
    h11 = [1 -1; -1 1]/2;

    w00 = conv2(x,h00,'same');
    w00 = w00(1:2:end,1:2:end);

    w01 = conv2(x,h01,'same');
    w01 = w01(1:2:end,1:2:end);

    w10 = conv2(x,h10,'same');
    w10 = w10(1:2:end,1:2:end);

    w11 = conv2(x,h11,'same');
    w11 = w11(1:2:end,1:2:end);

    w = [w00 w01; w10 w11];

end

function [x] = invhaar_oneLevel(w)

[M,N] = size(w);
if M~=N
   error('image must be square');
end

if 2^round(log2(M))~=M
   error('sidelength must be power of two');
end

wup = kron(w,[0 0; 0 1]);

h00 = [1 1; 1 1]/2;
h01 = [1 -1; 1 -1]/2;
h10 = [1 1; -1 -1]/2;
h11 = [1 -1; -1 1]/2;


w00 = wup(1:M,1:M);
x00 = conv2(w00,h00,'same');

w01 = wup(1:M,((1:M)+M));
x01 = conv2(w01,h01,'same');

w10 = wup(((1:M)+M),1:M);
x10 = conv2(w10,h10,'same');

w11 = wup(((1:M)+M),((1:M)+M));
x11 = conv2(w11,h11,'same');

x = (x00+x01+x10+x11);
end

function[f]=invhaar_LLevel(w,num_steps)
    f=w;
    [s1,s2]=size(w);
    for i=num_steps:-1:1
        s_temp=power(2,i-1);
        %display(s_temp);
        f(1:s1/s_temp,1:s2/s_temp)=invhaar_oneLevel(f(1:s1/s_temp,1:s2/s_temp));
    end
    
end






