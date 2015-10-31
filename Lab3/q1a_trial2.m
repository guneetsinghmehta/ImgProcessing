function[]=q1a_trial2()
    f=double(imread('CircleSquare.tif'));
    noise_variance=0.000025;
    fmax = max(f(:));
    I = 100;
    a = 1.1;
    f = f/fmax;
    e= randn(size(f))*sqrt(noise_variance);
    figure;imagesc(e);colorbar;
    g=f+e;
    g_min=min(g(:));g_max=max(g(:));
    g=g-g_min;g=g/(g_max-g_min);
    figure;imagesc(f);colorbar;
    figure;imagesc(g);colorbar;
end