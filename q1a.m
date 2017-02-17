img = imread('building_1.jpg');
img = rgb2gray(img);

octave = 5;
sigma = 0.5;
scale = 5;

## Gaussian image pyramid

imgPyramid = [];
I = img;

for i = 1:octave
  if( i > 1)
    [M, N] = size(I);
    I = imresize(I, 0.5));
  end
  for j = 1:scale
    if(j > 2)
      imgPyramid(i, j) = imgaussfilt(imgPyramid(i, j-1),sigma);
    end
  end
end

imgDiff = [];

k = 2^(1/scale);

for i = 1:octave
  for j = 1:(scale-1)
    # p = (sigma, sigma*k,..., sigma*k^scale -1)
    gaussianImg1 = imgaussfilt(imgPyramid(i, j),((k*(j-1))*sigma)); #G(x,y,p)
    gaussianImg2 = imgaussfilt(imgPyramid(i, j+1),k*((k*(j-1))*sigma)); #G(x,y,kp)
    gaussianDiffImg = imsubtract(gaussianImg2,gaussianImg1);
    imgDiff(i, j) = immultiply(img, gaussianDiffImg);
  end
end
    
## find local maxima in each scale
for i = 1:octave
  for j = 1:(scale-1)
    imgDiff(i, j)
  end
end