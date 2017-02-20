function out = q1a(octave, scales, sigma)
    img = imread('building_1.jpg');
    img = rgb2gray(img);

    octave = 4;
    sigma = 0.5;
    scale = 4;
    k = 2^(1/scale);
    I = img;

    for i = 1:octave
     if(i > 1)   
        I = impyramid(I, 'reduce');
     end
      [x,y] = size(I);
      imgPyramid = zeros(x, y, scale);
      diffPyramid = zeros(x, y, scale-1);

      for j = 1:scale
          imgPyramid(:,:,j) = imgaussfilt(I,(k^(j-1))*sigma);
          if(j > 1)
            diffPyramid(:,:,j-1) = (imgPyramid(:,:,j) - imgPyramid(:,:,j-1));
          end
      end
      P = [];
      for a = 2:x-1
          for b = 2:y-1
              for c = 2:scale-2
                    %if this max function returns true then add the x,y,sigma
                    %to a new array and this is also where you translate your
                    %coords by multiplying them to 2^octave-1
                    %and then just look through that and draw it
                  if (findLocalMax(diffPyramid, a, b, c))
                    xCoord = a*(2^(i-1));
                    yCoord = b*(2^(i-1));
                    sigma = sigma*(k^(j-1));
                    P = [P, xCoord, yCoord, sigma];
                  end
              end
          end
      end % now you've found all the maxes
      [o, psize] = size(P);
      imshow(img);
      for coord = 1:3:psize
         centers = [P(coord), P(coord+1)];
         viscircles(centers,P(coord+2));
      end

    % End of the main loop  
    end
    out = 1;
end