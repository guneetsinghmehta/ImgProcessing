function[w]=haar_Llevel(f,steps)
    
    s1=size(f,1);
    w=haar_oneLevel(f);
    for k=1:steps-1
        w(1:s1/2,1:s1/2)=haar_oneLevel(w(1:s1/2,1:s1/2));
        s1=s1/2;
    end
    figure(1);clf;imagesc(log(1+abs(w)));axis image;colorbar
end