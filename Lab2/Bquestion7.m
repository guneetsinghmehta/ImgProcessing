close all;clc
    M = 64;
f = zeros(64);
f(5,:) = 1;
f(36,:) = 1;
f(59,:) = 1;
f(:,10) = 1;
f(:,24) = 1;
f(:,45) = 1;
k = (1:M:(M^2)) + (1:M);k = k(find((k>0).*(k<=M^2)));
f(k) = ones(size(k));
k = (1:M:(M^2)) - (1:M);k = k(find((k>0).*(k<=M^2)));
f(k) = ones(size(k));
noise = imnoise(f,'salt & pepper',0.05);
f(find(noise==0)) = 0;
figure;imagesc(f);axis image;title('orignal image'); colormap gray;colorbar

for m=1:4
    [s1,s2]=size(f);
    if(m==1)
        h1=[0 0 0 0 0;0 0 0 0 0;0.25 0.25 -1 0.25 0.25;0 0 0 0 0;0 0 0 0 0];%horizontal break
    elseif(m==2)
        h1=[0 0 0.25 0 0;0 0 0.25 0 0;0 0 -1 0 0;0 0 0.25 0 0;0 0 0.25 0 0];
    elseif(m==3)
        h1=[0.25 0 0 0 0;0 0.25 0 0 0;0 0 -1 0 0; 0 0 0 0.25 0;0 0 0 0 0.25];    
    elseif(m==4)
        h1=[0 0 0 0 0.25;0 0 0 0.25 0;0 0 -1 0 0; 0 0.25 0 0 0;0.25 0 0 0 0];        
        
    end
    im1=conv2(f,h1,'same');
    for i=1:s1
        for j=1:s2
            if(im1(i,j)<1)
                im1(i,j)=0;
            end
        end
    end
    figure;
    subplot(1,2,1);imagesc(f);title('orignal image');
    subplot(1,2,2);imagesc(im1,[0,1]);%colorbar;
    if(m==1)
       title('horizontal breaks'); 
    elseif(m==2)
        title('vertical breaks');
    elseif(m==3)
        title('-45 breaks');
    elseif(m==4)
        title('+45 breaks');
    end
end