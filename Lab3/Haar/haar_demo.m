f = double(phantom(128));

w = haar_oneLevel(f);
f3 = invhaar_oneLevel(w);
display(isa(w(1,1),'integer'));
display(isa(w(1,1),'float'));
display(isa(w(1,1),'double'));
figure(1);clf;imagesc(log(1+abs(w)));axis image;colorbar
figure(3);clf;imagesc([f f3]);axis image;colorbar

w = haar_oneLevel(f);
f2 = invhaar_oneLevel(w);
figure(2);clf;imagesc([f f2]);axis image;colormap gray;colorbar
