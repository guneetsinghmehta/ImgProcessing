function[F]=transform2(image_size_x,image_size_y)
    %a for percentage of shiftx/image_size_x
    %b for percentage of shifty/image_size_y
    for m=1:image_size_x
        for n=1:image_size_y
            F(m,n)=exp(-1i*pi/4);
        end
    end
    display(exp(-1i*pi/4));
end