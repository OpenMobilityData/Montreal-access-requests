% MATLAB Script to create a comprehensive DAG for Montreal Budget Transfer calculations
% Focuses on a single representative year (2020) but includes all possible parameters

%% Define the nodes (variables) in the DAG
nodes = {
    % Base values
    'Previous Year Transfers',
    'Population Data',
    'Indexation Rate',
    
    % Santé (Health) parameters
    'Dollar per Inhabitant Rate',
    'Equipment Value Parameter',
    'ODER Grid Parameter',
    'Equipment Value Variation',
    'ODER Grid Variation',
    
    % Parcs (Parks) parameters
    'Parcs Local Stock Variations',
    'Parcs Delegated Stock Variations',
    
    % Voirie (Roads) parameters
    'Voirie Local Stock Variations',
    'Voirie Delegated Stock Variations',
    
    % Aménagement (Urban Planning) parameters
    'Aménagement Local Stock Variations',
    
    % Bibliothèques (Libraries) parameters
    'Bibliothèques Bonification',
    
    % Adjustment parameters
    'Initial 5-10 Year Adjustment',
    'Snow Removal Bonification',
    'Vignette Compensation',
    'MRA Telephony Centralization',
    'Parks Bonification',
    'Post-Transfer Adjustment',
    
    % Intermediate calculation nodes
    'Population Variation',
    'Santé Population Component',
    'Santé Equipment Component',
    'Santé ODER Component',
    'Santé Transfers',
    'Parcs Local Component',
    'Parcs Delegated Component',
    'Voirie Local Component',
    'Voirie Delegated Component',
    'Aménagement Component',
    'Local Stock Variation',
    'Delegated Stock Variation',
    'Special Year Adjustments',
    'General Indexation',
    'Components Sum',
    'Intermediate Transfers',
    
    % Final output
    'Final Transfers'
};

