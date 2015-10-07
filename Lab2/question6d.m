function[]=question6d()
    im1=imread('barbara.png');
    im2=imread('boat.png');
    if(size(im1,3)==3)
       im1=rgbgray(im1); 
    end
    if(size(im2,3)==3)
       im2=rgbgray(im2); 
    end
    %figure;imshow(im1);
    %figure;imshow(im2);
    F1=fft2(im1);
    F2=fft2(im2);
    
    F1_abs=abs(F1);
    F2_abs=abs(F2);
    
    F1_ang=angle(F1);
    F2_ang=angle(F2);
    
    F1_new=F1_abs.*exp(1i*F2_ang);
    F2_new=F2_abs.*exp(1i*F1_ang);
    
    imout1=uint8(ifft2(F1_new));
    imout2=uint8(ifft2(F2_new));
   
    figure;
    subplot(1,2,1);imshow(im1);title('orignal image of woman')
    subplot(1,2,2);imshow(imout2);title('image with phase of woman and magnitude of boat');
    
    figure;
    subplot(1,2,1);imshow(im2);title('orignal boat image');
    subplot(1,2,2);imshow(imout1);title('image with phase of boat and magnitude of woman');
 
end
% the reconstructed images have similarities to the image whose phase is
% used to construct the image. That is, the spatial information leading to
% similarity in perception is carried by the phase information and not
% magnitude