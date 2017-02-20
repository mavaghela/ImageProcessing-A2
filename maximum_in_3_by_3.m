function output = maximum_in_3_by_3(matrices, start_x, start_y, start_z)
    maximum = 1;
    minimum = 1;
    comparison_val = matrices(start_x, start_y, start_z);
    for z=start_z-1:start_z+1
        for y=start_y-1:start_y+1
            for x=start_x-1:start_x+1
                if (x==start_x && y == start_y & z==start_z)
                    break
                end
                if matrices(x,y,z) >= comparison_val
                    maximum = 0;
                end
                if matrices(x,y,z) <= comparison_val
                    minimum = 0;
                end
                if (~minimum && ~maximum)
                   output = 0;
                   return;
                end
            end
        end
    end
    if (comparison_val > -2 && comparison_val < 2)
        output = 0;
    else
        output = 1;
    end
    return;
end