% Experiment with 
%  filtering for contrast enhancement. In particular, if im is your original image and
% im_gam is your filtered image, then for each pixel i the 
%  filter performs the following operation:
% im_gam[i] = im[i]ˆgamma;
% What is the effect of this filter? How does the effect change with the value of 
% , particularly when it
% is less than or greater than 1? Does it help if your image pixel values are between 0 and 1?

function[]=Bquestion6()
% Author - Guneet Singh Mehta, ECE Masters Student, UW Madison
% email id- gmehta2@wisc.edu
     image=imread('BirdFish.jpg');
    if(size(image,3)==3)
       image=rgb2gray(image); 
    end
    s1=size(image,1);s2=size(image,2);
    imout(1:s1,1:s2)=uint8(0);
    
    for gamma=0.6:0.2:1.4
        c=255/(255)^gamma;
        for i=1:s1
            for j=1:s2
                imout(i,j)=uint8(c*double(image(i,j))^gamma);
            end
        end
        figure;
        title_text=['Gamma=' num2str(gamma)];
        subplot(1,2,1);imshow(image);title('Orignal Image');
        subplot(1,2,2);imshow(imout);title(title_text);
        %colorbar;
%         display(size(imout));
%         display(size(image));
    end
    % for gamma values less than 1 the contrast in the darker regions (low
    % intensity value) is increased while for gamma values greater than 1
    % the contrast in the brighter regions (high intensity value ) is
    % increased

end
   