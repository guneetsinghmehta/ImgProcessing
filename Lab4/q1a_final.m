function []=q1a_final(image,n_var)
%     Steps
%     1 Read image
%     2 define Gaussian Low Pass filter with f_var = filter variance
%     3 blur the image and see it 
%     4 define n=gaussian noise with a n_var = noise variance 
%     5 g=f*h+e;
%     6 show g 
    
%Step1 defining and reading an image
    %Error handling and using default image
    if(nargin==0)
       image=imread('CircleSquare.tif');
       n_var=0.05;
    elseif(nargin==1)
        n_var=0.05;
    end
    [s1,s2]=size(image);
    
%Step2 
    %defining filter size and filter variance
    f_size=10;f_var=0.05;
    h=fspecial('gaussian',f_size,f_var);
    imagemax=max(image(:));
    image=image/imagemax;
    figure;imagesc(image);colormap gray;title('original image');colorbar;
    
%Step3 blurring the image
    %performing convolution in Fourier Domain
    F=fft2(image);H=fft2(h,s1,s2);
    G=F.*H;
    g=ifft2(G);
        %g=conv2(image,h,'same');
        %figure;imagesc(g);colormap gray;
    
%Step4 ,5 and 6
    %adding noise using imnoise - imnoise works on normalized image
    %values that is between 0 and 1
    
    %finding normalize image g
        g_max=max(g(:));
        g=g/g_max;

        g_mean=0;%gaussian mean value-not needed actually
        g=imnoise(g,'gaussian',g_mean,n_var);
    %showing g=f*h+noise
        figure;imagesc(g);colormap gray;title('gaussian lowpassed and gaussian noise added image');colorbar;
end