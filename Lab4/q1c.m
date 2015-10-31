function[]=q1c()
% for variance =0 the output is exactly equal to the input
     if(nargin==0)
       image=imread('CircleSquare.tif');
       n_var=0.05;
    elseif(nargin==1)
        n_var=0.05;
     end
    image=double(image);
    [s1,s2]=size(image);
    
    for i=41:-1:1
        fprintf('%d\n',i);
        n_var(i)=0.1/255.0*(i-1);
       imout=q1b(image,n_var(i),0);
       MSE(i)=MSE_cal(image,imout);
    end
    figure;plot(MSE,n_var);xlabel('Noise Variance');ylabel('MSE');
    display('done');
    
    function[MSE]=MSE_cal(image,imout)
       MSE=0;
        for m=1:s1
           for n=1:s2
               MSE=MSE+(image(m,n)-imout(m,n))^2;
           end
        end
       MSE=MSE/(s1*s2);
    end
end