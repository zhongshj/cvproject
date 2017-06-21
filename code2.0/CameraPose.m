function [C_set,R_set]=CameraPose(E)
C_set={};
R_set={};
[U D V]=svd(E);
W=[0 -1 0;1 0 0;0 0 1];
c1=U(:,3);
r1=U*W*V';
if(det(r1)==-1)
    C_set{1}=-c1;
    R_set{1}=-r1;
else
    C_set{1}=c1;
    R_set{1}=r1;
end
c2=-U(:,3);
r2=U*W*V';
if(det(r2)==-1)
    C_set{2}=-c2;
    R_set{2}=-r2;
else
    C_set{2}=c2;
    R_set{2}=r2;
end
c3=U(:,3);
r3=U*W'*V';
if (det(r3)==-1)
    C_set{3}=-c3;
    R_set{3}=-r3;
else
    C_set{3}=c3;
    R_set{3}=r3;
end
c4=-U(:,3);
r4=U*W'*V';
if (det(r4)==-1)
    C_set{4}=-c4;
    R_set{4}=-r4;
else
    C_set{4}=c4;
    R_set{4}=r4;
end

end