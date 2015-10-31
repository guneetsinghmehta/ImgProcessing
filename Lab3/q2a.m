function[]=q2a()
        variance=10;
%     Comment - optimum neighborhood for removing gaussian noise is 3*3 size, which results in minimum MSE
%     Thus we choose a 3*3 gaussian filter
    %variance=10;
    for i=1:30
       filter_size(i)=2*i+1;
        MSE(i)=q2_sub(filter_size(i),variance);
        x(i)=i;
    end
    figure;plot(filter_size,MSE);title(['MSE vs filter_size for variance' num2str(variance)]);
end

function[Avg_MSE]=q2_sub(filter_size,variance)
    D0=filter_size;
    f=double(imread('CircleSquare.tif'));
    MSE(1:10)=0;x(1:10)=0;%initialisation 
    fmax = max(f(:));
    I = 100;
    a = 1.1;
    f = f/fmax*I;
    fmin = 0;
    fmax = max(f(:));
    orignal_image=f;
    for i=1:10
       % generating noise
        snr = I^2/variance; % = I^2/sigma^2
        
        sigma = sqrt(I^2/snr);
        gaussian_noise = randn(size(f))*sigma;
        noisy_image=f+gaussian_noise;
       [filtered_image,MSE(i)]=gaussian_filter(noisy_image,orignal_image,D0,sigma);
%        figure;imagesc(f);
%        figure;imagesc(noisy_image);
%        figure;imagesc(filtered_image);title(['MSE=' num2str(MSE)]);
%        pause(20);
       x(i)=i;
    end
    Avg_MSE=sum(MSE(:))/size(MSE,1);
%     fpritnf('Average Error =%f',Avg_MSE);
%     figure;plot(x,MSE);
end

function[imout,MSE]=gaussian_filter(noisy_image,orignal_image,D0,sigma)
    
    f=double(noisy_image);
    h=fspecial('gaussian',D0,double(sigma));
    imout=conv2(f,h,'same');
    diff=orignal_image-imout;
    MSE=sum(diff(:).*diff(:) )/(size(noisy_image,1)*size(noisy_image,2));
end