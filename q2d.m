function out = a2q2d()

refImg = imread('reference.png');
testImg = imread('test.png');
[h, w] = size(imRef);

% getting edges for parallelogram
P = [1, 1, 0, 0, 1, 0; 0, 0, 1, 1, 0, 1;
     1, h, 0, 0, 1, 0; 0, 0, 1, h, 0, 1;
     w, 1, 0, 0, 1, 0; 0, 0, w, 1, 0, 1;
     w, h, 0, 0, 1, 0; 0, 0, w, h, 0, 1;]

% computing affine transformation
affine = q2c();
PP = P*affine;

imshow(testImg);
hold on;
line([PP(1), PP(3)],[PP(2),PP(4)],'Color','y', 'Linewidth', 2);
line([PP(1), PP(5)],[PP(2),PP(6)],'Color','y', 'Linewidth', 2);
line([PP(3), PP(7)],[PP(4),PP(8)],'Color','y', 'Linewidth', 2);
line([PP(5), PP(7)],[PP(6),PP(8)],'Color','y', 'Linewidth', 2);
hold off;
end