% Define the edges (dependencies) in the DAG
edges = [
    % Population calculations
    find(strcmp(nodes, 'Population Data')), find(strcmp(nodes, 'Population Variation')),
    
    % Santé calculations
    find(strcmp(nodes, 'Population Variation')), find(strcmp(nodes, 'Santé Population Component')),
    find(strcmp(nodes, 'Dollar per Inhabitant Rate')), find(strcmp(nodes, 'Santé Population Component')),
    find(strcmp(nodes, 'Equipment Value Variation')), find(strcmp(nodes, 'Santé Equipment Component')),
    find(strcmp(nodes, 'Equipment Value Parameter')), find(strcmp(nodes, 'Santé Equipment Component')),
    find(strcmp(nodes, 'ODER Grid Variation')), find(strcmp(nodes, 'Santé ODER Component')),
    find(strcmp(nodes, 'ODER Grid Parameter')), find(strcmp(nodes, 'Santé ODER Component')),
    find(strcmp(nodes, 'Santé Population Component')), find(strcmp(nodes, 'Santé Transfers')),
    find(strcmp(nodes, 'Santé Equipment Component')), find(strcmp(nodes, 'Santé Transfers')),
    find(strcmp(nodes, 'Santé ODER Component')), find(strcmp(nodes, 'Santé Transfers')),
    find(strcmp(nodes, 'Santé Transfers')), find(strcmp(nodes, 'Components Sum')),
    
    % Parcs calculations
    find(strcmp(nodes, 'Parcs Local Stock Variations')), find(strcmp(nodes, 'Parcs Local Component')),
    find(strcmp(nodes, 'Parcs Delegated Stock Variations')), find(strcmp(nodes, 'Parcs Delegated Component')),
    find(strcmp(nodes, 'Parcs Local Component')), find(strcmp(nodes, 'Local Stock Variation')),
    find(strcmp(nodes, 'Parcs Delegated Component')), find(strcmp(nodes, 'Delegated Stock Variation')),
    
    % Voirie calculations
    find(strcmp(nodes, 'Voirie Local Stock Variations')), find(strcmp(nodes, 'Voirie Local Component')),
    find(strcmp(nodes, 'Voirie Delegated Stock Variations')), find(strcmp(nodes, 'Voirie Delegated Component')),
    find(strcmp(nodes, 'Voirie Local Component')), find(strcmp(nodes, 'Local Stock Variation')),
    find(strcmp(nodes, 'Voirie Delegated Component')), find(strcmp(nodes, 'Delegated Stock Variation')),
    
    % Aménagement calculations
    find(strcmp(nodes, 'Aménagement Local Stock Variations')), find(strcmp(nodes, 'Aménagement Component')),
    find(strcmp(nodes, 'Aménagement Component')), find(strcmp(nodes, 'Local Stock Variation')),
    
    % Bibliothèques calculations (only applies to 2020-2021)
    find(strcmp(nodes, 'Bibliothèques Bonification')), find(strcmp(nodes, 'Components Sum')),
    
    % Special year adjustments (collection of all possible adjustments)
    find(strcmp(nodes, 'Initial 5-10 Year Adjustment')), find(strcmp(nodes, 'Special Year Adjustments')),
    find(strcmp(nodes, 'Snow Removal Bonification')), find(strcmp(nodes, 'Special Year Adjustments')),
    find(strcmp(nodes, 'Vignette Compensation')), find(strcmp(nodes, 'Special Year Adjustments')),
    find(strcmp(nodes, 'MRA Telephony Centralization')), find(strcmp(nodes, 'Special Year Adjustments')),
    find(strcmp(nodes, 'Parks Bonification')), find(strcmp(nodes, 'Special Year Adjustments')),
    find(strcmp(nodes, 'Special Year Adjustments')), find(strcmp(nodes, 'Components Sum')),
    
    % Indexation calculation
    find(strcmp(nodes, 'Previous Year Transfers')), find(strcmp(nodes, 'General Indexation')),
    find(strcmp(nodes, 'Indexation Rate')), find(strcmp(nodes, 'General Indexation')),
    
    % Stock variations to components sum
    find(strcmp(nodes, 'Local Stock Variation')), find(strcmp(nodes, 'Components Sum')),
    find(strcmp(nodes, 'Delegated Stock Variation')), find(strcmp(nodes, 'Components Sum')),
    
    % Intermediate transfers calculation
    find(strcmp(nodes, 'Previous Year Transfers')), find(strcmp(nodes, 'Intermediate Transfers')),
    find(strcmp(nodes, 'General Indexation')), find(strcmp(nodes, 'Intermediate Transfers')),
    find(strcmp(nodes, 'Components Sum')), find(strcmp(nodes, 'Intermediate Transfers')),
    
    % Final transfers
    find(strcmp(nodes, 'Intermediate Transfers')), find(strcmp(nodes, 'Final Transfers')),
    find(strcmp(nodes, 'Post-Transfer Adjustment')), find(strcmp(nodes, 'Final Transfers'))
];

% Reshape edges to form pairs
edges = reshape(edges, 2, [])';

%% Create and visualize the DAG
% Create the directed graph
G = digraph(edges(:,1), edges(:,2), [], nodes);

% Set up the plot
figure('Position', [100, 100, 1200, 800]);
h = plot(G, 'Layout', 'layered', 'Direction', 'right');

% Define node categories for coloring
input_params = {};
for i = 1:length(nodes)
    if strcmp(nodes{i}, 'Previous Year Transfers') || ...
       strcmp(nodes{i}, 'Population Data') || ...
       strcmp(nodes{i}, 'Indexation Rate') || ...
       strcmp(nodes{i}, 'Dollar per Inhabitant Rate') || ...
       strcmp(nodes{i}, 'Equipment Value Parameter') || ...
       strcmp(nodes{i}, 'ODER Grid Parameter') || ...
       strcmp(nodes{i}, 'Equipment Value Variation') || ...
       strcmp(nodes{i}, 'ODER Grid Variation') || ...
       strcmp(nodes{i}, 'Parcs Local Stock Variations') || ...
       strcmp(nodes{i}, 'Parcs Delegated Stock Variations') || ...
       strcmp(nodes{i}, 'Voirie Local Stock Variations') || ...
       strcmp(nodes{i}, 'Voirie Delegated Stock Variations') || ...
       strcmp(nodes{i}, 'Aménagement Local Stock Variations') || ...
       strcmp(nodes{i}, 'Bibliothèques Bonification')
        input_params{end+1} = nodes{i};
    end
