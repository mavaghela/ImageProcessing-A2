img = imread('building_1.jpg');
img = rgb2gray(img);

octave = 5;
sigma = 0.5;
scale = 5;

## Gaussian image pyramid

gFilter = imgaussfilt(img,sigma);
imgPyramid = [];

imgPyramid(1, 1) = imfilter(img, gFilter, 'conv');

for i = 1:octave
  for j = 2:scale
    imgPyramid(i, j) = imfilter(imgPyramid(i-1), gFilter, 'conv');
  end
end
  
## Need to compute difference of gaussians now 
 
## difference of gaussians
 
## gaussian1 = fspecial('Gaussian', 21, 15);
## gaussian2 = fspecial('Gaussian', 21, 20);
## dog = gaussian1 - gaussian2;
## dogFilterImage = conv2(double(grayImage), dog, 'same');