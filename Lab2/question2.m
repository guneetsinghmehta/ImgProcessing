function[]=question2()
    s1=5;s2=5;
   gaussian=fspecial('gaussian',[s1,s2],0.5);
   display(gaussian);
    F_gaussian=fft2(gaussian);
    F_gaussian_mag=abs(F_gaussian);
    display(F_gaussian_mag);
end
% Obs 1 -The resultant magnitude matrix gives more weight to lower frequency
% coefficients, thus the Gaussian filter has an effect similar to low pass
% filter.
% Obs 2 -The resultant magnitude matrix of Gaussian filter is also symmetric