end

adjustments = {};
for i = 1:length(nodes)
    if strcmp(nodes{i}, 'Initial 5-10 Year Adjustment') || ...
       strcmp(nodes{i}, 'Snow Removal Bonification') || ...
       strcmp(nodes{i}, 'Vignette Compensation') || ...
       strcmp(nodes{i}, 'MRA Telephony Centralization') || ...
       strcmp(nodes{i}, 'Parks Bonification') || ...
       strcmp(nodes{i}, 'Post-Transfer Adjustment')
        adjustments{end+1} = nodes{i};
    end
end

sector_calcs = {};
for i = 1:length(nodes)
    if strcmp(nodes{i}, 'Population Variation') || ...
       strcmp(nodes{i}, 'Santé Population Component') || ...
       strcmp(nodes{i}, 'Santé Equipment Component') || ...
       strcmp(nodes{i}, 'Santé ODER Component') || ...
       strcmp(nodes{i}, 'Santé Transfers') || ...
       strcmp(nodes{i}, 'Parcs Local Component') || ...
       strcmp(nodes{i}, 'Parcs Delegated Component') || ...
       strcmp(nodes{i}, 'Voirie Local Component') || ...
       strcmp(nodes{i}, 'Voirie Delegated Component') || ...
       strcmp(nodes{i}, 'Aménagement Component') || ...
       strcmp(nodes{i}, 'Local Stock Variation') || ...
       strcmp(nodes{i}, 'Delegated Stock Variation')
        sector_calcs{end+1} = nodes{i};
    end
end

high_level_calcs = {};
for i = 1:length(nodes)
    if strcmp(nodes{i}, 'Special Year Adjustments') || ...
       strcmp(nodes{i}, 'General Indexation') || ...
       strcmp(nodes{i}, 'Components Sum') || ...
       strcmp(nodes{i}, 'Intermediate Transfers')
        high_level_calcs{end+1} = nodes{i};
    end
end

final_output = {};
for i = 1:length(nodes)
    if strcmp(nodes{i}, 'Final Transfers')
        final_output{end+1} = nodes{i};
    end
end

% Create color map
nodeColors = zeros(length(nodes), 3);

% Assign colors by category
color_input = [0.3, 0.6, 0.9];      % Blue
color_adjust = [0.7, 0.4, 0.8];     % Purple
color_sector = [0.3, 0.7, 0.4];     % Green
color_highlevel = [0.2, 0.8, 0.2];  % Bright green
color_final = [0.9, 0.3, 0.3];      % Red

for i = 1:length(nodes)
    if any(strcmp(input_params, nodes{i}))
        nodeColors(i,:) = color_input;
    elseif any(strcmp(adjustments, nodes{i}))
        nodeColors(i,:) = color_adjust;
    elseif any(strcmp(sector_calcs, nodes{i}))
        nodeColors(i,:) = color_sector;
    elseif any(strcmp(high_level_calcs, nodes{i}))
        nodeColors(i,:) = color_highlevel;
    elseif any(strcmp(final_output, nodes{i}))
        nodeColors(i,:) = color_final;
    end
end

% Apply colors to nodes
h.NodeColor = nodeColors;

% Customize node appearance
h.NodeFontSize = 9;
h.NodeFontWeight = 'bold';
h.MarkerSize = 9;

% Customize edge appearance
h.EdgeColor = [0.5 0.5 0.5];
h.LineWidth = 1.2;
h.ArrowSize = 10;

% Add a title
title('Montreal Budget Transfer Calculation - Comprehensive View', 'FontSize', 14);

% Create a legend
hold on;
h_dummy_input = scatter(NaN, NaN, 50, color_input, 'filled');
h_dummy_adjust = scatter(NaN, NaN, 50, color_adjust, 'filled');
h_dummy_sector = scatter(NaN, NaN, 50, color_sector, 'filled');
h_dummy_highlevel = scatter(NaN, NaN, 50, color_highlevel, 'filled');
h_dummy_final = scatter(NaN, NaN, 50, color_final, 'filled');

