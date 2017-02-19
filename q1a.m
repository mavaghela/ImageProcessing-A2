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
end