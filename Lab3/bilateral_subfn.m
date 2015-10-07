function[y]=bilateral_subfn(im,filter_size,diff)
    im=double(im);
    display(size(im));
    [s1,s2]=size(im);
    filter_size=floor(filter_size/2);
    im=padarray(im,[filter_size filter_size]);
    display(size(im));
    %show_image(im);  
    y=im;
    
    for i=filter_size+1:s1+filter_size
        for j=filter_size+1:s2+filter_size
            sum=0;count=1;
           %fprintf('%d %d filter_size=%d',i,j,filter_size);
            for m=i-filter_size:i+filter_size
                for n=j-filter_size:j+filter_size
                    %fprintf('%d %d\n',m,n);pause(0.05);
                    if(abs(im(i,j)-im(m,n))<abs(diff))
                       sum=sum+im(m,n);
                       count=count+1;
                    end
                end
                avg=sum/(count-1);
               % fprintf('sum=%d avg=%d count-1=%d\n',sum,avg,count-1);pause(0.05);
                y(i,j)=avg;
            end
        end
    end
    y=y(filter_size+1:s1+filter_size,filter_size+1:s2+filter_size);
    show_image(y);
end