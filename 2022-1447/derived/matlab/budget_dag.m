% Budget Transfer Process Directed Acyclic Graph (DAG) Visualization
% This script creates a graphical representation of the budget transfer calculation
% process for Montreal's parametric budget model.

% Clear workspace and create figure
clear;
close all;
figure('Position', [100, 100, 1200, 800]);

% Create a directed graph object
G = digraph();

% Define main nodes
G = addnode(G, 'Previous Year Budget');
G = addnode(G, 'Annual Indexation');
G = addnode(G, 'Initial Adjustment');
G = addnode(G, 'Snow Removal');
G = addnode(G, 'Vignette Compensation');
G = addnode(G, 'Stock Increase (Local)');
G = addnode(G, 'Stock Increase (Delegated)');
G = addnode(G, 'Subtotal');
G = addnode(G, 'Post-Transfer Adjustment');
G = addnode(G, 'Final Budget Transfer');

% Add parameter input nodes
G = addnode(G, 'Indexation Rate');
G = addnode(G, 'Population');
G = addnode(G, 'Geographic Area');
G = addnode(G, 'Road Length');
G = addnode(G, 'Parks Area');
G = addnode(G, 'Library Area');
G = addnode(G, 'Policy Decisions');

% Connect nodes to show calculation flow
G = addedge(G, 'Previous Year Budget', 'Annual Indexation');
G = addedge(G, 'Indexation Rate', 'Annual Indexation');
G = addedge(G, 'Annual Indexation', 'Subtotal');
G = addedge(G, 'Previous Year Budget', 'Subtotal');
G = addedge(G, 'Initial Adjustment', 'Subtotal');
G = addedge(G, 'Snow Removal', 'Subtotal');
G = addedge(G, 'Vignette Compensation', 'Subtotal');
G = addedge(G, 'Stock Increase (Local)', 'Subtotal');
G = addedge(G, 'Stock Increase (Delegated)', 'Subtotal');
G = addedge(G, 'Subtotal', 'Final Budget Transfer');
G = addedge(G, 'Post-Transfer Adjustment', 'Final Budget Transfer');

% Connect parameter inputs to corresponding components
G = addedge(G, 'Population', 'Initial Adjustment');
G = addedge(G, 'Geographic Area', 'Initial Adjustment');
G = addedge(G, 'Road Length', 'Snow Removal');
G = addedge(G, 'Policy Decisions', 'Vignette Compensation');
G = addedge(G, 'Population', 'Stock Increase (Local)');
G = addedge(G, 'Geographic Area', 'Stock Increase (Local)');
G = addedge(G, 'Parks Area', 'Stock Increase (Local)');
G = addedge(G, 'Library Area', 'Stock Increase (Local)');
G = addedge(G, 'Road Length', 'Stock Increase (Delegated)');
G = addedge(G, 'Policy Decisions', 'Post-Transfer Adjustment');

% Define component categories (for coloring)
mainCalcNodes = {'Previous Year Budget', 'Annual Indexation', 'Subtotal', 'Final Budget Transfer'};
adjustmentNodes = {'Initial Adjustment', 'Snow Removal', 'Vignette Compensation', 'Stock Increase (Local)', 'Stock Increase (Delegated)', 'Post-Transfer Adjustment'};
parameterNodes = {'Indexation Rate', 'Population', 'Geographic Area', 'Road Length', 'Parks Area', 'Library Area', 'Policy Decisions'};

% Create node colors based on categories
nodeColors = cell(numnodes(G), 1);
for i = 1:numnodes(G)
    nodeName = G.Nodes.Name{i};
    if ismember(nodeName, mainCalcNodes)
        nodeColors{i} = [0.2 0.4 0.8]; % Blue for main calculation nodes
    elseif ismember(nodeName, adjustmentNodes)
        nodeColors{i} = [0.8 0.4 0.2]; % Orange for adjustment nodes
    elseif ismember(nodeName, parameterNodes)
        nodeColors{i} = [0.2 0.7 0.3]; % Green for parameter nodes
    else
        nodeColors{i} = [0.5 0.5 0.5]; % Gray for other nodes
    end
end

% Set up layout with layered approach
layout = 'layered';

% Plot the graph
p = plot(G, 'Layout', layout, 'NodeColor', cell2mat(nodeColors), ...
    'EdgeColor', [0.3 0.3 0.3], 'LineWidth', 1.5, ...
    'ArrowSize', 10, 'NodeFontSize', 12, 'NodeFontWeight', 'bold');

