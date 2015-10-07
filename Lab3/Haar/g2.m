function[f]=inhaar_Llevel(w,num_steps)
%     
% steps=7;% log2(128)
% 
% w2=double(w);
% for i=1:steps
%     w2(1:power(2,i),1:power(2,i))=inhaar_oneLevel(w2(1:power(2,i),1:power(2,i)));
% end
% figure(3);clf;imagesc(w2);axis image;colorbar
    f=0;display(num_steps);
end
