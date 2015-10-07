function[]=random(s)
    a=10;b=1;
    sum2=0;
    for i=1:s
        if(i>a)
       p(i) =2*b*(i-a)*exp(-(i-a)^2/b);
       sum2=sum2+p(i);
        end
    end
    p=p/sum2;
    display(sum(p(:)));
end