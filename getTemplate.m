function [aveWaveform, spikeTimes] = getTemplate(trace, multiplier, refPeriod, fs, nSpikes)

% Description:
%   Obtain median waveform from spikes detected with threshold method

% INPUT:
%   trace: [n x 1] filtered voltage trace
%   multiplier: [scalar] threshold multiplier used for spike detection
%   refPeriod: [scalar] refractory period [ms] after a spike in which
%                       no spikes will be detected
%   fs: [scalar] sampling freqency in [Hz]
%   nSpikes: [scalar] the number of spikes used to obtain average waveform

% OUTPUT:
%   aveWaveform: [51 x 1] average spike waveform
%   spikeTimes: [#spikes x 1] vector containing detected spike times

% Author:
%   Jeremy Chabros, University of Cambridge, 2020
%   email: jjc80@cam.ac.uk
%   github.com/jeremi-chabros

[spikeTrain, ~, ~] = detectSpikesThreshold(trace, multiplier, refPeriod, fs, 0);
spikeTimes = find(spikeTrain == 1);


%   If fewer spikes than specified - use the maximum number possible
if  numel(spikeTimes) < nSpikes
    nSpikes = sum(spikeTrain);
    disp(['Not enough spikes detected with specified threshold, using ', num2str(nSpikes),'instead']);
end

%   Uniformly sample n_spikes
spikes2use = round(linspace(2, length(spikeTimes)-2, nSpikes));

for i = 1:nSpikes
    n = spikeTimes(spikes2use(i));
    bin = trace(n-10:n+10);
    pos = find(bin == min(bin))-11; % 11 = middle sample in bin
    spikeWaveforms(:,i) = trace(n+pos-25:n+pos+25);
end

aveWaveform = median(spikeWaveforms');
end