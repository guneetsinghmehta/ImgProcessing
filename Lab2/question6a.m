function[]=question6a()
    im1=imread('barbara.png');
    if(size(im1,3)==3)
       im1=rgbgray(im1); 
    end
   IM1 = fft2(im1);
    mag1 = abs(IM1);
    phase1 = angle(IM1);
    im1_test = uint8(ifft2(mag1.*exp(1i*phase1)));
    figure;
    subplot(1,2,1);imshow(im1);title('orignal image');
    subplot(1,2,2);imshow(im1_test);title('reconstructed image');
end