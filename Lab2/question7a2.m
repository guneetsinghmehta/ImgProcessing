function[]=question7a2()
image=imread('cameraman.png');k=1000;
    % using the k highest coefficients  in DFT
    show_figs=1;
    F=fft2(image);
    [s1,s2]=size(image);
    temp=k;
    mag=abs(F);phase=angle(F);
    a(1:s1*s2)=0;
    
    mags=sort(mag(:),'descend');
    k_threshold=mags(k+1);
    mag2=mag;
    for i=1:s1
        for j=1:s2
            if(mag2(i,j)<k_threshold)
               mag2(i,j)=0;
            end
        end
    end
    F2=mag2.*exp(1i*phase);imout=uint8(ifft2(F2));
    if(show_figs==1)
        figure;
        subplot(1,2,1);imshow(image);title('orignal image');
        subplot(1,2,2);imshow(imout);title('reconstructed image');
    end
    imout=double(imout);
end