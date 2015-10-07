function[y]=trash(im,filter_size,patch_size)
    im=double(im);
%     display(size(im));
    [s1,s2]=size(im);
    filter_size=floor(filter_size/2);
    im=padarray(im,[filter_size filter_size]);
%     display(size(im));
    %pause(10);
    %show_image(im);  
    
    figure;imagesc(im);
    y(1:patch_size,1:patch_size)=0;
    patch_mn(1:filter_size,1:filter_size)=0;
    patch_st(1:filter_size,1:filter_size)=0;
    sy1=filter_size;sy2=filter_size;
    f1=figure;f2=figure;
    for i=filter_size+1:s1+filter_size
        for j=filter_size+1:s2+filter_size
            %crop th image in the region
%             if((i==69+filter_size)&&(j==78+filter_size))
            y=im(i-filter_size:i+filter_size,j-filter_size:j+filter_size);
%             figure;imagesc((y));%pause(10);
            
            patch_mn=y(i-floor(patch_size/2):i+floor(patch_size/2),j-floor(patch_size/2):j+floor(patch_size/2));
%             figure;imagesc(patch_mn);%pause(10);
            
            w(1:filter_size,1:filter_size)=0;
            for m=1+floor(patch_size/2):sy1-floor(patch_size/2)
                for n=1+floor(patch_size/2):sy1-floor(patch_size/2)
                    patch_st=y(m-1:m-1+patch_size-1,n-1:n-1+patch_size-1);
                    display(size(patch_mn));
                    display(size(patch_st));%pause(10);
                end
            end
            figure(f1);
            subplot(2,1,1);imagesc(patch_mn);
            subplot(2,1,2);imagesc(patch_st);
            pause(.1);
        end
    end

end