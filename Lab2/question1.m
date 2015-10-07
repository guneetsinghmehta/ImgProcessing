function[]=question1()
    s1=3;s2=3;
    delta(1:s1,1:s2)=0;
    delta(1,1)=1;
    D=fft2(delta);
    display(abs(D));
end
% the DFT of an impulse function is a matrix with constant real value like
% a 3X3 Matrix consisting of all 1s
% Reason - All terms in the DFT resolve to Summation of first term of
% impulse matrix(1)X1+0*(exponentials) = 1*impulse(0,0)=1