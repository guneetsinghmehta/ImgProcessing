% Generate a sharpening filter by combining the above smoothing and edge-emphasizing filters. HINT:
% this is a kind of unsharp masking. Explain how the same process can be implemented with a single
% filter.


function [ output_args ] = Bquestion4( input_args )
    %Author - Guneet Singh Mehta ,ECE Department, UW Madison
     im=imread('BirdFish.jpg');im=rgb2gray(im);
     %im=imread('saturn.png');
     %im=imread('boat.png');
     h1=fspecial('laplacian');
     sharp=conv2(im,h1);
     h2=fspecial('gaussian',3,0.5);
     smooth=conv2(im,h2);
    figure;imshow(im);title('orignal');
    figure; imshow(uint8(sharp));title('sharp');
    figure;imshow(uint8(smooth));title('smooth');
     figure;imshow(uint8(0.5*sharp+smooth));title('unsharp k=0.5');
    figure;imshow(uint8(0.3*sharp+smooth));title('unsharp k=0.3');
     h3=h1+h2;
     combined=conv2(im,h3);
     figure;imshow(uint8(combined));title('combined');
     
end

