function[]=question6c()
    im1=imread('barbara.png');
    if(size(im1,3)==3)
       im1=rgbgray(im1); 
    end
   IM1 = fft2(im1);
   s1=size(im1,1);s2=size(im1,2);
   
   mag1=abs(IM1);
    phase1 = angle(IM1);
   % display(phase1(1:10,1:10));
    phase1=randn(1:s1,1:s2);
    im1_test = uint8(real(ifft2(mag1.*exp(1i*phase1))));
     figure;
    subplot(1,2,1);imshow(im1);title('orignal image');
    subplot(1,2,2);imshow(im1_test);title('reconstructed image');
end
%The reconstructed image has no similarities with the orignal image. The
%reconstructed image appears to be a random smudge. The phase information
%is required so that the reconstructed image has some similarity with the
%orignal image. While the magnitude infomation is also necessary , but
% phase information is more important for visual similarity