function [C R X] = DisambiguateCameraPose(C_set, R_set, X_set)
%%
%{
for i = 1 : length(C_set)
   D = R_set{i}*(X_set{i}'-C_set{i}*ones(1,size(X_set{i},1)));
   n(i) = length(find(D(3,:)>0 & X_set{i}(:,3)'>0));
   n
end
%%
[maxn, maxi] = max(n);
C = C_set{maxi};
R = R_set{maxi};
X = X_set{maxi};
%}
%%
for i=1:size(C_set,2)
    px=X_set{i}';
    flag=0;
    for ii=1:size(px,2)
        if (R_set{i}(3,:)*(px(:,ii)-C_set{i})>0)
            flag=flag+1;
        end
    end
    FF(i)=flag;
end
in=find(FF==max(FF));
C=C_set{in};
R=R_set{in};
X=X_set{in};
