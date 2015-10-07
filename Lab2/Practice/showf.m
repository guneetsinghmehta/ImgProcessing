function[Fw]=showf(F)
    [s1,s2]=size(F);
   Fabs=log(1+abs(F));max=Fabs(1,1);
    for i=1:s1
       for j=1:s2
           if(max<Fabs(i,j))
              max=Fabs(i,j); 
           end
       end
    end
   F2=uint8(Fabs/max*255);
   figure;imshow(F2);
   
end