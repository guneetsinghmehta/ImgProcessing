function[]=q2a(variance)
    image=imread('CircleSquare.tif');
    MSE(1:10)=0;x(1:10)=0;
    for i=1:10
       D0=i*5;
       MSE(i)=MSE_gaussian_fn2(image,variance,D0);
       x(i)=i;
    end
    figure;plot(x,MSE);
end

function[MSE_avg]=MSE_gaussian_fn2(image,variance,D0)
    f=double(image);
    Imax=max(f(:));f=f/Imax;
    
    g=imnoise(f,'gaussian',0,variance);
    
    
end