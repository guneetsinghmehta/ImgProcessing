function[]=question4g()
    %Author - Guneet Singh Mehta ,ECE Department, UW Madison
  image=imread('cameraman.png');
  if(size(image,3)==3)
     image=rgb2gray(image); 
  end
  F=fft2(image);
  s1=size(F,1);s2=size(F,2);
  c=floor(0.01*s2);
  for k1=1:s1
      for k2=1:s2
          if(k1<c&&k2<c)
             F(k1,k2)=0; 
          end
      end
  end
  imout=uint8(abs(ifft2(F)));
  figure;
  subplot(1,2,1);imshow(image);title('orignal image');
  subplot(1,2,2);imshow(imout);title('resultant image');
    
end
% In the resultant image the edges which are not aligned along either x or
% y direction seem to be enhanced