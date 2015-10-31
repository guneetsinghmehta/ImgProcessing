function[]=q2d_trash(image)
    threshold=100;
    [s1,s2]=size(image);
    imout(1:s1,1:s2)=0;
    f(1:s1,1:s2)=0;
    n_size=7;p_size=3;
    f1=figure;
    f=padarray(f,[floor(n_size/2),floor(n_size/2)]);
    image=padarray(image,[floor(n_size/2),floor(n_size/2)]);
    for m=1+floor(n_size/2):s1+floor(n_size/2)
        for n=1+floor(n_size/2):s1+floor(n_size/2)
            sub_g=f(m-floor(n_size/2):m+floor(n_size/2),n-floor(n_size/2):n+floor(n_size/2));
            patch_mn=image(m-floor(p_size/2):m+floor(p_size/2),n-floor(p_size/2):n+floor(p_size/2));
            
           % f(m-floor(p_size/2):m+floor(p_size/2),n-floor(p_size/2):n+floor(p_size/2))=1;
           f(m-floor(n_size/2):m+floor(n_size/2),n-floor(n_size/2):n+floor(n_size/2))=2; 
           f(m-floor(p_size/2):m+floor(p_size/2),n-floor(p_size/2):n+floor(p_size/2))=4;
%            figure(f1);imagesc(f);pause(0.1);
           sum=0;count=0;
            for s=1+floor(p_size/2):n_size-floor(p_size/2)
                for t=1+floor(p_size/2):n_size-floor(p_size/2)
                    a=m-1-floor(n_size/2);b=n-1-floor(n_size/2);
                    f(a+s-floor(p_size/2):a+s+floor(p_size/2),b+t-floor(p_size/2):b+t+floor(p_size/2))=1;
                    patch_st=image(a+s-floor(p_size/2):a+s+floor(p_size/2),b+t-floor(p_size/2):b+t+floor(p_size/2));
                    diff=abs(patch_mn-patch_st);
%                     display(size(diff));pause(10);
                    if(diff(:).*diff(:)<threshold)
                       sum=sum+image(a+s,b+t);count=count+1; 
                    end
%                     figure(f1);imagesc(f);pause(0.01);
                end
            end
            imout(m,n)=sum/count;
        end
    end
    
    figure;imagesc(image);
    figure;imagesc(imout);
end