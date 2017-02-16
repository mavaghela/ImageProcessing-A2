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

imgDiff = [];

k = 2^(1/scale);

for i = 1:octave
  for j = 1:scale
    # p = (sigma, sigma*k,..., sigma*k^scale -1)
    gaussian1 = fspecial('Gaussian', 10, ((k*(j-1))*sigma));  #G(x,y,p)
    gaussian2 = fspecial('Gaussian', 10, k*((k*(j-1))*sigma)); #G(x,y,kp)
    dog = gaussian2 - gaussian1;
    dogFilterImage = conv2(imgPyramid(i, j), dog, 'same');
    imgDiff(i, j) = dogFilterImage;
  end
end
    
## Need to compute difference of gaussians now 
 
## difference of gaussians
 
## gaussian1 = fspecial('Gaussian', 21, 15);
## gaussian2 = fspecial('Gaussian', 21, 20);
## dog = gaussian1 - gaussian2;
## dogFilterImage = conv2(double(grayImage), dog, 'same');