% Adjust node sizes based on importance
nodeSize = zeros(numnodes(G), 1);
for i = 1:numnodes(G)
    nodeName = G.Nodes.Name{i};
    if strcmp(nodeName, 'Previous Year Budget') || strcmp(nodeName, 'Final Budget Transfer') || strcmp(nodeName, 'Subtotal')
        nodeSize(i) = 36; % Larger size for key nodes
    elseif ismember(nodeName, mainCalcNodes)
        nodeSize(i) = 30; % Medium-large for main calculation nodes
    elseif ismember(nodeName, adjustmentNodes)
        nodeSize(i) = 28; % Medium for adjustment nodes
    else
        nodeSize(i) = 24; % Smaller for parameter nodes
    end
end
p.MarkerSize = nodeSize;

% Add highlights for the main calculation path
mainPath = {'Previous Year Budget', 'Subtotal', 'Final Budget Transfer'};
highlight(p, mainPath, 'EdgeColor', [0.8 0 0], 'LineWidth', 3);

% Calculate the edge directions to adjust labels
edgeDirs = zeros(numedges(G), 2);
for i = 1:numedges(G)
    src = p.XData(findnode(G, G.Edges.EndNodes{i, 1}));
    dst = p.XData(findnode(G, G.Edges.EndNodes{i, 2}));
    edgeDirs(i, :) = [src dst];
end

% Create a legend
hold on;
scatter(NaN, NaN, 100, [0.2 0.4 0.8], 'filled', 'DisplayName', 'Main Calculation Nodes');
scatter(NaN, NaN, 100, [0.8 0.4 0.2], 'filled', 'DisplayName', 'Adjustment Nodes');
scatter(NaN, NaN, 100, [0.2 0.7 0.3], 'filled', 'DisplayName', 'Parameter Nodes');
plot(NaN, NaN, 'Color', [0.8 0 0], 'LineWidth', 3, 'DisplayName', 'Main Calculation Path');
legend('Location', 'northeastoutside', 'FontSize', 12);

% Add detailed formula annotations
annotation('textbox', [0.02, 0.02, 0.3, 0.1], 'String', ...
    {'Budget Transfer Formula:', ...
    'T_y = T_{y-1} + I_y + A_y + P_y', ...
    'where A_y = Initial Adjustment + Snow Removal + ...', ...
    'I_y = Indexation, P_y = Post-Transfer Adjustment'}, ...
    'FitBoxToText', 'on', 'BackgroundColor', [1 1 0.8], ...
    'EdgeColor', [0.3 0.3 0.3], 'LineWidth', 1.5);

% Create a sub-graph showing the multi-year process
axes('Position', [0.75, 0.75, 0.2, 0.2]);
G2 = digraph();
G2 = addnode(G2, 'Budget 2016');
G2 = addnode(G2, 'Budget 2017');
G2 = addnode(G2, 'Budget 2018');
G2 = addnode(G2, '...');
G2 = addnode(G2, 'Budget 2022');
G2 = addedge(G2, 'Budget 2016', 'Budget 2017');
G2 = addedge(G2, 'Budget 2017', 'Budget 2018');
G2 = addedge(G2, 'Budget 2018', '...');
G2 = addedge(G2, '...', 'Budget 2022');
plot(G2, 'Layout', 'layered', 'NodeColor', [0.2 0.4 0.8], ...
    'EdgeColor', [0.3 0.3 0.3], 'LineWidth', 1.5, ...
    'ArrowSize', 8, 'NodeFontSize', 8);
title('Multi-Year Budget Process', 'FontSize', 10);

% Add title and other formatting to main graph
axes(gca);
title('Directed Acyclic Graph (DAG) of Montreal''s Parametric Budget Transfer Model', ...
    'FontSize', 16, 'FontWeight', 'bold');
subtitle('Showing calculation flow and parameter dependencies', 'FontSize', 12);

% Add a box for CDN-NDG example values for 2017
annotation('textbox', [0.02, 0.85, 0.25, 0.12], 'String', ...
    {'CDN-NDG 2017 Example Values:', ...
    'Initial Budget (2016): $62,162.83k', ...
    'Indexation (1%): $621.63k', ...
    'Initial Adjustment: $293.64k', ...
    'Post-Transfer Adjustment: -$11,831.10k', ...
    'Final 2017 Transfer: $51,338.11k'}, ...
    'FitBoxToText', 'on', 'BackgroundColor', [0.9 0.95 1], ...
    'EdgeColor', [0.3 0.3 0.3], 'LineWidth', 1.5);

% Save the figure
print('Montreal_Budget_Transfer_DAG', '-dpng', '-r300');
print('Montreal_Budget_Transfer_DAG', '-dsvg');

disp('Budget Transfer DAG visualization complete.');
disp('Files saved as Montreal_Budget_Transfer_DAG.png and Montreal_Budget_Transfer_DAG.svg');