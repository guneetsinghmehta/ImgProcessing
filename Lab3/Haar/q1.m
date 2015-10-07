function [  ] = q1( )
    %finding haar_LLevel
    s_image=128;
    f = double(phantom(s_image));
    w=haar_LLevel(f,log2(s_image));
    figure;imagesc(log(1+abs(w)));colorbar;title('haar wavelet transform');
    f_out=invhaar_LLevel(w,log2(s_image));
    figure;imagesc(f_out);colorbar;title('Inverse Haar wavelet Transform');
    
end

function[w]=haar_LLevel(f,steps)
    s1=size(f,1);
    w=haar_oneLevel(f);
    for k=1:steps-1
        w(1:s1/2,1:s1/2)=haar_oneLevel(w(1:s1/2,1:s1/2));
        s1=s1/2;
    end
    
end

function w = haar_oneLevel(x)
    [M,N] = size(x);
    if M~=N
       error('image must be square');
    end

    if 2^round(log2(M))~=M
       error('sidelength must be power of two');
    end

    h00 = [1 1; 1 1]/2;
    h01 = [-1 1; -1 1]/2;
    h10 = [-1 -1; 1 1]/2;
    h11 = [1 -1; -1 1]/2;

    w00 = conv2(x,h00,'same');
    w00 = w00(1:2:end,1:2:end);

    w01 = conv2(x,h01,'same');
    w01 = w01(1:2:end,1:2:end);

    w10 = conv2(x,h10,'same');
    w10 = w10(1:2:end,1:2:end);

    w11 = conv2(x,h11,'same');
    w11 = w11(1:2:end,1:2:end);

    w = [w00 w01; w10 w11];

end

function [x] = invhaar_oneLevel(w)

[M,N] = size(w);
if M~=N
   error('image must be square');
end

if 2^round(log2(M))~=M
   error('sidelength must be power of two');
end

wup = kron(w,[0 0; 0 1]);

h00 = [1 1; 1 1]/2;
h01 = [1 -1; 1 -1]/2;
h10 = [1 1; -1 -1]/2;
h11 = [1 -1; -1 1]/2;


w00 = wup(1:M,1:M);
x00 = conv2(w00,h00,'same');

w01 = wup(1:M,((1:M)+M));
x01 = conv2(w01,h01,'same');

w10 = wup(((1:M)+M),1:M);
x10 = conv2(w10,h10,'same');

w11 = wup(((1:M)+M),((1:M)+M));
x11 = conv2(w11,h11,'same');

x = (x00+x01+x10+x11);
end

function[f]=invhaar_LLevel(w,num_steps)
    f=w;
    [s1,s2]=size(w);
    for i=num_steps:-1:1
        s_temp=power(2,i-1);
        %display(s_temp);
        f(1:s1/s_temp,1:s2/s_temp)=invhaar_oneLevel(f(1:s1/s_temp,1:s2/s_temp));
    end
    
end






