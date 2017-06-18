addpath('images');
load('data.mat');
files=dir('E:\Delft\TU Delft\Q4\Computer Vision\Project\images\*.ppm');
XX={};
for i=2:2;
    im2=files(i+1).name;
    XX{i-1}=reconstruction(im1,im2);
end
XXX=[];
for ii=1:size(XX,2)
    XXX=[XXX;XX{1}];
end

