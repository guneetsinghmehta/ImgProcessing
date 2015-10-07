function []=Bquestion1()
% filtering image with gaussian function
% use testimage
         image=imread('cameraman.png');
         if(size(image,3)==3)
            image=rgb2gray(image); 
         end
         [s1,s2]=size(image);
         h1=fspecial('gaussian');
         h1=padarray(h1,[floor((s1-size(h1,1))),floor((s2-size(h1,2)))],'post');
         %H1=fftshift(fft2(h1));
         
         F=fft2(image);
        H=fft2(h1);
        Y=(F).*(H);
        figure;imshow(image);title('orignal image');
        figure;
        subplot(1,2,1);colormap(jet);imagesc(abs(1+log(abs(fftshift(H)))));colorbar;title('Gaussian Filter in Freq Domain');
        subplot(1,2,2);imshow(uint8(abs(ifft2(Y))));title('Gaussian filtered Image');
        %pause(5);
        
        h2=rect_fn;
         H2=fftshift(fft2(h2));
         
        F=fft2(image);
        H=fft2(h2);
        Y=(F).*(H);
        figure;
        subplot(1,2,1);colormap(jet);imagesc(abs(1+log(abs(fftshift(H)))),[0,2]);colorbar;title('Rect function in Freq Domain');
        subplot(1,2,2);imshow(uint8(ifft2(Y)));title('Image filtered by Rect function');

     function[h]=rect_fn() 
         a1=5;a2=5;
        for i=1:a1
            for j=1:a1
                h(i,j)=1/(a1*a2);
            end
        end
        h=padarray(h,[floor((s1-size(h,1))),floor((s2-size(h,2)))],'post');
        %h=padarray(h,[floor((s1-size(h,1))),floor((s2-size(h,2)))],'post');
        display(size(h)); 
    end
         
end
%The Gaussian Filter keeps the low frequency component as it is while
%attenuating High frequency components
%The averaging filter has a similar effect in the mid region of the
%frequency response. The low freq components are kept as it is, and as we
% distance from the center increases the attenuation of Freq increases. But
% after a certain distance the coefficient increases again but since most
% of the frequency information is contained near the center, the overall
% effect is that of low pass filter

