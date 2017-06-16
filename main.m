%% read image
I1 = im2double(imread('7.jpg'));
I2 = im2double(imread('8.jpg'));
I1 = imresize(I1, [1000,1000]);
I2 = imresize(I2, [1000,1000]);
I1 = imrotate(I1, -90);
I2 = imrotate(I2, -90);
[frames1, descr1] = sift(rgb2gray(I1), 'Threshold', 0.02);
[frames2, descr2] = sift(rgb2gray(I2), 'Threshold', 0.02);
descr1 = uint8(512 * descr1);
descr2 = uint8(512 * descr2);
matches = siftmatch(descr1, descr2);
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches);

%%
ransac_matches = ran(frames1(1:2,:), frames2(1:2,:), matches);
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches(:, ransac_matches));

%%


%%
sample1 = frames1(1:2, matches(1, ransac_index));
sample2 = frames2(1:2, matches(2, ransac_index));
f = eightPoint(sample1(1,:), sample1(2,:), sample2(1,:), sample2(2,:));

err_list = zeros(1, size(ransac_index, 2));
for i = 1:size(ransac_index, 2)
    err_list(1, i) = [sample1(1,i), sample1(2,i),1] * f * [sample2(1,i); sample2(2,i); 1];
end

err_list = abs(err_list);
[err_list, idx] = sort(err_list);
idx = idx(1, 1:8);
eight_index = ransac_index(idx);

%%
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches(:, eight_index));
%%
sample1 = frames1(1:2, matches(1, rand_index));
sample2 = frames2(1:2, matches(2, rand_index));
f = eightPoint(sample1(1,:), sample1(2,:), sample2(1,:), sample2(2,:))
%show_homography(I2, I1, f);
i = 1
%%
[sample1(1,i), sample1(2,i),1] * f * [sample2(1,i); sample2(2,i); 1]
i = i + 1;


