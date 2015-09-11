function[]=question10()
  %Author - Guneet Singh Mehta ,ECE Department, UW Madison
  
  im=imread('saturn.png');
  s1=size(im,1);s2=size(im,2);
  figure;imshow(im);title(['orignal image with size=',num2str(s1),'x',num2str(s2)]);
  im2=imresize(im,[s1,s2/2]);
  figure;imshow(im2);title(['modified image with size=',num2str(s1),'x',num2str(s2/2)]);
  
  imwrite(im2,'saturn_modified.png'); %writing the modified image to default directory
end