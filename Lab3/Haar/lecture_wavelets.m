% f = phantom(256)*255;
f = double(imread('cameraman.png'));
noise = randn(size(f))*20;

y = f+noise;

figure(1);clf;
subplot(231);imagesc(f,[-30,255]);title('f');
subplot(232);imagesc(noise,[-30,255]);title('noise');
subplot(233);imagesc(y,[-30,255]);title('y');

F = fftshift(fft2(f));
Noise = fftshift(fft2(noise));
Y = fftshift(fft2(y));

subplot(234);imagesc(log(1+abs(F)),[0,15]);title('F');
subplot(235);imagesc(log(1+abs(Noise)),[0,15]);title('Noise');
subplot(236);imagesc(log(1+abs(Y)),[0,15]);title('Y');

%%

tau = prctile(abs(Y(:)),70);
f2 = real(ifft2(fftshift(F.*(abs(F)>tau))));
noise2 = real(ifft2(fftshift(Noise.*(abs(Noise)>tau))));
y2 = real(ifft2(fftshift(Y.*(abs(Y)>tau))));

figure(3);clf;
subplot(231);bimagesc(f,[-30,255]);title('f');
subplot(232);bimagesc(noise,[-30,255]);title('noise');
subplot(233);bimagesc(y,[-30,255]);title(['y, mse = ' num2str(mean((f(:)-y(:)).^2))]);

subplot(234);bimagesc(f2,[-30,255]);title(['f2, mse = ' num2str(mean((f(:)-f2(:)).^2))]);
subplot(235);bimagesc(noise2,[-30,255]);title(['noise2']);
subplot(236);bimagesc(y2,[-30,255]);title(['y2, mse = ' num2str(mean((f(:)-y2(:)).^2))]);



%%

L = 5;
wf = haar_LLevel(f,L);
wn = haar_LLevel(noise,L);
wy = haar_LLevel(y,L);

figure(2);clf;
subplot(231);bimagesc(f,[-30,255]);title('f');
subplot(232);bimagesc(noise,[-30,255]);title('noise');
subplot(233);bimagesc(y,[-30,255]);title('y');

subplot(234);bimagesc(log(1+abs(wf)),[0,15]);title('wf');
subplot(235);bimagesc(log(1+abs(wn)),[0,15]);title('wn');
subplot(236);bimagesc(log(1+abs(wy)),[0,15]);title('wy');


tau = prctile(abs(wy(:)),90);
f3 = invhaar_LLevel(wf.*(abs(wf)>tau),L);
noise3 = invhaar_LLevel(wn.*(abs(wn)>tau),L);
y3 = invhaar_LLevel(wy.*(abs(wy)>tau),L);


figure(4);clf;
subplot(231);bimagesc(f,[-30,255]);title('f');
subplot(232);bimagesc(noise,[-30,255]);title('noise');
subplot(233);bimagesc(y,[-30,255]);title(['y, mse = ' num2str(mean((f(:)-y(:)).^2))]);

subplot(234);bimagesc(f3,[-30,255]);title(['f3, mse = ' num2str(mean((f(:)-f3(:)).^2))]);
subplot(235);bimagesc(noise3,[-30,255]);title(['noise3']);
subplot(236);bimagesc(y3,[-30,255]);title(['y3, mse = ' num2str(mean((f(:)-y3(:)).^2))]);

figure(31);clf
semilogy(sort(abs(F(:)),'descend'),'LineWidth',3)
hold on
semilogy(sort(abs(wf(:)),'descend'),'LineWidth',3)
legend('Fourier coeffs.','Wavelet coeffs.');