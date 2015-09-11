% Apply your smoothing filter to your image, and then apply an edge-emphasizing filter to the smoothed
% image. Is this result the same or different than if we reversed the order of the two filter operations?
% Why or why not?

function[]=Bquestion3()
% Author - Guneet Singh Mehta, ECE Masters Student, UW Madison
% email id- gmehta2@wisc.edu
    h_smooth=fspecial('gaussian',5,2);
    h_laplacian=fspecial('laplacian');
    
    image=imread('BirdFish.jpg');
    if(size(image,3)==3)
       image=rgb2gray(image); 
    end
    
    im_smooth_edge=conv2(double(image),double(h_smooth));
    im_smooth_edge=conv2(double(im_smooth_edge),double(h_laplacian));
    
    im_edge_smooth=conv2(double(image),double(h_laplacian));
    im_edge_smooth=conv2(double(im_edge_smooth),double(h_smooth));
    
    f1=figure;
    colormap jet;
    subplot(1,2,1);imagesc(uint8(im_smooth_edge));title('image after smoothening and edge detection');
    subplot(1,2,2);imagesc(uint8(im_edge_smooth));title('image after edge detection and smoothening');
    
    figure;imshow(uint8(im_edge_smooth-im_smooth_edge));title('image difference');
end
% there is no difference between smoothened followed by edge enhanced image
% and edge enhanced followed by smoothened image becuase both operations
% are a result of convolution with different masks, and since convolution
% is a linear operation , the order in which the linear operations are done
% on the image  don't matter