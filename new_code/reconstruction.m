function [P_set,X]=reconstruction(im1,im2)
%% read image & sift
I1 = im2double(imread(im1));
I2 = im2double(imread(im2));
%I1 = imresize(I1, [1000,1000]);
%I2 = imresize(I2, [1000,1000]);
%I1 = imrotate(I1, -90);
%I2 = imrotate(I2, -90);
addpath('sift');
%[frames1, descr1] = sift(rgb2gray(I1), 'Threshold', 0.02);
%[frames2, descr2] = sift(rgb2gray(I2), 'Threshold', 0.02);
[frames1, descr1] = sift(I1, 'Threshold', 0.02);
[frames2, descr2] = sift(I2, 'Threshold', 0.02);
descr1 = uint8(512 * descr1);
descr2 = uint8(512 * descr2);
matches = siftmatch(descr1, descr2);
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches);
%% ransac with 8-points
%{
ransac_matches = ransac_ff(frames1(1:2,:), frames2(1:2,:), matches);
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches(:, ransac_matches));
F = eightPoint(frames1(1:2,:), frames2(1:2,:), matches(:, ransac_matches));
%}
%

[F,inliersIndex] = estimateFundamentalMatrix(frames1(1:2, matches(1,:))', frames2(1:2, matches(2,:))');
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches(:, inliersIndex));
%%
%computer essential matrix according to f matrix
K=load('K3.mat');
K=K.K3;
E=EssentialMatrix(F,K);
%%
%calculate the possible C/R set
[C_set,R_set]=CameraPose(E,K);
%%
%calculate the possible 3d locations(X set)
X_set={};
P_set={};
for ii=1:4
    [X_set{ii},P_set{ii}]=Triangulation(K,R_set{ii},C_set{ii},matches(:,inliersIndex),frames1,frames2);
end
%%
%choose the correct camera pose
[C,R,X] = DisambiguateCameraPose(C_set, R_set, X_set);


end