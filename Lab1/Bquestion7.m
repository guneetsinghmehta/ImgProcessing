% Next experiment with the effect of these filters on a noisy image.
function[]=Bquestion7()
% Author - Guneet Singh Mehta, ECE Masters Student, UW Madison
% email id- gmehta2@wisc.edu

% code copied from pdf handout in ECE 533 as illustration
    image = imread('BirdFish.jpg');
    if(size(image,3)>1)
       image=rgb2gray(image); 
    end
    figure;imshow(image);
    sigma = 15;
    noise = randn(size(image))*sigma;
    im_noisy = double(image) + noise;
    figure;
    subplot(1,2,1);imagesc(uint8(image));title('orignal image');
    axis image;colormap gray;
    subplot(1,2,2);imagesc(uint8(im_noisy),[min(image(:)), max(image(:))]);title('noisy image');
    axis image;colormap gray;
    linkaxes;
    %pause(5);
    
    h_smooth=fspecial('gaussian',5,2);
    h_edge_prewitt=fspecial('prewitt');
    h_unsharp=fspecial('gaussian',3,0.5)+0.4*h_edge_prewitt;
    
    colormap jet;
    imout_smooth=uint8(conv2(double(image),double(h_smooth)));
    imout_prewitt=uint8(conv2(double(image),double(h_edge_prewitt)));
    imout_unsharp=uint8(conv2(double(image),double(h_unsharp)));
    f1=figure;
    subplot(2,2,1);imagesc(image);title('orignal image');
    subplot(2,2,2);imagesc(imout_smooth);title('gaussian smooth image');
    subplot(2,2,3);imagesc(imout_prewitt);title('edge enhanced image - prewitt');
    subplot(2,2,4);imagesc(imout_unsharp);title('unsharp image');
    %median ,max and min filtering
    s1=size(image,1);s2=size(image,2);
    imout_median(1:s1,1:s2)=uint8(0);
    imout_max(1:s1,1:s2)=uint8(0);
    imout_min(1:s1,1:s2)=uint8(0);
    imout_gamma_half(1:s1,1:s2)=uint8(0);
    imout_gamma_two(1:s1,1:s2)=uint8(0);
    mask_size=3; 
    c_gamma_half=double(255)/(255.0)^0.8;
    c_gamma_two=(255.0)^(-0.2);
    for i=1:s1
        for j=1:s2
            if(i<=floor(mask_size/2)||i>=s1-floor(mask_size/2)||j<=floor(mask_size/2)||j>=s2-floor(mask_size/2))
               imout_median(i,j)=image(i,j); 
               imout_max(i,j)=image(i,j); 
               imout_min(i,j)=image(i,j); 
            else
               submatrix=image(i-floor(mask_size/2):i+ floor(mask_size/2),j-floor(mask_size/2):j+ floor(mask_size/2));
               imout_median(i,j)=median(submatrix(:));
               imout_max(i,j)=max(submatrix(:));
               imout_min(i,j)=min(submatrix(:));
            end
            imout_gamma_half(i,j)=uint8(c_gamma_half*(double(image(i,j))^0.8));
            imout_gamma_two(i,j)=uint8(c_gamma_two*(double(image(i,j))^1.2));
        end
    end
    f2=figure;
    subplot(2,2,1);imagesc(image);title('orignal image');
    subplot(2,2,2);imagesc(imout_median);title('median filtered image');
    subplot(2,2,3);imagesc(imout_max);title('max filtered image');
    subplot(2,2,4);imagesc(imout_min);title('min filtered image');
    
    f3=figure;
    subplot(1,3,1);imagesc(image);title('orignal image');
    subplot(1,3,2);imagesc(imout_gamma_half);title('gamma filtered = 0.5');
    subplot(1,3,3);imagesc(imout_gamma_two);title('gamma filtered = 2.0');
    
end
   % seeing the output images , it can be inferred that Gaussian filter,
   % and median filter are able to remove the noise and are closer to the
   % orignal image.
   
   % Max and Min filters were able to remove the noise but the resultant
   % image is not close to the orignal image.
   
   % Edge enhanced, unsharp images added had more noise compared to the
   % orignal image
   
    %Gamma filtered images for gamma>1 and Gamma<1 were also not able to
    %remove the noise
   