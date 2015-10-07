function []=Bquestion4()
    image=imread('ThumbPrint.tif');
    if(size(image,3)==3)
       image=rgb2gray(image); 
    end
    imout=high_pass(image,70);
    

    function[imout]=high_pass(image,D0)

       %code goes here
       F=fft2(image);
       F=fftshift(F);
         [s1,s2]=size(image);
         A=abs(F);
         max1=max(A(:));
         display(max1);
         A2=A/max1*255;
         display(max(A2(:)));
         %figure;imshow(A2);


         for i=1:s1
             for j=1:s2
                if((i-s1/2)^2+(j-s2/2)^2<D0)
                   F(i,j)=0 ;
                end
             end
         end
       F2=ifftshift(F);
       imout=uint8(ifft2(F2));
        str=['high pass filtered image with D0= ' num2str(D0)];
        figure;
        subplot(1,2,1);imshow(image);title('orignal image');
        subplot(1,2,2);imshow(imout);title(str);

    end
end
