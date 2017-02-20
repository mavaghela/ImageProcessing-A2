function out = findLocalMax(diffPyramid, currentX, currentY, currentZ)
    max = 1;
    min = 1;
    out = 1;
    currentPixel = diffPyramid(currentX, currentY, currentZ);

    % filtering bad maximum values
    if (currentPixel > -2 && currentPixel < 2)
        out = 0;
        return;
    end
    
    % checking surrounding pixels for a max or min
    for z = currentZ-1:currentZ+1
        for y = currentY-1:currentY+1
            for x = currentX-1:currentX+1
                
                % don't compare pixel with itself
                if (x == currentX && y == currentY & z == currentZ)
                    break
                end
                
                % current pixel isn't the max
                if (diffPyramid(x,y,z) >= currentPixel)
                    max = 0;
                end
                
                % current pixel isn't the min
                if (diffPyramid(x,y,z) <= currentPixel)
                    min = 0;
                end
                
                if (~min && ~max)
                   out = 0;
                   return;
                end
            end
        end
    end
end
