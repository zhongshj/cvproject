addpath('image_dino');
files=dir('image_dino\*.ppm');
K=load('K.mat');
K=K.ans;
XX={};
im1=files(1).name;
for i=2:2;
    im2=files(i).name;
    [P_set{i-1},XX{i-1}]=reconstruction(im1,im2,K);
end
XXX=[];
for ii=1:size(XX,2)
    XXX=[XXX;XX{ii}];
end
figure
scatter3(XXX(:,1),XXX(:,2),XXX(:,3));
rotate3d on;

