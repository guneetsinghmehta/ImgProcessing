% Steps
% 1  read image
% 2 add impulse noise
% 3 add gaussian noise 
% 4 save images
% 5 for each image implement bilateral filters
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
y_gaussian = f + gaussian_noise;

d = 0.05;
y_impulse = imnoise(f/(fmax*a),'salt & pepper',d)*fmax*a;

y_poisson = poissrnd(f);

test=y_impulse;
[s1,s2]=size(f);
show_image(test);

test_result=bilateral_subfn(test,3,50);
