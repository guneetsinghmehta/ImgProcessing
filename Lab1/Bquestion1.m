% Implement a spatial smoothing filter. (HINT: the Matlab command fspecial has several useful
% filters you may use, and conv2 performs two-dimensional convolution.) How does the filter performance
% change as you change the size of the filter? What if you leave the filter size constant but vary
% the values of the filter coefficients? What is the difference between a boxcar and Gaussian filter?
function[]=Bquestion1()
% Author - Guneet Singh Mehta, ECE Masters Student, UW Madison
% email id- gmehta2@wisc.edu
    h1=fspecial('gaussian',5,2);
    image=imread('BirdFish.jpg');
    if(size(image,3)==3)
      image=rgb2gray(image);
    end
    
    imout=conv2(double(image),double(h1));
    colormap  jet;
    f1=figure;% part 1 of question
    subplot(1,2,1);imagesc(uint8(image));title('orignal image');
    subplot(1,2,2);imagesc(uint8(imout));title('smoothened image');
    
    f2=figure;%change of filter size
    var=3;% for more visible filtering
    filter_size_num=4;rows=2;column=ceil(filter_size_num/rows);
    for i=1:filter_size_num
        filter_size=3+2*(i-1);
        h1=fspecial('gaussian',filter_size,var);
        imout=conv2(double(image),double(h1));
        subplot(rows,column,i);imagesc(uint8(imout));
        title_string=['filter size=' num2str(filter_size)];
        title(title_string);
    end
    % as filter size increases the image becomes more blurred
    
    % for varying variances
    f3=figure;%change of filter size
    filter_size_num=4;rows=2;column=ceil(filter_size_num/rows);
    var_num=4;
    for i=1:var_num
        var=0.5+1*(i-1);
        h1=fspecial('gaussian',5,var);
        imout=conv2(double(image),double(h1));
        subplot(rows,column,i);imagesc(uint8(imout));
        title_string=['variance=' num2str(var)];
        title(title_string);
    end
    % as variance increases for the same filter size , image gets
    % progressively blurred
    
    % A gaussian filter for image filtering has maximum value of
    % coefficient near the center of the filter , which decreases according
    % to the Gaussian function as distance from the center increases. While
    % in Boxcar filter the value of all the coefficients in the filter
    % remain the same and equal to =1/(number of elements in the filter)
    
end