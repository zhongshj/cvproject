clear all;
I1 = im2double(imread('bigsur1.jpg'));
I2 = im2double(imread('bigsur2.jpg'));
[frames1, descr1] = sift(rgb2gray(I1), 'Threshold', 0.045);
[frames2, descr2] = sift(rgb2gray(I2), 'Threshold', 0.045);
matches = siftmatch(descr1, descr2);
NN=size(matches,2);
for i=1:NN
    x_1(:,i)=frames1(1:2, matches(1, i));
    x_2(:,i)=frames2(1:2, matches(2, i));
    
end
dx=x_2-x_1;
%Initialize inliers and error
inliers=linspace(1,NN,NN);
best_error=inf;
%RANSAC interations
for inter=1:7
    translation=[];
    N=length(inliers);
    for j=1:N
        translation(:,j)=x_1(:,inliers(j))-x_2(:,inliers(j));
    end
    mean_translation=mean(translation,2);
    error=std(translation(1,:))+std(translation(2,:));
    if(error<best_error)
        best_error=error;
        best_translation=mean_translation;
        best_number=inliers;
    end
    flag=1;
    new_point=[];
    t=[];
    for jjj=1:NN
        if(std([mean_translation(1,1),dx(1,jjj)])+std([mean_translation(2,1),dx(2,jjj)])<error);
            new_point(flag)=jjj; 
            flag=flag+1;
        end
    end
    inliers=new_point;
end
show_panography(I1, I2,best_translation, 'hard');
    


