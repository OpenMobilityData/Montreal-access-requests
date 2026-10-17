% Simplified MATLAB Script for Montreal Budget Transfers

%% Initialize parameters
% Years
years = 2017:2022;
numYears = length(years);

% Boroughs
boroughs = {'Côte-des-Neiges–Notre-Dame-de-Grâce', 'Saint-Laurent', 'Sud-Ouest'};
numBoroughs = length(boroughs);

%% Known values from 2016 (starting point)
initial_transfers_2016 = [
    62162.82592;  % Côte-des-Neiges
    59985.59901;  % Saint-Laurent
    47321.75987   % Sud-Ouest
];

%% Known final values from the spreadsheet (for validation)
known_transfers = [
    % CDN-NDG values for 2017-2022
    51338.10843, 52176.70581, 53237.01718, 54095.47302, 56059.65305, 57034.68774;
    % Saint-Laurent values for 2017-2022
    50575.39610, 52259.08418, 52682.39988, 53610.84698, 54605.65410, 55954.99456;
    % Sud-Ouest values for 2017-2022
    40138.75697, 40108.35107, 39989.23324, 40728.17001, 41476.15819, 42942.88636
];

%% Indexation rates
indexation_rates = [0.01, 0.01, 0.015, 0.01, 0.01, 0.01];  % 2017-2022

%% Post-transfer adjustments 
post_transfer_adjustments = [
    % CDN-NDG values for 2017-2022
    -11831.1, -78.1, -175.6, -226.9, 541.3, 289.4;
    % Saint-Laurent values for 2017-2022
    -9852.7, -495.5, -317.0, -122.0, -334.9, 667.0;
    % Sud-Ouest values for 2017-2022
    -7299.6, -37.8, -253.8, -93.9, -106.9, 695.0
];

%% Parameter-based calculations
% Initialize calculated transfers
calculated_transfers = zeros(numBoroughs, numYears);

% Define common parameters used in calculations
% For simplicity, we'll use estimated parameter values
% In reality, these would be extracted from the spreadsheet

% Initial adjustments for 5-10 years implementation
initial_adjustments = [
    % CDN-NDG values for 2017-2022
    293.64236, 296.57878, 504.85395, 380.13200, 383.93332, 0;
    % Saint-Laurent values for 2017-2022
    -114.65904, -115.80563, -296.15831, 357.18750, 360.75938, 0;
    % Sud-Ouest values for 2017-2022
    -606.08058, -612.14139, -510.37673, 127.54700, 128.82247, 0
];

% Stock variations (simplified, combining all local variations)
local_stock_variations = [
    % CDN-NDG values for 2017-2022
    1147.74997, 1041.15223, 1139.36540, 1216.08923, 1211.90597, 1274.42593;
    % Saint-Laurent values for 2017-2022
    2222.70469, 4118.29614, 2389.13210, 2284.22045, 2304.88450, 2276.00402;
    % Sud-Ouest values for 2017-2022
    1143.76993, 937.05629, 974.71793, 960.66364, 962.90819, 1092.62639
];

% Delegated stock variations
delegated_stock_variations = [
    % CDN-NDG values for 2017-2022
    59.03194, 2.45418, -18.13061, -92.12311, 67.02472, 20.78420;
    % Saint-Laurent values for 2017-2022
    72.51582, 6.78721, 131.87626, -78.58770, 34.46784, 30.35450;
    % Sud-Ouest values for 2017-2022
    -9.95542, 59.91838, -29.26612, -8.95653, 12.35710, 15.75650
];

% Special adjustments (combining snow removal, vignettes, etc.)
special_adjustments = [
    % CDN-NDG values for 2017-2022
    150.21709, 200.81427, 0, 677.94618, 681.74932, 0;
    % Saint-Laurent values for 2017-2022
    44.42479, -175.97596, 0, 655.95284, 660.99703, 0;
    % Sud-Ouest values for 2017-2022
    109.95065, 109.30717, 0, 289.35537, 291.50166, 0
];

%% Perform calculations
% We'll calculate each year's transfers based on parameters
previous_transfers = initial_transfers_2016;

