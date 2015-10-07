function [ output_args ] = control( input_args )
%CONTROL Summary of this function goes here
%   Detailed explanation goes here
    image=imread('CircleSquare.tif');
    if(size(image,3)==3),image=rgb2gray(image); end
    variance=0.04;
    
%     MSE_gaussian=MSE_gaussian_fn2(image,variance);
%     display(MSE_gaussian);
%     MSE_gaussian=MSE_gaussian_fn(image,variance);
%     display(MSE_gaussian);
%       MSE_median=MSE_median_fn(image,variance,3);%last argument =3 is the neighborhood size
%       display(MSE_median);
      
%       MSE_bilateral=MSE_bilateral_fn(image,variance,3);
%       display(MSE_bilateral);

    MSE_bilateral=MSE_non_local_mean_fn(image,variance,5,3);
      display(MSE_bilateral);
    
      
end

