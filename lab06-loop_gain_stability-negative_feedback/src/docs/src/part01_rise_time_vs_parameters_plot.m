%% part01_rise_time_vs_parameters_plot.m
% Plots the rise time against each parameter changed in part 01.
% By      : Leomar Duran
% When    : 2023-03-10t16:21
% For     : ECE 3413 Classical Control Systems
%

clear;

% reference parameters
a = 4
b = 25

% powers of parameter in approximation equation
pVec = [0.1875, -1.1684, -1]
% the coefficient for each approximation
cVec = [0.293804, 0.293134, 0.293041]

% parameters to analyze
paramDescs = ["real", "imaginary", "natural frequency"]
paramNames = ["m", "n", "\nu"]
% which parameter to update for each figure
paramIdxs = [1 2 3]
% the upper limit of each parameter (lower limit is reciprocal)
scale = 5
paramLims = [2*scale, (1/2)/scale, 4*scale]
% count of the parameters (for each figure)
figCount = numel(paramNames);

% allocate settling time
TrCount = 100
Tr = zeros(TrCount, figCount);
% multiplier of real part
for figIdx=1:figCount
    figure(figIdx)
    paramLim = paramLims(figIdx)
    % set up the input space
    ipSpace = linspace(1/paramLim, paramLim, TrCount);
    for TrIdx=1:TrCount
        % clear the parameters
        params = ones(1, max(paramIdxs));
        % use paramIdx to pick the next parameter
        params(paramIdxs(figIdx)) = ipSpace(TrIdx);
        m = params(1)
        n = params(2)
        nu = params(3)
        % modify polynomial by real and imaginary parts
        a2 = m*a;
        b2 = (m^2 - n^2)*(a/2)^2 + n^2*b;
        % modify polynomial by natural frequency
        a3 = nu*a2;
        b3 = nu^2*b2;
        % update the polynomial
        a2 = a3;
        b2 = b3;
        % find the rise time
        Tr(TrIdx,figIdx) = stepinfo(tf(b2, [1 a2 b2])).RiseTime;
    end % next TrIdx
    % plot the result
    semilogx((ipSpace), (Tr(:,figIdx)), 'LineWidth', 3)
    hold on
    p = pVec(figIdx)
    c = cVec(figIdx)
    TrHat = ipSpace.^p * c;
    semilogx((ipSpace), (TrHat), '--', 'LineWidth', 3)
    hold off
    TrMean = mean(Tr(:,figIdx))
    SSres = sum((Tr(:,figIdx) - TrHat').^2)
    SStot = sum((Tr(:,figIdx) - TrMean).^2)
    rsq = (1 - SSres/SStot)
    % label the plot
    title(strcat('rise time vs', " ", paramDescs(figIdx), ' multiplier'))
    xlabel('real multiplier')
    ylabel('rise time [s]')
    legend(["actual", ...
        sprintf('%.4f %s^{%.4f}, r^2=%.4f', ...
                c, paramNames(figIdx), p, rsq ...
        )] ...
    )
end % next figIdx
