function []=Bquestion2()
    image=imread('cameraman.png');
    if(size(image,3)==3)
       image=rgb2gray(image); 
    end
    
   %code goes here
   F=fft2(image);
   F=fftshift(F);
     [s1,s2]=size(image);
     A=abs(F);
     max1=max(A(:));
     display(max1);
     A2=A/max1*255;
     display(max(A2(:)));
     figure;imshow(A2);
     
     D0=20;
     for i=1:s1
         for j=1:s2
            if((i-s1/2)^2+(j-s2/2)^2>D0)
               F(i,j)=0 ;
            end
         end
     end
     figure;
     s1=70;s2=70;
     k=1;steps=3;
     for D0=3:4:3+4*(steps-1)
         F3(1:s1,1:s2)=1;
        for i=1:s1
            for j=1:s2
               if((i-s1/2)^2+(j-s2/2)^2>D0)
                    F3(i,j)=0 ;
               end 
            end
        end
        f3=fftshift(abs(ifft2((F3))));
        str=['D0= ' num2str(D0)];
        subplot(1,steps,k);imagesc(f3);colorbar;title(str);
        k=k+1;
        
     end
     
   F2=ifftshift(F);
   imout=uint8(ifft2(F2));
   
    figure;
    subplot(1,2,1);imshow(image);title('orignal image');
    subplot(1,2,2);imshow(imout);title('Low pass image,with D0=20');
   
end
% for different values of D0 the level of blurring changes. as the value of
% D0 decreases the cuttoff frequency of the low pass filter decreases, thus
% increasing the blurrness
% As the filter low pass freq increases, the weightage given to the central
% pixel decreases, the weights of the central pixel is increasing, reducing
% the effect of pixels far off from the current pixel , thus reducing
% blurring