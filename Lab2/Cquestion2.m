im=imread('barbara.png');
F=fftshift(fft2(im));
[s1,s2]=size(im);
border=10;
im2=padarray(im,[s1+border,s2+border]);
im2=padarray(im,[border,border]);

F2=fftshift(fft2(im2));
figure;
subplot(1,2,1);imagesc(log(1+abs(F)));colorbar;
subplot(1,2,2);imagesc(log(1+abs(F2)));colorbar;