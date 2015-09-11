function[]=question3()
  %Author - Guneet Singh Mehta ,ECE Department, UW Madison
  im=imread('saturn.png');
  Max_pixel_value=max(im(:));
  Min_pixel_value=min(im(:));
  fprintf('in image saturn.png ,Maximum pixel value=%d and Minimum Pixel Value=%d',Max_pixel_value,Min_pixel_value);
  
end