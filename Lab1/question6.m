function[]=question6()
  % Code Taken from - https://ay15-16.moodle.wisc.edu/prod/pluginfile.php/90512/mod_assign/introattachment/0/Lab1.pdf?forcedownload=1
  % code written courtsey to Prof Rebecca Willett, University of Wisconsin
  % Madison
  
  imC=imread('BirdFish.jpg');
  figure(15);
    subplot(221);image(imC/255);axis image;title('orig');
    subplot(222);imagesc(imC(:,:,1),[0,255]);axis image;
    title('red');colormap gray;
    subplot(223);imagesc(imC(:,:,2),[0,255]);axis image;
    title('green');colormap gray;
    subplot(224);imagesc(imC(:,:,3),[0,255]);axis image;
    title('blue');colormap gray;
    linkaxes;
    load cmapRGB
    figure(16);imagesc(imC(:,:,1),[0,255]);axis image;
    title('red');colormap(cmap_red)
    figure(17);imagesc(imC(:,:,2),[0,255]);axis image;
    title('green');colormap(cmap_green)
    figure(18);imagesc(imC(:,:,3),[0,255]);axis image;
    title('blue');colormap(cmap_blue)
end
 