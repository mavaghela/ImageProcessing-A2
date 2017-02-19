function out q2c()

addpath('./sift');
[refFrame, testFrame, refIndices, testIndices] = q2b();

refPoints = [refFrame(1:2, refIndices(1):refIndices(1)), refFrame(1:2,refIndices(2):refIndices(2)), refFrame  (1:2, refIndices(3):refIndices(3))];
testPoints = [testFrame(1:2, testIndices(1):testIndices(1)), testFrame(1:2, testIndices(2):testIndices(2)), testFrame(1:2, testIndices(3):testIndices(3))];

## building the [x y 0 0 1 0; 0 0 x y 0 1] matrix for reference for 3 points
r1a = [refPoints(1, 1), refPoints(2, 1), 0, 0, 1, 0];
r1b = [0, 0, refPoints(1, 1), refPoints(2, 1), 0, 1];

r2a = [refPoints(1, 2), refPoints(2, 2), 0, 0, 1, 0];
r2b = [0, 0, refPoints(1, 2), refPoints(2, 2), 0, 1];

r3a = [refPoints(1, 3), refPoints(2, 3), 0, 0, 1, 0];
r3b = [0, 0, refPoints(1, 3), refPoints(2, 3), 0, 1];

P = [r1a; r1b; r2a; r2b; r3a; r3b];

 ## build the [x;y] matrix for test 3 points
pPrime = [testPoints(1,1); testPoints(2,1); testPoints(1,2); testPoints(2,2); testPoints(1,3); testPoints(2,3)];

# computing the (p^-1)*p
out = inv(P)*pPrime;
end
    