function[]=rayleigh_noise(a,b,s1,s2)
    b=1;
    a=0;
    %s1=5;s2=5;
    random=randi(255,[s1,s2]);
    max_value=max(abs(random(:)));
    random=floor(random*255/max_value);
    noise(1:s1,1:s2)=0;
    for i=1:s1
        for j=1:s2
            if random(i,j)-a>0
            noise(i,j)=2/b*(random(i,j)-a)*exp(-(random(i,j)-a)^2/b);
            else
                noise(i,j)=0;
            end
        end
    end
    display(noise);
    display(sum(noise(:)));
end