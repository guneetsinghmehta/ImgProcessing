function[]=show_image(im)
    a=1.1;
    fmin=min(im(:));
    fmax=max(im(:));
    figure;imagesc(im,[fmin,fmax*a]);colormap gray;title('original');


end