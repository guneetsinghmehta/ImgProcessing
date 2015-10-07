function[]=question4c()
    %Author - Guneet Singh Mehta ,ECE Department, UW Madison
   image=imread('cameraman.png');
  if(size(image,3)==3)
     image=rgb2gray(image); 
  end
  F=fft2(image);
  s1=size(F,1);s2=size(F,2);
  for i=1:s1
      for j=1:s2
          if(j==1)
             F(i,1)=0; 
          end
      end
  end
  imout=uint8(abs(ifft2(F)));
  figure;
  subplot(1,2,1);imshow(image);title('orignal image');
  subplot(1,2,2);imshow(imout);title('image with 1st column element zero');
    
end