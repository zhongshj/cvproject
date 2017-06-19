load('dino_Ps.mat');
kk=P{2}*pinv(P{1});
P0=pinv(pinv(P{1})*kk);
a=[eye(3,3),zeros(3,1)];
K3=P0*pinv(a);
