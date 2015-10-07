function[imout]=non_local_means(im,filter_size,patch_size)
    im=double(im);
    imout=im;
    patch_diff_threshold=1000;
%     display(size(im));
    [s1,s2]=size(im);
    %filter_size=floor(filter_size/2);
    im=padarray(im,[floor(filter_size/2) floor(filter_size/2)]);
%     display(size(im));
    %pause(10);
    %show_image(im);  
    
    figure;imagesc(im);
    
    %f1=figure;f2=figure;
    
    for i=floor(filter_size/2)+1:s1+floor(filter_size/2)
        for j=floor(filter_size/2)+1:s2+floor(filter_size/2)
            %crop th image in the region
            y=im(i-floor(filter_size/2):i+floor(filter_size/2),j-floor(filter_size/2):j+floor(filter_size/2));

            %find the center patch_mn
            diff_sum=0;
            w(1:filter_size,1:filter_size)=0;
            patch_mn=y(floor(filter_size/2)+1-floor(patch_size/2):floor(filter_size/2)+1+floor(patch_size/2),floor(filter_size/2)+1-floor(patch_size/2):floor(filter_size/2)+1+floor(patch_size/2));
            new_value=0;count=0;
            for s=-floor(filter_size/2-patch_size/2):floor(filter_size/2-patch_size/2)
                for t=-floor(filter_size/2-patch_size/2):floor(filter_size/2-patch_size/2)
                    patch_st=y(s+floor(filter_size/2)+1-floor(patch_size/2):s+floor(filter_size/2)+1+floor(patch_size/2),t+floor(filter_size/2)+1-floor(patch_size/2):t+floor(filter_size/2)+1+floor(patch_size/2));
                    diff=abs(patch_st-patch_mn);
                    diff_sum=sum(diff(:));
                    %display(diff_sum);
                    if(diff_sum<patch_diff_threshold)
                        w(s+floor(filter_size/2),t+floor(filter_size/2))=1;
                        new_value=new_value+y(s+floor(filter_size/2)+1,t+floor(filter_size/2)+1);
                        count=count+1;
                    end
                end
            end
            imout(i,j)=new_value/count;
%             display(w);%
            %pause(5);
        end
    end
    figure;imagesc(imout);
end