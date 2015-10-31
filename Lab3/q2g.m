function [  ] = q2g()
    % as the threshold reaches 10 the MSE decreases after that is starts
    % increasing again. This value 10 is due to the specific noise level 
    s_image=128;
    variance=10;
    %f = double(phantom(s_image));
    %threshold=0.01;
    for i=1:20
        threshold=0.1+1*i;
       MSE(i)= q2g_sub(threshold,variance);
       x(i)=threshold;
    end
    figure;plot(x,MSE);title('MSE vs Threshold in wavelet filtering');
    xlabel('Threshold used');ylabel('MSE');
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






