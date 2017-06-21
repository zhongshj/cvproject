%%
%choose images
addpath('cups');
files=dir('cups\*.jpg');
%%
%set K matrix
K=[4687.2,0,1487.7;0,4625.4,1405.1;0,0,1];
%%
XX={};
im1=files(1).name;
for i=2:2;
    im2=files(i).name;
    [R{i-1},C{i-1},XX{i-1}]=reconstruction(im1,im2,K);
end
XXX=[];
for ii=1:size(XX,2)
    XXX=[XXX;XX{ii}];
end
%%
%delete single points
%{
thres=0;
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

