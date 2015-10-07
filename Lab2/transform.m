function[F]=transform(a,b,image_size_x,image_size_y)
    %a for percentage of shiftx/image_size_x
    %b for percentage of shifty/image_size_y
    for i=1:image_size_x
        for j=1:image_size_y
            F(i,j)=exp(-1i*2*pi*((i-1)*a+(j-1)*b));
        end
    end
end