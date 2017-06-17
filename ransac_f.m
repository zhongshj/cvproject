function indexes = ransac_f(frames1, frames2, matches)

matches_num = size(matches, 2);
sample_num = ceil(0.2 * matches_num);

best_inline = 1:sample_num;
best_err = sample_num * 100;

err_threshold = 0.01;



for iter = 1:500
    % select random subset
    %rand_index = randperm(matches_num, sample_num); 
    inliers = rand(1, length(matches)) > .5;
    rand_index = 1:length(matches);
    rand_index = rand_index(inliers);
    
    % solve fundamental matrix
    f = eightPoint(frames1, frames2, matches(:, rand_index));
    %H = find_homography(frames1, frames2, matches(:, rand_index));
    
    % test rest points
    for i = 1:matches_num
        if(any(rand_index ~= i))
            x1 = frames1(1, matches(1, i));
            y1 = frames1(2, matches(1, i));
            x2 = frames2(1, matches(2, i));
            y2 = frames2(2, matches(2, i));
            
            % if error low, consider it to be in the group
            %disp(['disp: ', num2str(sum(([x1, y1, 1] * H - [x2, y2, 1]).^2))])
            if(abs([x1, y1, 1] * f * [x2; y2; 1]) < err_threshold)
                rand_index = [rand_index, i];
            end
        end
    end
    
    % fit model again
    f = eightPoint(frames1, frames2, matches(:, rand_index));

    % cal error
    err = 0;
    for j = 1:size(rand_index, 2)
        err = err + abs([frames1(1, matches(1, rand_index(1, j))), frames1(2, matches(1, rand_index(1, j))), 1]...
            * f * [frames2(1, matches(2, rand_index(1, j))); frames2(2, matches(2, rand_index(1, j))); 1]);
    end
    err = err / size(rand_index, 2);
    
    % update best model(best error && more than half inline)
    if((err < best_err) && (size(rand_index, 2) > 8))
        best_err = err;
        best_inline = rand_index;        
    end
    
    disp(['iter: ', num2str(iter), 'error: ', num2str(best_err)])
    
    
end

indexes = best_inline;

end