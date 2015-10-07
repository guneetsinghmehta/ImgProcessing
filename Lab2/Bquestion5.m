function []=Bquestion5()
    image=imread('MoirePattern.tif');
    if(size(image,3)==3)
       image=rgb2gray(image); 
    end
    F=fftshift(fft2(image));
    show_F(F,'Fourier Transform of Orignal image');
       Fcopy=F;
       r=80;
       Fcopy=notch_filter(Fcopy,166,58,r);
       Fcopy=notch_filter(Fcopy,86,58,r);
       Fcopy=notch_filter(Fcopy,86,112,r);
       Fcopy=notch_filter(Fcopy,166,112,r);
    show_F(Fcopy,'Fourier Transform of Transformed image');
    y=uint8(abs(ifft2(Fcopy)));
    figure;
    subplot(1,2,1);imshow(image);title('Orignal Image');
    subplot(1,2,2);imshow(y);title('Filtered Image');
end

function[]=show_F(F,str)
         A=abs(F);
         max1=max(A(:));
         A2=A/max1*255;
         figure;imshow(A2);title(str);
end

function[F]=notch_filter(F,x,y,r)
    [s1,s2]=size(F);
    for i=1:s1
        for j=1:s2
            D=(i-x)^2+(j-y)^2;
            if(D<r)
               F(i,j)=0; 
            end
        end
    end
end

