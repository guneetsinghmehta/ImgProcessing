function []=Bquestion6()
    image=imread('PeriodicInterference.tif');
    if(size(image,3)==3)
       image=rgb2gray(image); 
    end
    %figure;imshow(image);
    %imout=band_reject(image,30,330);
    imout2=band_reject2(image);
end

function[A2]=show_F(F,str)
         A=abs(F);
         max1=max(A(:));
         A2=A/max1*255;
         %figure;imshow(A2);title(str);
end

function[imout]=band_reject(image,D1,D2)

       %code goes here
       F=fft2(image);
       F=fftshift(F);
       figure;imagesc(uint8(log(1+abs(F))));colorbar;
         [s1,s2]=size(image);
         A=abs(F);
         max1=max(A(:));
         display(max1);
         A2=A/max1*255;
         display(max(A2(:)));
         figure;imshow(A2);


         for i=1:s1
             for j=1:s2
                kip=sqrt((i-s1/2)^2+(j-s2/2)^2);
                 if(kip>=D1&&kip<=D2)
                   F(i,j)=0 ;
                end
             end
         end
         A=abs(F);
         max1=max(A(:));
         display(max1);
         A2=A/max1*255;
         display(max(A2(:)));
         figure;imshow(A2);
       F2=ifftshift(F);
       imout=uint8(ifft2(F2));

        figure;
        subplot(1,2,1);imshow(image);title('orignal image');
        subplot(1,2,2);imshow(imout);title('Transformed image');

end

function[F]=band_reject2(image)
    [s1,s2]=size(image);
    F=fft2(image);F=fftshift(F);
    A_in=show_F(F,'orignal');
    mag=abs(F);
    mag_sorted_dec=sort(mag,'descend');
    max_value=mag_sorted_dec(1);
    threshold=0.6*max_value;
    theta1=15;theta2=50;
    for i=1:s1
        for j=1:s2
            D=(i-floor(s1/2))^2+(j-floor(s2/2))^2;
            theta=atan((i-s1/2)/(-j+s2/2))*180/pi;
            if(theta>theta1&&theta<theta2&&D>30)
                F(i,j)=0;
            end
        end
    end
    A_out=show_F(F,'transformed');
    y=uint8(abs(ifft2(F)));
    figure;
    subplot(1,2,1);imshow(image);title('orignal image');
    subplot(1,2,2);imshow(y);title('transformed image');
    
    figure;
    subplot(1,2,1);imshow(A_in);title('Orignal Fourier Transform');
    subplot(1,2,2);imshow(A_out);title('Filtered Fourier Transform');
    
    
end