function [refFrame, refDescr, testFrame, testDescr] q2a()
addpath('./sift');

refImg = imread('reference.png');
refImg = rgb2gray(refImg);
testImg = imread('test.png');
testImg = rgb2gray(testImg);
 
[refFrame, refDescr] = sift(im2double(refImg));
[testFrame, testDescr] = sift(im2double(testImg));

imshow(refImg);
hold on;
refI = plotsiftframe(refFrame(:,1:100));
set(refI,'color','y','linewidth',1);
hold off;
 
imshow(testImg);
hold on;
testI = plotsiftframe(testFrame(:,1:100));
set(testI,'color','y','linewidth',1) ;
hold off;

[refFrame, refDescr, testFrame, testDescr] = [refFrame, refDescr, testFrame, testDescr];
end