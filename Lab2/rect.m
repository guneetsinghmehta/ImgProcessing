function[result]=rect(x)
       s1=size(x,1);s2=size(x,2);
       result(1:s1,1:s2)=0;
       for i=1:s1
           for j=1:s2
                if(abs(x(i,j))<=0.5)
                    result(i,j)=1;
                end
           end
       end
       
 end