for year_idx = 1:numYears
    year = years(year_idx);
    fprintf('Calculating transfers for year %d\n', year);
    
    % Calculate indexation
    indexation = previous_transfers * indexation_rates(year_idx);
    
    % Sum up components
    components_sum = initial_adjustments(:, year_idx) + ...
                     local_stock_variations(:, year_idx) + ...
                     delegated_stock_variations(:, year_idx) + ...
                     special_adjustments(:, year_idx);
    
    % Calculate intermediate transfers
    intermediate_transfers = previous_transfers + indexation + components_sum;
    
    % Add post-transfer adjustments
    final_transfers = intermediate_transfers + post_transfer_adjustments(:, year_idx);
    
    % Store results
    calculated_transfers(:, year_idx) = final_transfers;
    
    % For next year, use the known values to prevent error accumulation
    previous_transfers = known_transfers(:, year_idx);
end

%% Display results
fprintf('\nComparison of Calculated vs. Actual Transfers (in thousands $)\n');
fprintf('===========================================================\n');

% Display table header
fprintf('%-6s %-35s %12s %12s %12s\n', 'Year', 'Borough', 'Calculated', 'Actual', 'Difference');
fprintf('----------------------------------------------------------------------------------\n');

% For each year and borough
for year_idx = 1:numYears
    year = years(year_idx);
    
    for i = 1:numBoroughs
        calculated = calculated_transfers(i, year_idx);
        actual = known_transfers(i, year_idx);
        diff = calculated - actual;
        
        fprintf('%-6d %-35s %12.1f %12.1f %12.1f\n', ...
                year, boroughs{i}, calculated, actual, diff);
    end
    
    if year_idx < numYears
        fprintf('----------------------------------------------------------------------------------\n');
    end
end

% Display summary statistics
fprintf('\nSummary of Differences (Calculated - Actual)\n');
fprintf('==========================================\n');
fprintf('%-35s %12s %12s %12s\n', 'Borough', 'Min', 'Max', 'Average');
fprintf('------------------------------------------------------------------\n');

for i = 1:numBoroughs
    diffs = calculated_transfers(i, :) - known_transfers(i, :);
    min_diff = min(diffs);
    max_diff = max(diffs);
    avg_diff = mean(diffs);
    
    fprintf('%-35s %12.1f %12.1f %12.1f\n', ...
            boroughs{i}, min_diff, max_diff, avg_diff);
end

%% Detailed breakdown for 2017
fprintf('\nDetailed Breakdown for 2017 Budget Calculation (in thousands $)\n');
fprintf('===========================================================\n');

% Component names for display
component_names = {
    'Previous Transfers (2016)', 
    'General Indexation', 
    'Initial Adjustments', 
    'Stock Variations (Local)', 
    'Stock Variations (Delegated)', 
    'Special Adjustments',
    'Intermediate Transfers', 
    'Post-Transfer Adjustments', 
    'Final Transfers (Calculated)',
    'Actual Transfers',
    'Difference'
};

% Calculate components for 2017
year_idx = 1; % 2017
components = zeros(numBoroughs, 11); % 11 components to display

for i = 1:numBoroughs
    % Previous transfers (2016)
    components(i, 1) = initial_transfers_2016(i);
    
    % Indexation
    components(i, 2) = initial_transfers_2016(i) * indexation_rates(1);
    
    % Initial adjustments
    components(i, 3) = initial_adjustments(i, 1);
    
    % Local stock variation
    components(i, 4) = local_stock_variations(i, 1);
    
    % Delegated stock variation
    components(i, 5) = delegated_stock_variations(i, 1);
    
    % Special adjustments
    components(i, 6) = special_adjustments(i, 1);
    
    % Intermediate transfers
    components(i, 7) = components(i, 1) + components(i, 2) + components(i, 3) + ...
                      components(i, 4) + components(i, 5) + components(i, 6);
    
    % Post-transfer adjustments
    components(i, 8) = post_transfer_adjustments(i, 1);
    
    % Final transfers (calculated)
    components(i, 9) = components(i, 7) + components(i, 8);
    
    % Actual transfers
    components(i, 10) = known_transfers(i, 1);
    
    % Difference
    components(i, 11) = components(i, 9) - components(i, 10);
end

% Display table header
fprintf('%-35s %12s %12s %12s\n', 'Component', 'CDN-NDG', 'Saint-Laurent', 'Sud-Ouest');
fprintf('------------------------------------------------------------------\n');

% Display each component
for j = 1:11
    fprintf('%-35s %12.1f %12.1f %12.1f\n', component_names{j}, ...
            components(1, j), components(2, j), components(3, j));
    
    % Add separators at logical breakpoints
    if j == 6 || j == 8 || j == 9 || j == 10
        fprintf('------------------------------------------------------------------\n');
    end
end