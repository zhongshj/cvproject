%%
%choose images
%addpath('image_bookshift');
%files=dir('image_bookshift\*.jpg');
%%
%set K matrix
load('data.mat');
K=data.K;
%K=[4687.2,0,1487.7;0,4625.4,1405.1;0,0,1];
%%
XX={};
%im1=files(1).name;
im1=data.img1;
for i=2:2;
    %im2=files(i).name;
    im2=data.img2;
    [R{i-1},C{i-1},XX{i-1}]=reconstruction(im1,im2,K);
end
XXX=[];
for ii=1:size(XX,2)
    XXX=[XXX;XX{ii}];
end
%%
%delete single points

thres=10;
%{
XXX=XXX(XXX(:,1)<thres,:);
XXX=XXX(XXX(:,2)<thres,:);
XXX=XXX(XXX(:,3)<thres,:);

XXX=XXX(XXX(:,1)>-1*thres,:);
XXX=XXX(XXX(:,2)>-1*thres,:);
XXX=XXX(XXX(:,3)>-1*thres,:);
%}
%%
figure
scatter3(XXX(:,2),XXX(:,1),XXX(:,3));
rotate3d on;

