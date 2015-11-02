function [g2]=q1b(image,n_var,flag)
%inverse filtering
    %Error handling and using default image
    global H;
    error_handler(nargin);
    image=double(image);
    g2=gaussian_blurring();
    g2=adding_noise(g2);
    if(flag==1)
        figure;imagesc(g2);colormap gray;title('gaussian lowpassed and gaussian noise added image');colorbar;
    end
    %now applying inverse transfom on image g2
    g3=inverse_filter(g2,H);
    g3max=max(g3(:));
    g3=g3/g3max;
    MSE=MSE_cal(g3,image);
    title_string=['inverse filtered MSE=' num2str(MSE)];
    if(flag==1)
        figure;imagesc(g3);colormap gray;title(title_string);colorbar;
    end
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
    end
  
    function [g]=gaussian_blurring()
%         returns blurred 'image'
            [s1,s2]=size(image);

            %defining filter size and filter variance
            f_size=10;f_var=0.05;
            h=fspecial('gaussian',f_size,f_var);
            
            %normalizing image
            imagemax=max(image(:));
            image=image/imagemax;
            if(flag==1)
                figure;imagesc(image);colormap gray;title('original image');colorbar;
            end
            % blurring the image
            %performing convolution in Fourier Domain
            F=fft2(image);H=fft2(h,s1,s2);
            G=F.*H;
            g=ifft2(G);
            %finding normalize image g
                g_max=max(g(:));
                g=g/g_max;
                
    end

    function[g]=adding_noise(g)
        g_max=max(g(:));
        g=g/g_max;
        g_mean=0;%gaussian mean value-not needed actually
            %adding noise
        g=imnoise(g,'gaussian',g_mean,n_var); 
    end

    function[g3]=inverse_filter(g2,H)
            G2=fft2(g2);G3=G2;
            [s1,s2]=size(G2);
            threshold=0.05;
            for i=1:s1
                for j=1:s2
                    if(abs(H(i,j))>threshold)
                        G3(i,j)=G2(i,j)/H(i,j);
                    else
                        G3(i,j)=G2(i,j);
                    end
                end
            end
            g3=ifft2(G3);
    end

    function[MSE]=MSE_cal(image,imout)
       MSE=0;
       [s1,s2]=size(image);
        for m=1:s1
           for n=1:s2
               MSE=MSE+(image(m,n)-imout(m,n))^2;
           end
        end
       MSE=MSE/(s1*s2);
    end
    
end