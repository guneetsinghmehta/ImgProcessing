function[]=question4()
  %Author - Guneet Singh Mehta ,ECE Department, UW Madison
  im=imread('saturn.png');
  figure;imshow(im);
  figure;imagesc(double(im));
  
  % imshow basically shows all images as it is. That is a grayscale image
  % will be displayed as a grayscale image , a color image will be shown as
  % a color image
  
  % While imagesc replaces the image data (grayscale in the case of
  % 'saturn.png' to colors from colormap. The colormap links each intensity
  % value in the image to a particular color. the default colormap of
  % imagesc is 'jet'
end