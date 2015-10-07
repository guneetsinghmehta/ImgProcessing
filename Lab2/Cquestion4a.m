image=imread('hand.tif');
if(size(im,3)==3)
   image=rgb2gray(image); 
end
[s1,s2]=size(image);
F=fftshift(fft2(image));
F2=F;
D0=25;
for i=1:s1
    for j=1:s2
      D=sqrt((i-floor(s1/2))^2+(j-floor(s2/2))^2);
      factor=exp(-D^2/(D0)^2);
      F2(i,j)=factor*(F(i,j));
    end
end
y2=uint8(abs(ifft2(F2)));
figure;imagesc(y2);%pause(5);
F3=F2;
for i=1:s1
    for j=1:s2
      D=sqrt((i-floor(s1/2))^2+(j-floor(s2/2))^2);
      factor=1-exp(-D^2/(D0)^2);
      F3(i,j)=factor*(F2(i,j));
    end
end

y3=uint8(abs(ifft2(F3)));
figure;
subplot(1,2,1);imagesc(image);title('orignal');
subplot(1,2,2);imagesc(y3);title('reconstructed');
