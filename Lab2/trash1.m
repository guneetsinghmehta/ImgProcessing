close all;
M = 256;
[x,y] = meshgrid(linspace(-2,2,M));
f1 = rect(y).*rect(5*x);
f2 = imrotate(f1,45,'crop');
figure;imshow(f1);
figure;imshow(f2);
F1=fft2(f1);
F2=fft2(f2);
show_spectrum(F1,'img');
show_spectrum(F2,'img rotated');

mag=imrotate(abs(F1),45,'crop');
phase=imrotate(angle(F1),45);
F3=mag.*phase;
show_spectrum(F3,'spectrum multipled');
% fout=ifft2(F3);
% figure;imshow(uint8(fout));