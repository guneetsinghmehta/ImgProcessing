function[]=question4a()
    %Author - Guneet Singh Mehta ,ECE Department, UW Madison
  image=imread('barbara.png');
  if(size(image,3)==3)
     image=rgb2gray(image); 
  end
  F=fft2(image);
  F(1,1)=0;
  imout=uint8(abs(ifft2(F)));
  figure;
  subplot(1,2,1);imshow(image);title('orignal image');
  subplot(1,2,2);imshow(imout);title('image with DC component 0');
    
end
% It is observed that the image has enhanced edges. Since the DC component F(1,1)
% has been made 0, the DC component of the image has become zero, thus emphasising
% the edges in the image. 