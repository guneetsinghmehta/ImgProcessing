M = 256;
[x,y] = meshgrid(linspace(-2,2,M));
f1 = rect(y).*rect(5*x);
f2 = imrotate(f1,45,'crop');
F1 = fftshift(fft2(fftshift(f1)));
F3 = fftshift(imrotate(F1,45,'crop'));
f3 = fftshift(abs(ifft2(F3)));
figure;imshow(uint8(abs(F1)));
figure;imshow(uint8(abs(fftshift(F3))));
figure(1);imagesc([f1; f2; f3]);axis image;colorbar;


% close all;clc;
%    M = 256;
% [x,y] = meshgrid(linspace(-2,2,M));
% f1 = rect(y).*rect(5*x);
% ftest(1:M,1:M)=uint8(255);
% ftest_op=imrotate(ftest,45,'crop');
% f2 = imrotate(f1,45,'crop');
% figure;imshow(log(1+abs(fftshift(fft2(ftest_op)))));
% 
% figure;imshow(log(1+abs(fftshift(fft2(f1)))));
% figure;imshow(log(1+abs(fftshift(fft2(f2)))));pause(5);
% 
% F1=fft2(f1);
% Fd=transform2(M,M);
% F3=F1*Fd;
% figure;imshow(log(1+abs(fftshift(fft2(f3)))));pause(5);
% f3=uint8(abs(ifft2(F3)));
% figure;
% subplot(1,3,1);imagesc(f1);
% subplot(1,3,2);imagesc(f2);
% subplot(1,3,3);imagesc(f3);
% figure;imagesc([f1; f2; f3;]);axis image;colormap gray;
