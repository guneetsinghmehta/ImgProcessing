% Implement a median filter. (For this lab, do NOT use a built-in function like medfilt2. Also
% implement max and min filters
function[]=Bquestion5()
% Author - Guneet Singh Mehta, ECE Masters Student, UW Madison
% email id- gmehta2@wisc.edu
    
    image=imread('BirdFish.jpg');
    if(size(image,3)==3)
       image=rgb2gray(image); 
    end
    s1=size(image,1);s2=size(image,2);
    imout(1:s1,1:s2)=uint8(0);
    imout_max(1:s1,1:s2)=uint8(0);
    imout_min(1:s1,1:s2)=uint8(0);
    
    colormap jet
    mask_size=3; 
    for i=1:s1
        for j=1:s2
            if(i<=floor(mask_size/2)||i>=s1-floor(mask_size/2)||j<=floor(mask_size/2)||j>=s2-floor(mask_size/2))
               imout(i,j)=image(i,j); 
               imout_max(i,j)=image(i,j); 
               imout_min(i,j)=image(i,j); 
            else
               submatrix=image(i-floor(mask_size/2):i+ floor(mask_size/2),j-floor(mask_size/2):j+ floor(mask_size/2));
               imout(i,j)=median(submatrix(:));
               imout_max(i,j)=max(submatrix(:));
               imout_min(i,j)=min(submatrix(:));
            end
        end
    end
    figure;
    subplot(1,2,1);imagesc(image);title('Orignal Image');
    subplot(1,2,2);imagesc(imout);title('Image after median filter');
    
    figure;
    subplot(1,2,1);imagesc(image);title('Orignal Image');
    subplot(1,2,2);imagesc(imout_max);title('Image after max filter');
    
    figure;
    subplot(1,2,1);imagesc(image);title('Orignal Image');
    subplot(1,2,2);imagesc(imout_min);title('Image after min filter');
    
end