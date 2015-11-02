function[]=q2a(image,n_var,flag)
    global F;global H;global E;%Fourier Transforms of Image,filter and Noise

    error_handler(nargin);
    [s1,s2]=size(image);
    g=gaussian_blurring(image);
    g=adding_noise(g);
    g=weiner_filter(g);
    MSE=MSE_cal(g,image);
    title_string=['weiner filtered image with MSE=' num2str(MSE)];
    figure;imagesc(g);colormap gray; colorbar;title(title_string);
    
     function[]=error_handler(nargin)
        if(nargin==0)
           image=imread('CircleSquare.tif');
           n_var=0.05;
           flag=1;
        elseif(nargin==1)
            n_var=0.05;
            flag=1;
        elseif(nargin==2)
            flag=1;
        end
        image=double(image);
        image_max=max(image(:));
        image=image/image_max;
        if(flag==1),figure;imagesc(image);colormap gray;colorbar;title('original image'); end
    end
  
    function [g]=gaussian_blurring(image)
%         returns blurred 'image'
            [s1,s2]=size(image);

            %defining filter size and filter variance
            f_size=10;f_var=0.05;
            h=fspecial('gaussian',f_size,f_var);
            
            %normalizing image
            imagemax=max(image(:));
            image=image/imagemax;
           
            % blurring the image
            %performing convolution in Fourier Domain
            F=fft2(image);H=fft2(h,s1,s2);
            G=F.*H;
            g=ifft2(G);
             if(flag==1)
%                 figure;imagesc(g);colormap gray;title('Blurred Image');colorbar;
%                 figure;imagesc(image-g);colormap gray;title('diff Image');colorbar;
            end
            %finding normalize image g
                g_max=max(g(:));
                g=g/g_max;
                
    end

    function[g]=adding_noise(g)
        g_max=max(g(:));
        g=g/g_max;
        g_mean=0;%gaussian mean value-not needed actually
            %adding noise
        g2=imnoise(g,'gaussian',g_mean,n_var);
        e=g2-g;
        if(flag==1)
            figure;imagesc(g2);colormap gray;colorbar;title('noisy image'); 
            figure;imagesc(e);colormap gray;colorbar;title('noise'); 
        end
        E=fft2(e);
        F=fft2(image);
    end

    function[g3]=weiner_filter(g)
       %threshold=0.5;
        g3=g;
       G=fft2(g);
        S=var(F(:));K=var(E(:));
       
        display('done');
        W(1:s1,1:s2)=1.0;
        for i=1:s1
            for j=1:s2
                num=(abs(H(i,j)))^2;
                den=H(i,j)*(num+K/S);
                if(H(i,j)~=0)
                    W(i,j)=num/den;
                else
                   W(i,j)=1.0; 
                end
            end
        end
        G3=W.*G;
        g3=real(ifft2(G3));
        if(flag==1)
             figure;imagesc(g3);colormap gray;title('Weiner Filtered Image');colorbar;
        end
    end

   function[MSE]=MSE_cal(image,imout)
       MSE=0;
        for m=1:s1
           for n=1:s2
               MSE=MSE+(image(m,n)-imout(m,n))^2;
           end
        end
       MSE=MSE/(s1*s2);
    end
end