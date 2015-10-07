function[]=question7c()
    image=double(imread('cameraman.png'));
    im_noise=imnoise(image,'gaussian',0,0.05);
    [s1,s2]=size(image);
    counter=1;
    steps=100;
    MSE(1:steps)=0;
    indices=1:steps;
    for k=10:100:100*steps
       imout=question7a(im_noise,k); 
       MSE(counter)=0;
       imdiff=image-imout;
       MSE(counter)=sum(imdiff(:).*imdiff(:));
%        for i=1:s1
%            for j=1:s2
%                MSE(counter)=MSE(counter)+(image(i,j)-imout(i,j))^2;
%            end
%        end
       MSE(counter)=MSE(counter)/(s1*s2);
       counter=counter+1;
       fprintf('%d ',counter);
    end
    indices=indices*k;
    figure;plot(indices,MSE);title('MSE with increasing k values');
end