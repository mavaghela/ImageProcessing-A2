function [refFrame, testFrame, refIndices, testIndices] = q2b()
addpath('./sift');

refImg = imread('reference.png');
refImg = rgb2gray(refImg);
testImg = imread('test.png');
testImg = rgb2gray(testImg);

% detecting keypoints for both images
[refFrame, refDescr] = sift(im2double(refImg));
[testFrame, testDescr] = sift(im2double(testImg));

% calculating distance between points on both images
distance = dist2(refDescr.', testDescr.');
[n, m] = size(distance);
threshold = 0.8;

matches = [];
ratios = [];

% if ratio of distances between two points is less than threshold its a match
[distSort, distIndex] = sort(distance, 2);
for i = 1:n
    closestMatch = distIndex(i,1);
    ratio = distSort(i,1)./distSort(i,2);
    if ratio < threshold
        matches(i) = closestMatch;
        ratios(i) = ratio;
    else
        matches(i) = 0;
        ratios(i) = 1;  % ignore this match
    end
end

[ratioSort, ratioIndex] = sort(ratios);
testMatches = [];
% Getting the top 3 matches
for i = 1:3
    index = ratioIndex(1, i);
    testMatches(index) = matches(index);
end

indices = find(testMatches > 0);

% plotting the matches
imshow(imRef);
hold on;
ref1 = plotsiftframe(refFrame(:, indices(1):indices(1)));
set(ref1,'color','r','linewidth',1);
ref2 = plotsiftframe(refFrame(:, indices(2):indices(2)));
set(ref2,'color','g','linewidth',1);
ref3 = plotsiftframe(refFrame(:, indices(3):indices(3)));
set(ref3,'color','b','linewidth',1);
hold off;

imshow(imTest);
hold on;
test1 = plotsiftframe(fTest(:, testMatches(indices(1)):testMatches(indices(1))));
set(test1,'color','r','linewidth',1);
test2 = plotsiftframe(fTest(:, testMatches(indices(2)):testMatches(indices(2))));
set(test2,'color','g','linewidth',1);
test3 = plotsiftframe(fTest(:, testMatches(indices(3)):testMatches(indices(3))));
set(test3,'color','b','linewidth',1);
hold off;

[refFrame, testFrame, refIndices, testIndices] = [refFrame, testFrame, [indices(1), indices(2), indices(3)], [testMatches(indices(1)), testMatches(indices(2)), testMatches(indices(3))]];
end
