% Question 2 Part B
% Implement a spatial edge-emphasizing filter. Again, what is the impact of different choices of filter
% coefficients? Does the emphasis of edges depend on the edge orientation? How is this related to the
% filter coefficients?

function[]=Bquestion2()
% Author - Guneet Singh Mehta, ECE Masters Student, UW Madison
% email id- gmehta2@wisc.edu
    
    % Using sobel filter to detect edges
    image=imread('boat.png');% using this image becuase of horizontal and vertical lines
    horz_edge_filter=fspecial('sobel');
    vert_edge_filter=transpose(fspecial('sobel'));
    
    imout_horz=conv2(double(image),double(horz_edge_filter));
    imout_vert=conv2(double(image),double(vert_edge_filter));
    
    colormap jet;
    f1=figure;
    subplot(1,2,1);imagesc(uint8(abs(imout_horz)));title('horizontal edges');
    subplot(1,2,2);imagesc(uint8(abs(imout_vert)));title('vertical edges');
    
    f2=figure;
    subplot(1,2,1);imshow(uint8(abs(imout_horz)));title('horizontal edges');
    subplot(1,2,2);imshow(uint8(abs(imout_vert)));title('vertical edges');
end

% A sobel filter with coeffs= [1 2 1; 0 0 0;-1 -2 -1] on encountering a
% horizontal boundary , lets say [ 1 1 1 ; 0 0 0 ; 0 0 0] will result in a
% non zero value while on encountering a vertical edge like 
% [1 0 0;1 0 0;1 0 0] will result in a zero value because the coefficients
% times the pixel value will negate each other. 
% Similarly the transpose of sobel filter will detect only the vertical
% edges and not horizontal edges