function[MSE_avg]=MSE_non_local_mean_fn(image,variance, neighborhood_size,window_size)
    tic;
    intensity_cutoff=100;
    patch_dist=40000;
    num_iterations=1;MSE_avg=0;
    [s1,s2]=size(image);
    f=double(image);
    MSE(1:num_iterations)=0;
    %neighborhood_size=3;
    f2(1:s1+2*floor(neighborhood_size/2),1:s2+2*floor(neighborhood_size/2))=0;
    
    for k=1:num_iterations
        fprintf('slice number=%d \n',k);
        g=imnoise(f,'gaussian',0,variance);
      figure;imshow(g);
        g=padarray(g,[floor(neighborhood_size/2),floor(neighborhood_size/2)],'symmetric');
      
      
        for m=1+floor(neighborhood_size/2):s1+floor(neighborhood_size/2)
            for n=1+floor(neighborhood_size/2):s2+floor(neighborhood_size/2)
                sub_g=g(m-floor(neighborhood_size/2):m+floor(neighborhood_size/2),n-floor(neighborhood_size/2):n+floor(neighborhood_size/2));
                patch_mn=g(m-floor(window_size/2):m+floor(window_size/2),n-floor(window_size/2):n+floor(window_size/2));
                sum_total=0;count=0;
                for s=1+floor(window_size/2):neighborhood_size+floor(window_size/2)
                    for t=1+floor(window_size/2):neighborhood_size+floor(window_size/2)
                        patch_st=sub_g(s-floor(window_size/2):s+floor(window_size/2),t-floor(window_size/2):t+floor(window_size/2));
                        diff=patch_mn-patch_st;
%                         display(diff);
                        %kip=diff(:).*diff(:);
%                         display(diff(:).*diff(:));
%                         display(sum(kip));pause(5);
                        if(sum(diff(:).*diff(:))<patch_dist)
                           sum_total=sum_total+g(s,t);count=count+1; 
                        end
                    end
                end
                f2(m,n)=sum_total/count;
                
            end
        end
        f2=f2(1+floor(neighborhood_size/2):s1+floor(neighborhood_size/2),1+floor(neighborhood_size/2):s2+floor(neighborhood_size/2));
        display(size(f2));
        diff=f-f2;
        MSE(k)=sum(diff(:).*diff(:));
        figure;imshow(uint8(f2));pause(5);
    end
    MSE_avg=sum(MSE(:))/num_iterations;
    toc;
end