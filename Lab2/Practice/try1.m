im=imread('saturn.png');
F=fft2(im);

%showf function prototype
Fw=abs((F));
[s1,s2]=size(Fw);
%display(size(Fw));
max=Fw(1,1);ix=1;iy=1;
for i=1:s1
    for j=1:s2
        if(Fw(i,j)>max)
           max=Fw(i,j); ix=i;iy=j;
        end
    end
end

Fw2=F;
Fw2(1,1)=0;
imout=uint8(abs(ifft2(Fw2)));
im1=uint8(abs(ifft2(F)));
figure;
subplot(1,2,1);imshow(im1);
subplot(1,2,2);imshow(imout);

%display(max);display(ix);display(iy);

