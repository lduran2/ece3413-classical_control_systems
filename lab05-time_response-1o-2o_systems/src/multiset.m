function arrout = multiset(arrin)
%% multiset(arrin)
% Creates a multiset from the given input array.
% This function concatenates a column giving a count of the matching
% rows and removes successive duplicate rows.
%
%% Input Arguments
% *arrin* : double = the $M\times N$ input array
%
%% Output Arguments
% *arrout* : double = the resulting multiset as an $M\times(N+1)$ array
%

% By       : Leomar Duran
% Version  : v1.0.1
% For      : ECE 3413 Classical Control Systems
%
% CHANGELOG:
%       v1.0.1 - 2023-03-22t18:44
%           fixed summing matches per row
%
%       v1.0.0 - 2023-03-22t17:00
%           initial implementation
%
    % get the size of the arrow
    [rowCount, colCount] = size(arrin);
    % copy array input
    % but add a count row, initialized to 1
    arrout = [ arrin ones(rowCount, 1) ];

    % for summing matches per row
    oneCol = ones(colCount, 1);

    % counter for row index
    rowIdx = 0;
    % #(unique elements)
    % initialize row size to that of input array
    uniqueCount = rowCount;
    % loop through the rows
    while (rowIdx < uniqueCount)
        rowIdx = rowIdx + 1;
        % set the current row to the key
        % { arrout, rowIdx, uniqueCount, rowCount, cardinality, arrin }
        key = arrout(rowIdx, 1:colCount);
        % find indices of all matching rows
        rowMatchIdx = find(((arrin == key)*oneCol) == colCount);
        % set cardinality
        cardinality = numel(rowMatchIdx);
        arrout(rowIdx, (colCount+1)) = cardinality;
        % remove duplicate rows
        arrout(rowMatchIdx(2:end), :) = [];
        % update the remaining Rows
        uniqueCount = (uniqueCount - max(0, cardinality - 1));
    end % next iRow

end % function multiset(arrin)