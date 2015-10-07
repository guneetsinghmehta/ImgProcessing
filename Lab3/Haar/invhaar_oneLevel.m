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





