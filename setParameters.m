params.multiplier = 3.5;
params.nSpikes = 200;
params.nScales = 5;
params.wid = [0.5 1];
params.grd = [];
% params.costList = [-0.2:0.05:0]
params.costList = 0;
params.wnameList = {'mea', 'bior1.5', 'bior1.3', 'db2'};
params.subsample_time = [30 90];
params.minPeakThrMultiplier = 2;
params.maxPeakThrMultiplier = 10;
params.posPeakThrMultiplier = 4;
save('params.mat', 'params');