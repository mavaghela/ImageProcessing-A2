function out = q1a(octave, scale, sigma)
    img = imread('building_1.jpg');
    img = rgb2gray(img);

    k = 2^(1/scale);
    I = img;

    for i = 1:octave
        % Reducing the image per octave
        if(i > 1)
            I = impyramid(I, 'reduce');
        end

        [imgHeight, imgWidth] = size(I);
        imgPyramid = zeros(imgHeight, imgWidth, scale);
        diffPyramid = zeros(imgHeight, imgWidth, scale-1);

      for j = 1:scale
          % Smoothing the image for each scale
          imgPyramid(:,:,j) = imgaussfilt(I,(k^(j-1))*sigma);
          if(j > 1)
              % Taking the difference of gaussians
            diffPyramid(:,:,j-1) = (imgPyramid(:,:,j) - imgPyramid(:,:,j-1));
          end
      end
      
      % Finding all local maxima in particular octave
      localMaxima = [];
      for xPixel = 2:imgHeight-1
          for yPixel = 2:imgWidth-1
              for c = 2:scale-2
                  
                  % Found a local maxima
                  if (findLocalMax(diffPyramid, xPixel, yPixel, c))
                    xCoord = xPixel * (2^(i-1));
                    yCoord = yPixel * (2^(i-1));
                    scaleSigma = scaleSigma * (k^(j-1));
                    localMaxima = [localMaxima, xCoord, yCoord, scaleSigma];
                  end
              end
          end
      end % now you've found all the maxima in this octave
      
      % drawing the points of interest on the image
      [o, maximaSize] = size(localMaxima);
      imshow(img);
      for coord = 1:3:maximaSize
         centers = [localMaxima(coord), localMaxima(coord+1)];
         viscircles(centers, localMaxima(coord+2));
      end
    end
    out = 1;
end
