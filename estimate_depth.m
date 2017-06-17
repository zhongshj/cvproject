function depth_plot = estimate_depth(coordinates, im)

im_R = im(:,:,1);
im_G = im(:,:,2);
im_B = im(:,:,3);

X = coordinates(1,:);
X = round(X);
Y = coordinates(2,:);
Y = round(Y);
Z = coordinates(3,:);

% normalize X, Y, Z
Z = Z - min(Z);
Z = Z / max(Z);

X_max = size(im_R, 1);
Y_max = size(im_R, 2);

depth_plot = zeros(X_max, Y_max);
N = 2;

% interpolation
for iter = 1:1000
    X_ip = randperm(X_max, 1);
    Y_ip = randperm(X_max, 1);
    
    if(all(X ~= X_ip) || all(Y ~= Y_ip))
        break
    end
        
    % find neighbors
    idx = knnsearch([X;Y]', [X_ip, Y_ip], N);
    
    % check in middle
    if((X(1, idx(1,1)) - X_ip) * (X(1, idx(1,2)) - X_ip) > 0 ...
            || (Y(1, idx(1,1)) - Y_ip) * (Y(1, idx(1,2)) - Y_ip) > 0)
        break
    end
    
    dis1 = sqrt((X(1, idx(1,1)) - X_ip).^2 + (Y(1, idx(1,1)) - Y_ip).^2);
    dis2 = sqrt((X(1, idx(1,2)) - X_ip).^2 + (Y(1, idx(1,2)) - Y_ip).^2);
    sum_dis = dis1 + dis2;
    intp = (Z(1, idx(1,1)) * dis2 + Z(1, idx(1,2)) * dis1) / sum_dis;
    depth_plot(X_ip, Y_ip) = intp;
    disp(['iter ', num2str(iter), '  depth ', num2str(intp)]);
    
end



end