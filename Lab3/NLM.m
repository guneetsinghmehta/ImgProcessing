function y = NLM(x,hx,hy)
% hx and hy are even
[M,N] = size(x);
S1 = floor(hx/2);
S2 = floor(hy/2);
hx = 2*S1+1;
hy = 2*S2+1;

y =x;
x = padarray(x,[S1,S2],'symmetric','both');
figure;image(uint8(x));
patch_dim=3;
for m = 1:M
   for n = 1:N
      patch = x(m:(m+hx-1),n:(n+hy-1));
      %w = ...
      %my code starts
      w(1:hx,1:hy)=0;
         for i=floor(patch_dim/2)+1:hx-floor(patch_dim/2)
             for j=floor(patch_dim/2)+1:hy-floor(patch_dim/2)
                 patch_mn=patch(m-1+hx+1-floor(patch_dim/2):m-1+hx+1+floor(patch_dim/2));
                 patch_st=patch(hx+1-floor(patch_dim/2):hx+1+floor(patch_dim/2));    
             end
         end
   
      %my code ends
      y(m,n) = w(:)'*patch(:)/sum(w(:));
   end
end