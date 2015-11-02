function[]=q3a(image,flag)
    % doing with motion blur- 
%     part2 - MSE vs var for inverse filter
%     part4 - MSE vs var for Weiner filter
%     and compare
    error_handler(nargin);
    global F;global H;global E;global G;
    [s1,s2]=size(image);
    motion_blurring(15,0);
    main();


    function[]=main()
        %run a loop - say 41 times-diff values of n_var blur image with motion blurring,add
        %noise, do inverse and weiner filtering
        g=ifft2(G);
        %matlabpool open;
        for i=20:-1:1
            n_var(i)=0.1/255.0*(i-1);
            g=adding_noise(g,n_var(i));
            
            g2=inverse_filter(g,H);
            MSE_inv(i)=MSE_cal(g2,image);
            g3=weiner_filter(g);
            MSE_weiner(i)=MSE_cal(g3,image);

%             figure;imshow(g2);title('inverse');
%             figure;imshow(g3);title('weiner');
           % pause(5);close all;
            
            x(i)=i;
            fprintf('%d\n',i);
        end
        %matlabpool close;
        figure;plot(n_var,MSE_inv,n_var,MSE_weiner);
        xlabel('Noise Variance');ylabel('MSE');
        title('MSE vs noise variance for inverse and weiner filter');
        legend('Inverse filter','Weiner Filter');
    end
    
    function[g3]=weiner_filter(g)
       
        g3=g;
       G=fft2(g);
        S=var(F(:));K=var(E(:));
       
%         display('done');
        W(1:s1,1:s2)=1.0;
        for i=1:s1
            for j=1:s2
                num=(abs(H(i,j)))^2;
                den=H(i,j)*(num+K/S);
                if(abs(H(i,j))~=0)
                    W(i,j)=num/den;
                else
                   W(i,j)=1.0; 
                end
                
            end
        end
        G3=W.*G;
        g3=real(ifft2(G3));
        MSE=MSE_cal(g3,image);
        if(flag==1)
             figure;imagesc(g3);colormap gray;title(['Weiner Filtered Image with MSE' num2str(MSE)]);colorbar;
        end
    end

    function[]=error_handler(nargin)
        if(nargin==0)
           image=imread('CircleSquare.tif');
           flag=1;
        elseif(nargin==1)
            flag=1;
        end
        image=double(image);
        im_max=max(image(:));
        image=image/im_max;
        F=fft2(image);
    end
  
    function[]=motion_blurring(length,angle)
        %information stored in G
        h=fspecial('motion',length,angle);
        
        H=fft2(h,s1,s2);
        G=H.*F;
        g=ifft2(G);
        if(flag==1)
           figure;imagesc(g);colormap gray;colorbar;title('motionblur'); 
        end
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

    function[g2]=adding_noise(g,n_var)
        g_max=max(g(:));
        g=g/g_max;
        g_mean=0;%gaussian mean value-not needed actually
            %adding noise
        g2=imnoise(g,'gaussian',g_mean,n_var); 
        if(flag==1)
             figure;imagesc(g2);colormap gray;title('Noisy Image');colorbar;
        end
        e=g2-g;
        E=fft2(e);
        G=fft2(g2);
    end

    function[g3]=inverse_filter(g2,H)
            G2=fft2(g2);G3=G2;
            [s1,s2]=size(G2);
            threshold=0.000000000001;
            for i=1:s1
                for j=1:s2
                    if(abs(H(i,j))~=0)
                        G3(i,j)=G2(i,j)/H(i,j);
                    else
                        G3(i,j)=G2(i,j);
                    end
                end
            end
            g3=ifft2(G3);
            MSE=MSE_cal(g3,image);
            if(flag==1)
                figure;imagesc(g3);colormap gray;title(['Inverse Filtered Image with MSE=' num2str(MSE)]);colorbar; 
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