function[f]=invhaar_Llevel(w,num_steps)
    f=w;
    [s1,s2]=size(w);
    for i=num_steps:-1:1
        s_temp=power(2,i-1);
        %display(s_temp);
        f(1:s1/s_temp,1:s2/s_temp)=invhaar_oneLevel(f(1:s1/s_temp,1:s2/s_temp));
    end
    figure;imagesc(f);
end
