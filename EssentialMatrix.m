function E=EssentialMatrix(F,K)
E=K'*F*K;
[U S V]=svd(E);
E=U*[1 0 0;0 1 0;0 0 0]*V';
E=E/norm(E);
end