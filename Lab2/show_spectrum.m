function[]=show_spectrum(F1,str)
    figure;
    imshow(uint8(log(1+abs(fftshift(F1)))));
    title(str);
end