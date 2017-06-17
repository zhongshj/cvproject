function inliers = ransac_ff(frames1, frames2, matches)


    max_outer_iter = 20;
    max_inner_iter = 50;
    best_err = Inf;
    best_inliers = [];
    for outer_iter=1:max_outer_iter
        
        % Randomly initialize inliers
        inliers = rand(1, length(matches)) > .5;    
        
        % Run RANSAC iterations
        for iter=1:max_inner_iter
            
            % Check whether we have sufficient inliers
            if ~rem(iter, 10)
                disp(['RANSAC run ' num2str(outer_iter) ', iteration ' num2str(iter) ' (' num2str(sum(inliers)) ' inliers; best error = ' num2str(best_err) ')...']);
            end
            if sum(inliers) < 8
                inliers = rand(1, length(matches)) > .5;
            end

            % Fit homography based on current inliers
            F = eightPoint(frames1, frames2, matches(:, inliers));
            residuals = f_residuals(F, [frames1(1:2, matches(1,inliers))', ones(sum(inliers),1)], [frames2(1:2, matches(2,inliers))', ones(sum(inliers),1)]);

            % Store best model until now
            if sum(residuals(:)) / sum(inliers) < best_err
                best_inliers = inliers;
                best_err = sum(residuals(:)) ./ sum(inliers);
            end

            err = f_residuals(F, [frames1(1:2, matches(1,:))', ones(length(inliers),1)], [frames2(1:2, matches(2,:))', ones(length(inliers),1)]);
            %err = sum(err .^ 2, 1);
            
            % Update set of inliers
            inliers = abs(err - mean(err)) < .4 * std(err);
        end 
    end


end