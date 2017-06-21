function [X,P2]=triangulation(K,R,C,matches,frames1,frames2)
P1=K*[eye(3,3),zeros(3,1)];
P2=K*R*[eye(3),-C];
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
end