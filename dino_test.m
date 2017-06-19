A=load('dino_Ps.mat');
P=A.P;
I1=imread('E:\Delft\TU Delft\Q4\Computer Vision\Project\images3\house.000.pgm');
I2=imread('E:\Delft\TU Delft\Q4\Computer Vision\Project\images3\house.001.pgm');
I3=imread('E:\Delft\TU Delft\Q4\Computer Vision\Project\images3\house.002.pgm');
I5=imread('E:\Delft\TU Delft\Q4\Computer Vision\Project\images3\house.003.pgm');
I6=imread('E:\Delft\TU Delft\Q4\Computer Vision\Project\images3\house.004.pgm');
I1 = im2double(I1);
I4={};
I4{1} = im2double(I2);
I4{2}= im2double(I3);
I4{3}=im2double(I5);
I4{4}=im2double(I6);
XX={};
%I1 = imresize(I1, [1000,1000]);
%I2 = imresize(I2, [1000,1000]);
%I1 = imrotate(I1, -90);
%I2 = imrotate(I2, -90);
for ii=1:4
    [frames1, descr1] = sift(rgb2gray(I1), 'Threshold', 0.02);
    [frames2, descr2] = sift(rgb2gray(I4{4ii}), 'Threshold', 0.02);
    descr1 = uint8(512 * descr1);
    descr2 = uint8(512 * descr2);
    matches = siftmatch(descr1, descr2);
    plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches);
    [F,inliersIndex] = estimateFundamentalMatrix(frames1(1:2, matches(1,:))', frames2(1:2, matches(2,:))');
    plotmatches(I1, I2, frames1(1:2,:), frames2(1:2,:), matches(:, inliersIndex));
    P1=P{1};
    P2=P{2};
    P3=P{3};
    matches=matches(:, inliersIndex);
    for i=1:size(matches,2)
        x1=[frames1(1:2,matches(1,i));1];
        x2=[frames2(1:2,matches(2,i));1];
        skew1=Vec2Skew(x1);
        skew2=Vec2Skew(x2);
        A=[skew1*P1;skew2*P2];
        [u d v]=svd(A);
        X(:,i)=v(:,end)/v(end,end);
    end
    X=X(1:3,:);
    X=X';
    XX{ii}=X;
    X=[];
end
XXX=[];
for iii=1:4
    XXX=[XXX;XX{iii}];
end
figure
scatter3(XXX(:,1),XXX(:,2),XXX(:,3));
rotate3d on