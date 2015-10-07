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




