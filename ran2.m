function indexes = ran2(frames1, frames2, matches)

matches_num = size(matches, 2);
sample_num = 8;

best_inline = 1:sample_num;
best_err = sample_num * 100;


for iter = 1:1000
    % select random subset
    rand_index = randperm(matches_num, sample_num); 
    
    % solve fundamental matrix
    f = eightPoint(frames1, frames2, matches(:, rand_index));
    %H = find_homography(frames1, frames2, matches(:, rand_index));
    
    % test all points
    err = 0;
    for i = 1:matches_num
        
        x1 = frames1(1, matches(1, i));
        y1 = frames1(2, matches(1, i));
        x2 = frames2(1, matches(2, i));
        y2 = frames2(2, matches(2, i));
       
        err = err + abs([x1,y1,1] * f * [x2;y2;1]);        
    end
    
    % update best model(best error && more than half inline)
    if(err < best_err)
        best_err = err;
        best_inline = rand_index;        
    end
    
    disp(['iter: ', num2str(iter), 'error: ', num2str(best_err)])
    
end

indexes = best_inline;

end