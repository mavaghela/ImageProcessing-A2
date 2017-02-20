img = imread('building_1.jpg');
img = rgb2gray(img);

octave = 4;
sigma = 0.5;
scale = 4;
k = 2^(1/scale);
I = img;
peaks = [];

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
              if (maximum_in_3_by_3(diffPyramid, a, b, c))
                aa = a*(2^(j-1));
                bb = b*(2^(j-1));
                P = [P, aa, bb, c];
              end
          end
      end
  end % now you've found all the maxes
  [o, psize] = size(P);
  imshow(img);
  for coord = 1:3:psize
     centers = [P(coord), P(coord+1)];
     viscircles(centers,1);
  end

% End of the main loop  
end