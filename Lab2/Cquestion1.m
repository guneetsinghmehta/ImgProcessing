function[]=Cquestion1()
    h=[0 0.25 0;0.25 0 0.25;0 0.25 0];
    H=fft2(h);H_abs=abs(H);
    display(h);
    display(H_abs);
end