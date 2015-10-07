im=imread('saturn.png');
F=fft2(im);
F=fftshift(F);
[s1,s2]=size(im);

%for h
for D0=10:30:300
H(1:s1,1:s2)=1;

xc=floor(s1/2);yc=floor(s2/2);
for i=1:s1
    for j=1:s2
      D=sqrt((i-xc)^2+(j-yc)^2);
      if(D>D0)
         H(i,j)=0; 
      end
    end
end

G=F.*H;
% showf(G);
% showf(F);
imout=uint8(ifft2(G));
%figure;imshow(im);title('orignal image');

figure;imshow(imout);title(['lowpass filtered image D0= ' num2str(D0)]);
end