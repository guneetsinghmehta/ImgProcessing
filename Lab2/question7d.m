function[]=question7d()
    image=imread('cameraman.png');
    if(size(image,3)==3)
       image=double(rgb2gray(image)); 
    end
    [s1,s2]=size(image);
    counter=1;
    steps=100;
    MSE(1:steps)=0;
    indices=10:100:100*steps;
    for k=10:100:100*steps
       [imout,k_actual]=question7d_sub(image,k); 
       MSE(counter)=0;
       imdiff=image-imout;
       MSE(counter)=sum(imdiff(:).*imdiff(:));
%        for i=1:s1
%            for j=1:s2
%                MSE(counter)=MSE(counter)+(image(i,j)-imout(i,j))^2;
%            end
%        end
       MSE(counter)=MSE(counter)/(s1*s2);
       indices(counter)=k_actual;
       counter=counter+1;
       fprintf('%d ',counter);
    end
    display(indices);
    figure;plot(indices,MSE);title('MSE with increasing k values');
end

function[imout,k_actual]=question7d_sub(image,k)
    % using the k highest coefficients  in DFT
    show_figs=0;
    F=fft2(image);
    [s1,s2]=size(image);
    mag=abs(F);phase=angle(F);
    mag2(1:s1,1:s2)=0;

    k_temp=k;sum=1;
    while(k_temp-sum>=0)
       for i=1:sum
           j=sum-i+1;
           mag2(i,j)=mag(i,j);
       end
       k_temp=k_temp-sum;
       sum=sum+1;
    end
    k_actual=k-(k_temp);
%    % display(size(mag2));
%     display(size(phase));%pause(5);
    F2=mag2.*exp(1i*phase);imout=uint8(ifft2(F2));
    if(show_figs==1)
        figure;
        subplot(1,2,1);imshow(image);title('orignal image');
        subplot(1,2,2);imshow(imout);title('reconstructed image');
    end
    imout=double(imout);
end