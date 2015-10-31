% % Bonus question 
% steps
% 1 read an image
% 2 add impulse noise to it with variable P
% 3 decide max window size
% 4 pad the image with symmetric padding and not zero padding
% 5 implement the algorithm


function[]=q2e()
    prob=0.25;
    image=imread('CircleSquare.tif');

    window_size_max=21;I=100;
    [s1,s2]=size(image);
     noisy_image=imnoise(image,'salt & pepper',prob);
     image=I*double(image)/max(double(image(:)));
     noisy_image=I*double(noisy_image)/max(double(noisy_image(:)));
     
     noisy_image=padarray(noisy_image,[floor(window_size_max/2),floor(window_size_max/2)],'symmetric');
    figure;imagesc(noisy_image);colorbar;
     imout=noisy_image;
     
     for i=1+floor(window_size_max/2):s1+floor(window_size_max/2)

         for j=1+floor(window_size_max/2):s2+floor(window_size_max/2)
             window_size=3;
            while(window_size<window_size_max)
               sub=noisy_image(i-floor(window_size/2): i+floor(window_size/2),j-floor(window_size/2): j+floor(window_size/2));
               zmed=median(sub(:));
               zmin=min(sub(:));
               zmax=max(sub(:));
               A1=zmed-zmin;A2=zmed-zmax;
               if(A1>0&&A2<0)
                  B1=noisy_image(i,j)-zmin;
                  B2=noisy_image(i,j)-zmax;
                  if(B1>0&&B2<0)
                      imout(i,j)=noisy_image(i,j);window_size=window_size_max;
                  else
                       imout(i,j)=zmed;window_size=window_size_max;
                  end
               else
                   if(window_size<window_size_max)
                      window_size=window_size+2; 
                   else
                       imout(i,j)=noisy_image(i,j);window_size=window_size_max;
                   end
               end
            end
         end
     end

    imout_final=imout(1+floor(window_size_max/2):s1+floor(window_size_max/2),1+floor(window_size_max/2):s2+floor(window_size_max/2));
     figure;imagesc(imout_final);colorbar;
   
end