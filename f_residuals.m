function residuals = f_residuals(F, samples1, samples2)

%samples1 = frames1(1:2, matches(1, :));
%samples2 = frames2(1:2, matches(2, :));

%samples_num = size(samples1, 2);

% compute line
L = (F * samples2')';

% rescale line
L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3);

% cal distance
distances = sum(L .* samples1, 2);

% get residuals
residuals = distances;


end