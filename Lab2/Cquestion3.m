im=imread('barbara.png');
F=fftshift(fft2(im));
[s1,s2]=size(im);

imout
for i=1:s1
    for j=1:s2
        factor=mod(i+j,2);
        imout(i,j)=(-1)^factor*
    end
end

F2=fftshift(fft2(im2));
figure;
subplot(1,2,1);imagesc(log(1+abs(F)));colorbar;
subplot(1,2,2);imagesc(log(1+abs(F2)));colorbar;