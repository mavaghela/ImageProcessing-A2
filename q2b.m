addpath('./sift');

refImg = imread('reference.png');
refImg = rgb2gray(refImg);
testImg = imread('test.png');
testImg = rgb2gray(testImg);
 
[refFrame, refDescr] = sift(im2double(refImg));
[testFrame, testDescr] = sift(im2double(testImg));
 
% find matches
distance = dist2(refDescr.', testDescr.');
[n, m] = size(distance);
threshold = 0.8;

matches = [];
ratios = [];
 
% calculate ratios and closest matches
[distSort, distIndex] = sort(distance, 2);
for i = 1:n
    v_closest = distIndex(i,1);
    ratio = distSort(i,1)./distSort(i,2);
    if ratio < threshold
        matches(i) = v_closest;
        ratios(i) = ratio;
    end
end
 
[ratioSort, ratioIndex] = sort(ratios);
top = [];
for i = 1:3
    index = ratioIndex(1, i);
    top(index) = matches(index);
end
 
indices = find(top > 0);
 
% Plot images
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
test1 = plotsiftframe(fTest(:, top(indices(1)):top(indices(1))));
set(test1,'color','r','linewidth',1);
test2 = plotsiftframe(fTest(:, top(indices(2)):top(indices(2))));
set(test2,'color','g','linewidth',1);
test3 = plotsiftframe(fTest(:, top(indices(3)):top(indices(3))));
set(test3,'color','b','linewidth',1);
hold off;