
    M = 256;
    [x,y] = meshgrid(linspace(-2,2,M));
    f1 = rect(y).*rect(5*x);
    f2 = circshift(f1,round([-M/4,M/4]));
    [u,v] = meshgrid(0:(M-1));
 Fx=transform(-0.25,0.25,M,M);
 Fd = fft2(f1).*Fx;
f3 = uint8(real(ifft2(Fd)));
figure;
subplot(1,3,1);imagesc(f1);title('orignal imaeg');
subplot(1,3,2);imagesc(f2);title('shifting in spatial domain');
subplot(1,3,3);imagesc(f3);title('shifting in fourier domain');
figure;imagesc([f1; f2; f3;]);title('three images one below the other');axis image;colormap gray;