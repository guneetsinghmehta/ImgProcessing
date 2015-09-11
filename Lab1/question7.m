function[]=question7()
  %Author - Guneet Singh Mehta ,ECE Department, UW Madison
  % code snippets for imtransform taken from MATLAB help of function imtransform
  im=imread('saturn.png');
  
  figure;imshow(imrotate(im,-90));title('Image Rotation using imrotate');
  A=[0 1 0;-1 0 0;0 0 1]; % A is of the form of [cos(angle),sin(angle),0;-sin(angle) cos(angle) 0;0 0 1]
  tform = maketform('affine',A);
  J = imtransform(im,tform);
  figure, imshow(J);title('Image Rotation using imtransform');
  
  if(size(im,3)==3)
     for k=1:3
        im2_temp=flipdim(im(:,:,k),2);
        im2_temp=transpose(im2_temp);
        im2_temp=flipdim(im2_temp,1);
        im2_temp=flipdim(im2_temp,2);
        im2(:,:,k)=im2_temp;
     end
  elseif(size(im,3)==1)
      im2=flipdim(im,2);%flipping along columns
      im2=transpose(im2);%transpose
      im2=flipdim(im2,1);% flipping along rows
      im2=flipdim(im2,2);%flipping along columns
  end
  figure;imshow(im2);title('rotating image using matrix operations ');
end