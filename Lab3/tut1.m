f = double(imread('CircleSquare.tif')) + 10;
fmin = min(f(:));
fmax = max(f(:));
I = 100;
a = 1.1;
f = f/fmax*I;
fmin = 0;
fmax = max(f(:));

snr = 100; % = I^2/sigma^2
sigma = sqrt(I^2/snr);
gaussian_noise = randn(size(f))*sigma;
d = 0.05;
y_gaussian = f + gaussian_noise;
y_impulse = imnoise(f/(fmax*a),'salt & pepper',d)*fmax*a;
y_poisson = poissrnd(f);


figure(1);clf
subplot(221);imagesc(f,[fmin,fmax*a]);title('original');
axis image;colormap gray;axis off

subplot(222);imagesc(y_gaussian,[fmin,fmax*a]);title('Gaussian noise');
axis image;colormap gray;axis off

subplot(223);imagesc(y_impulse,[fmin,fmax*a]);title('Salt & Pepper noise');
axis image;colormap gray;axis off

subplot(224);imagesc(y_poisson,[fmin,fmax*a]);title('Poisson noise');
axis image;colormap gray;axis off
linkaxes

[counts,bins] = hist(y_gaussian(:),100);
figure(2);clf;
subplot(221);hist(f(:),bins);title('original');
subplot(222);hist(y_gaussian(:),bins);title('Gaussian noise');
subplot(223);hist(y_impulse(:),bins);title('Salt & Pepper noise');
subplot(224);hist(y_poisson(:),bins);title('Poisson noise');
