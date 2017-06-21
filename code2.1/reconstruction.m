function [R,C,X]=reconstruction(im1,im2,K)
%% read image & sift
%addpath('mummy');
%files=dir('mummy\*.jpg');
%K=[6704.926882,0.6906, 838.251932;0,6705.241311,857.560286;0,0,1];
%im1=files(1).name;
%im2=files(2).name;
%%
%I1 = im2double(imread(im1));
%I2 = im2double(imread(im2));
I1=im2double(im1);
I2=im2double(im2);
addpath('sift');
[frames1, descr1] = sift(rgb2gray(I1), 'Threshold', 0.02);
[frames2, descr2] = sift(rgb2gray(I2), 'Threshold', 0.02);
descr1 = uint8(512 * descr1);
descr2 = uint8(512 * descr2);
matches = siftmatch(descr1, descr2);
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches);
%% ransac with 8-points
%{
inliersIndex = ransac_ff(frames1(1:2,:), frames2(1:2,:), matches);
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches(:, inliersIndex));
F = eightPoint(frames1(1:2,:), frames2(1:2,:), matches(:, inliersIndex));
%}

[F,inliersIndex] = estimateFundamentalMatrix(frames1(1:2, matches(1,:))', frames2(1:2, matches(2,:))');
plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches(:, inliersIndex));

%%
%computer essential matrix according to f matrix
E=EssentialMatrix(F,K);
%%
%calculate the possible C/R set
[C_set,R_set]=CameraPose(E);
%%
%calculate the possible 3d locations(X set)
X_set={};
for ii=1:4
    [X_set{ii}]=Triangulation(K,R_set{ii},C_set{ii},matches(:,inliersIndex),frames1,frames2);
end
%%
%choose the correct camera pose
[C,R,X] = DisambiguateCameraPose(C_set, R_set, X_set);



