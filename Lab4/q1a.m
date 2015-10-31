function[]=q1a(f)
    filter_variance=10;noise_variance=0.05;
    F=fftshift(fft2(f));
    [s1,s2]=size(f);
    h=fspecial('gaussian',[s1,s2],filter_variance);
    H=fftshift(fft2(h));
    figure;imagesc(log(1+abs(H)));colorbar;title('H');
    temp=f;temp(:,:)=0;
    e=imnoise(temp,'gaussian',noise_variance);
    E=fftshift(fft2(e));
    figure;imagesc(log(1+abs(E)));colorbar;title('E');
    G=F.*H+E;
    g=ifft2(fftshift(G));
    figure;imagesc(log(1+abs(G)));colorbar;title('G');
    figure;imagesc(log(1+abs(F)));colorbar;title('F');
    
    figure;subplot(1,2,1);imagesc(f);colorbar;
    subplot(1,2,2);imagesc(g);colorbar;
%     figure;imagesc(f);colorbar;
%     figure;imagesc(g);colorbar;
%     e1=imnoise(f,'gaussian',noise_variance);figure;imagesc(e1);colorbar;
end