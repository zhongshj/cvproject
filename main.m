%% read image
I1 = im2double(imread('1.jpg'));
I2 = im2double(imread('2.jpg'));
[frames1, descr1] = sift(rgb2gray(I1), 'Threshold', 0.05);
[frames2, descr2] = sift(rgb2gray(I2), 'Threshold', 0.05);
descr1 = uint8(512 * descr1);
descr2 = uint8(512 * descr2);
matches = siftmatch(descr1, descr2);
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches);

%%