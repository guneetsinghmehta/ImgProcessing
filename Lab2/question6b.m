function[]=question6b()
    im1=imread('barbara.png');
    if(size(im1,3)==3)
       im1=rgbgray(im1); 
    end
   IM1 = fft2(im1);
   s1=size(im1,1);s2=size(im1,2);
   
   mag1=abs(IM1);
   %display(mag1(1:10,1:10));
    mag1 = randi(300,[s1,s2]);
    %display(mag1(1:10,1:10));
    phase1 = angle(IM1);
    im1_test = real(ifft2(mag1.*exp(1i*phase1)));
     figure;
    subplot(1,2,1);imshow(im1);title('orignal image');
    subplot(1,2,2);imshow(im1_test);title('reconstructed image');
   
end