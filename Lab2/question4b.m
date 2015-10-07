function[]=question4b()
    %Author - Guneet Singh Mehta ,ECE Department, UW Madison
  image=imread('cameraman.png');
  if(size(image,3)==3)
     image=rgb2gray(image); 
  end
  F=fft2(image);
  s1=size(F,1);s2=size(F,2);
  for i=1:s1
      for j=1:s2
          if(i==1)
             F(1,j)=0; 
          end
      end
  end
  imout=uint8(abs(ifft2(F)));
  %imshow(image,'Border','tight');
  figure;
  subplot(1,2,1);imshow(image,'Border','tight');title('orignal image');
  subplot(1,2,2);imshow(imout,'Border','tight');title('image with 1st row element zero');
    
end