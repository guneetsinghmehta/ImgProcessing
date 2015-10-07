function[]=question3()
    s1=5;s2=5;
    M=3;N=3;
    h(1:s1,1:s2)=0;
    for i=1:s1
        for j=1:s2
            if(abs(i-floor(s1/2)-1)<M/2&&abs(j-floor(s2/2)-1)<N/2)
                h(i,j)=1;
            end
        end
    end
   display(h); 
   H=fft2(h);
   display(abs(H));
end