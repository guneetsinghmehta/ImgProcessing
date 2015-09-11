function[]=question8()
  %Author - Guneet Singh Mehta ,ECE Department, UW Madison
  
  im=imread('saturn.png');
  figure;imshow(im);title('orignal image');
  
  steps=5;
  A=[1 0 0;0 1 0;-steps 0 1]; % A is of the form of [cos(angle),sin(angle),0;-sin(angle) cos(angle) 0;xshift yshift 1]
  % -steps because the shift is towards left
  tform = maketform('affine',A);
  J = imtransform(im,tform);
  figure, imshow(J);title('Image translation using imtransform');
  
  s1=size(im,1);s2=size(im,2);  
  steps=50;
  im2(:,1:s2-steps)=im(:,steps+1:end);
  im2(:,s2-steps+1:s2)=uint8(0);
  figure;imshow(im2);title('shifting image by matrix manipulation');
  
end