function []=Bquestion3()
    image=imread('cameraman.png');
    if(size(image,3)==3)
       image=rgb2gray(image); 
    end
    
    [s1,s2]=size(image);
    border=floor(s1*0.3);
    im1(1:s1+border,1:s2+border)=uint8(0);
    im2(1:s1+border,1:s2+border)=uint8(0);
    im1(1:s1,1:s2)=image;
    im2(border/2:s1+border/2-1,border/2:s2+border/2-1)=image;
    figure;
    subplot(2,1,1);imshow(im1);
    subplot(2,1,2);imshow(im2);
    imout1=low_pass(im1,200);
    imout2=low_pass(im2,200);
end

function[imout]=low_pass(image,D0)
    
   %code goes here
   F=fft2(image);
   F=fftshift(F);
     [s1,s2]=size(image);
     A=abs(F);
     max1=max(A(:));
     %display(max1);
     A2=A/max1*255;
     %display(max(A2(:)));
     %figure;imshow(A2);
     
     
     for i=1:s1
         for j=1:s2
            if((i-s1/2)^2+(j-s2/2)^2>D0)
               F(i,j)=0 ;
            end
         end
     end
   F2=ifftshift(F);
   imout=uint8(abs(ifft2(F2)));
   
    figure;
    subplot(1,2,1);imshow(image);title('orignal image');
    subplot(1,2,2);imshow(imout);title('Transformed image');
   
end
% The image with uniform border accross it is preferred because after
% filtering the resulting image can be cropped back to get the resultant
% image of the same size as the orignal one
% In contrast if the image is padded only on one side, then the borders on
% the pixel intensities on non padded sides of the image are lost