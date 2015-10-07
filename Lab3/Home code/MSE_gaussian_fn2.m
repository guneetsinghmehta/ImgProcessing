function[MSE_avg]=MSE_gaussian_fn2(image,variance)
%faster version
    tic;
    num_iterations=10;MSE_avg=0;
    [s1,s2]=size(image);
    [x1g,x2g]=meshgrid(1:s1,1:s2);
    f=double(image);D0=100;
    MSE(1:num_iterations)=0;
    for k=1:num_iterations
%         fprintf('slice number=%d \n',k);
        g=imnoise(f,'gaussian',0,variance);
        %figure;imshow(g);
        G=fftshift(fft2(g));
%         for i=1:s1
%             for j=1:s2
%                 D=(i-s1/2)^2+(j-s2/2)^2;
%                 H(i,j)=exp(-D^2/(2*D0^2));
%                 F2(i,j)=G(i,j)*H(i,j);
%             end
%         end
        D=(x1g-s1/2)^2+(x2g-s2/2)^2;
        H=exp(-D/(2*D0^2));
        F2=G.*H;
        f2=real(ifft2(fftshift(F2)));
        diff=f-f2;
        MSE(k)=sum(diff(:).*diff(:));
        %figure;imshow(uint8(f2));
    end
    MSE_avg=sum(MSE(:))/num_iterations;
    toc;
end