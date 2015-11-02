function[]=q1a(image,n_var,flag,tao,type)
% inputs - image,noise variance, show intermediate images or not,tao for
% tikhnov,type for type of function used in tikhonov- either laplacian or
% identity

%     steps
%     1 gaussian blurring
%     2 add gaussian noise
%     3 implement tikhonov filter

    %global variables related to image- image,n_var, s1,s2 size of image
    %-these variables are declared global automatically
    
    %global variables related to transforms - H,G, Y . H - FFT of gaussian
    %blurring, G is fft of the Identity or Laplacian filter  and Y is fft
    %of image after gaussian filtering and addition of noise
    
    global H;global G;global Y;
    global E;
    
    error_handler(nargin);
    [s1,s2]=size(image);
    temp=gaussian_blurring(image);%defines H
    temp=adding_noise(temp);%defines Y
    function_generator(type);%defines G
    imout=tikhonov_filter(temp,H,G,Y,tao);
    
    %now we have 
    
    function[]=error_handler(nargin)
%         returns normalized image and handles the flag and n_var if not given
        if(nargin==0)
           image=imread('boat.png');
           n_var=0.05;
           flag=1;
        elseif(nargin==1)
            n_var=0.05;
            flag=1;
        elseif(nargin==2)
            flag=1;
        end
        if(size(image,3)>1)
           image=rgb2gray(image); 
        end
        image=double(image);
        image_max=max(image(:));
        image=image/image_max;
        %showing image irrespective of flag value
        figure;imagesc(image);colormap gray;colorbar;title('original image'); 
    end

    function [g]=gaussian_blurring(image)
    %return gaussian blurred image after normalizing
        
        %defining filter size and filter variance
            f_size=10;f_var=0.05;
            h=fspecial('gaussian',f_size,f_var);
           
        % blurring the image
            %performing convolution in Fourier Domain
            F=fft2(image);
            H=fft2(h,s1,s2);%H is set here
            Gtemp=F.*H;
            g=real(ifft2(Gtemp));
        %finding normalize image g
            g_max=max(g(:));
            g=g/g_max;
    
        %displaying blurred image and diff between image and the blurred
        %image
             if(flag==1)
                figure;imagesc(g);colormap gray;title('Blurred Image');colorbar;
                figure;imagesc(image-g);colormap gray;title('diff Image');colorbar;
             end       
    end

    function[g2]=adding_noise(g)
       % g is already normalized
        
       g_mean=0;%gaussian mean value-not needed actually
            %adding noise
        g2=imnoise(g,'gaussian',g_mean,n_var);
        e=g2-g;
        if(flag==1)
            figure;imagesc(g2);colormap gray;colorbar;title('noisy image'); 
            figure;imagesc(e);colormap gray;colorbar;title('noise'); 
        end
        E=fft2(e);
        Y=fft2(g2);
        g2max=max(g2(:));
        g2=g2/g2max;
    end

    function[]=function_generator(type)
        %type can be identity or laplacian, default is laplacian
        if(nargin==0)
            type='laplacian';
        end 
        if(strcmp(type,'laplacian'))
           filter=fspecial('laplacian'); 
        elseif(strcmp(type,'identity'))
           filter=eye(3);% what to do here ???? coz fft2 of eye(4) is different than fft2 of eye(3)
        end
        display(filter);
        G=fft2(filter,s1,s2);
    end

    function[imout]=tikhonov_filter(image,H,G,Y,tao)
       % takes the following global inputs- 
       % ***input image- 'image'- not needed because information already in Y
       % -fft of image***
       % H- FFT of the function applied on the image eg - Gaussian blurring
       % G- either identity or laplacian - supplied from outside
       % Y- FFT of the blurred and noisy image
       % tao - tuner for tikhonov filter
       
       %outputs- imout - output normalized image with FFT represented as X
       
       X(1:s1,1:s2)=0;%representing the Fourier transform of the output image
       for i=1:s1
           for j=1:s2
                W(i,j)=conj(H(i,j))/(H(i,j)^2+tao*G(i,j));
                X(i,j)=W(i,j)*Y(i,j);
           end
       end
       imout=real(ifft2(X));
       imout_max=max(imout(:));
       imout=imout/imout_max;
      %showing image irrespective of flag value 
      figure;imagesc(imout);colormap gray;title('Tikhonov filtered image');colorbar; 
       
    end

end