legend([h_dummy_input, h_dummy_adjust, h_dummy_sector, h_dummy_highlevel, h_dummy_final], ...
       {'Input Parameters', 'Adjustment Factors', 'Sector-Specific Calculations', ...
        'High-Level Calculations', 'Final Output'}, 'Location', 'eastoutside');
hold off;

% Export the figure as a high-resolution image
print('Montreal_Budget_Transfer_Comprehensive_DAG', '-dpng', '-r300');

fprintf('Comprehensive single-year DAG visualization completed.\n');

%% Alternative visualization with hierarchical groups
figure('Position', [100, 100, 1200, 800]);

% Group nodes by functional area
g1 = [];
g2 = [];
g3 = [];
g4 = [];
g5 = [];
g6 = [];
g7 = [];

for i = 1:length(nodes)
    % Base inputs
    if strcmp(nodes{i}, 'Previous Year Transfers') || ...
       strcmp(nodes{i}, 'Population Data') || ...
       strcmp(nodes{i}, 'Indexation Rate')
        g1 = [g1; i];
    
    % Santé parameters    
    elseif strcmp(nodes{i}, 'Dollar per Inhabitant Rate') || ...
           strcmp(nodes{i}, 'Equipment Value Parameter') || ...
           strcmp(nodes{i}, 'ODER Grid Parameter') || ...
           strcmp(nodes{i}, 'Equipment Value Variation') || ...
           strcmp(nodes{i}, 'ODER Grid Variation')
        g2 = [g2; i];
    
    % Parcs parameters
    elseif strcmp(nodes{i}, 'Parcs Local Stock Variations') || ...
           strcmp(nodes{i}, 'Parcs Delegated Stock Variations')
        g3 = [g3; i];
    
    % Voirie parameters
    elseif strcmp(nodes{i}, 'Voirie Local Stock Variations') || ...
           strcmp(nodes{i}, 'Voirie Delegated Stock Variations')
        g4 = [g4; i];
    
    % Aménagement parameters
    elseif strcmp(nodes{i}, 'Aménagement Local Stock Variations')
        g5 = [g5; i];
    
    % Bibliothèques parameters
    elseif strcmp(nodes{i}, 'Bibliothèques Bonification')
        g6 = [g6; i];
    
    % Adjustment parameters
    elseif strcmp(nodes{i}, 'Initial 5-10 Year Adjustment') || ...
           strcmp(nodes{i}, 'Snow Removal Bonification') || ...
           strcmp(nodes{i}, 'Vignette Compensation') || ...
           strcmp(nodes{i}, 'MRA Telephony Centralization') || ...
           strcmp(nodes{i}, 'Parks Bonification') || ...
           strcmp(nodes{i}, 'Post-Transfer Adjustment')
        g7 = [g7; i];
    end
end

% Create a structured layout
node_groups = {g1, g2, g3, g4, g5, g6, g7};
h2 = plot(G, 'Layout', 'layered', 'Direction', 'right');
h2.NodeColor = nodeColors;

% Customize node appearance
h2.NodeFontSize = 9;
h2.NodeFontWeight = 'bold';
h2.MarkerSize = 9;

% Customize edge appearance
h2.EdgeColor = [0.5 0.5 0.5];
h2.LineWidth = 1.2;
h2.ArrowSize = 10;

% Add a title
title('Montreal Budget Transfer Calculation - Grouped by Category', 'FontSize', 14);

% Recreate the legend
hold on;
h_dummy_input = scatter(NaN, NaN, 50, color_input, 'filled');
h_dummy_adjust = scatter(NaN, NaN, 50, color_adjust, 'filled');
h_dummy_sector = scatter(NaN, NaN, 50, color_sector, 'filled');
h_dummy_highlevel = scatter(NaN, NaN, 50, color_highlevel, 'filled');
h_dummy_final = scatter(NaN, NaN, 50, color_final, 'filled');

legend([h_dummy_input, h_dummy_adjust, h_dummy_sector, h_dummy_highlevel, h_dummy_final], ...
       {'Input Parameters', 'Adjustment Factors', 'Sector-Specific Calculations', ...
        'High-Level Calculations', 'Final Output'}, 'Location', 'eastoutside');
hold off;

% Export the figure as a high-resolution image
print('Montreal_Budget_Transfer_Grouped_DAG', '-dpng', '-r300');

fprintf('Grouped single-year DAG visualization completed.\n');

%% Create a simplified high-level view
% Define simplified nodes
simple_nodes = {
    'Previous Year Transfers',
    'Indexation Rate',
    'Population Parameters',
    'Santé Parameters',
    'Parcs Parameters',
    'Voirie Parameters',
    'Aménagement Parameters',
    'Bibliothèques Bonification',
    'Year-Specific Adjustments',
    'Post-Transfer Adjustments',
    'Santé Calculation',
    'Parcs Calculation',
    'Voirie Calculation',
    'Aménagement Calculation',
    'General Indexation',
    'Components Sum',
    'Intermediate Transfers',
    'Final Budget Transfer'
};

% Define simplified edges
simple_edges = [
    1, 15; % Previous Year Transfers -> General Indexation
    2, 15; % Indexation Rate -> General Indexation
    1, 17; % Previous Year Transfers -> Intermediate Transfers
    3, 11; % Population Parameters -> Santé Calculation
    4, 11; % Santé Parameters -> Santé Calculation
    5, 12; % Parcs Parameters -> Parcs Calculation
    6, 13; % Voirie Parameters -> Voirie Calculation
    7, 14; % Aménagement Parameters -> Aménagement Calculation
    8, 16; % Bibliothèques Bonification -> Components Sum
    9, 16; % Year-Specific Adjustments -> Components Sum
    11, 16; % Santé Calculation -> Components Sum
    12, 16; % Parcs Calculation -> Components Sum
    13, 16; % Voirie Calculation -> Components Sum
    14, 16; % Aménagement Calculation -> Components Sum
    15, 17; % General Indexation -> Intermediate Transfers
    16, 17; % Components Sum -> Intermediate Transfers
    17, 18; % Intermediate Transfers -> Final Budget Transfer
    10, 18; % Post-Transfer Adjustments -> Final Budget Transfer
];

% Create the simplified graph
G_simple = digraph(simple_edges(:,1), simple_edges(:,2), [], simple_nodes);

% Set up the simplified plot
figure('Position', [100, 100, 1200, 600]);
h_simple = plot(G_simple, 'Layout', 'layered', 'Direction', 'right');

% Define node colors for simplified view
simple_colors = zeros(length(simple_nodes), 3);

% Assign colors by category
input_indices = 1:9;
adjustment_indices = [9, 10];
calc_indices = 11:17;
output_indices = 18;

simple_colors(input_indices, :) = repmat(color_input, length(input_indices), 1);
simple_colors(adjustment_indices, :) = repmat(color_adjust, length(adjustment_indices), 1);
simple_colors(calc_indices, :) = repmat(color_highlevel, length(calc_indices), 1);
simple_colors(output_indices, :) = repmat(color_final, length(output_indices), 1);

% Apply colors to nodes
h_simple.NodeColor = simple_colors;

% Customize node appearance
h_simple.NodeFontSize = 11;
h_simple.NodeFontWeight = 'bold';
h_simple.MarkerSize = 10;

% Customize edge appearance
h_simple.EdgeColor = [0.5 0.5 0.5];
h_simple.LineWidth = 1.5;
h_simple.ArrowSize = 12;

% Add a title
title('Simplified Overview of Montreal Budget Transfer Calculation', 'FontSize', 16);

% Create a legend
hold on;
h_dummy_input = scatter(NaN, NaN, 50, color_input, 'filled');
h_dummy_adjust = scatter(NaN, NaN, 50, color_adjust, 'filled');
h_dummy_calc = scatter(NaN, NaN, 50, color_highlevel, 'filled');
h_dummy_final = scatter(NaN, NaN, 50, color_final, 'filled');

legend([h_dummy_input, h_dummy_adjust, h_dummy_calc, h_dummy_final], ...
       {'Input Parameters', 'Adjustment Factors', 'Calculations', 'Final Output'}, ...
       'Location', 'eastoutside');
hold off;

% Export the figure as a high-resolution image
print('Montreal_Budget_Transfer_Simplified_DAG', '-dpng', '-r300');

fprintf('Simplified overview DAG visualization completed.\n');