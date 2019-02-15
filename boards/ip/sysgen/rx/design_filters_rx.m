%% Script to design interpolating filter chain and equivalent decimator in receiver.

%clear all;
close all;

%% System parameters

Rb = 1000;      % Bit rate is 1kbps (low rate for visualisation purposes)
Rs = Rb/2;      % QPSK, so 2 bits per symbol

R_RRC = 4;      % Rate change undertaken by RRC filter
R_HB = 2;       % Rate change undertaken by Halfband filter(s)
R_CICcomp = 2;  % Rate change undertaken by CIC compensator
R_CIC = 3200;   % Rate change undertaken by CIC filter
R_OV = R_RRC * R_HB * R_CICcomp * R_CIC;

R_RFDAC = 8;    % Rate change to be undertaken by RF-DAC (after output)

% sampling rates at OUTPUTs of the filter sections

fRRC = Rs * R_RRC;
fHB  = fRRC * R_HB;
fCICcomp = fHB * R_CICcomp;
fCIC = fCICcomp * R_CIC;
fRFDAC = fCIC * R_RFDAC;

fprintf(['Output sampling frequency (post-CIC) = ', num2str(fCIC), 'Hz. \r\n']);
fprintf(['Output sampling frequency (post-RF-DAC) = ', num2str(fRFDAC), 'Hz. \r\n']);

%% Design Pulse shaping filter (Root Raised Cosine)
% This filter will interpolate by factor R_RRC (defined above).

RRC_rolloff     = 0.25;                 % RRC rolloff factor
RRC_span        = 12;                   % Span in symbol periods              

% Create an object containing the filter specs for the RRC... 
%dRRC = fdesign.pulseshaping(R_RRC,'Square Root Raised Cosine','N,Beta',RRC_order,RRC_rolloff);

hRRC = comm.RaisedCosineTransmitFilter(...
    'Shape',                  'Square root', ...
    'RolloffFactor',          RRC_rolloff, ...
    'FilterSpanInSymbols',    RRC_span, ...
    'OutputSamplesPerSymbol', R_RRC);

% Extract the weights from the filter object 
% (can then refer to as WRRC.Numerator in System Generator).
WRRC = coeffs(hRRC);

% create a DSP system toolbox version to permit cascading of responses
hdRRC = dsp.FIRInterpolator(R_RRC,WRRC.Numerator);

% Use a scaling factor to compensate for WRRC gain - allows filter response
% to be seen in FVTool with 0dB gain at 0Hz (removes scaling effect of interpolation). 
% Create an FIR with one weight equal to the scaling factor
K_RRC = dsp.FIRFilter('Numerator', 1/sqrt(R_RRC));      % 1 weight filter

% Visualise response
RRC_Tx = cascade(K_RRC,hdRRC);
fvRRC = fvtool(RRC_Tx);

%% Design a Halfband filter
% Halfband interpolates by factor of 2 (always). 

HB_Tw = 0.2;    % Normalised transition bandwidth
HB_Ast = 80;    % Attenuation in the stopband

% design a halfband filter response with parameters specified above
dHB = fdesign.halfband('Tw,Ast', HB_Tw, HB_Ast);
hHB = design(dHB,'equiripple');

HB = dsp.FIRInterpolator(R_HB, hHB.numerator);

%fv(4) = 
fvtool(HB);


%% CIC interpolator - final stage (CIC compensator comes first - see next)

% These parameters must be altered to match CIC filter being compensated - 
% need to check against the parameters set in the System Generator block. 

N_CIC = 3;      % Number of CIC stages
D_CIC = 1;      % Differential delay

CIC = dsp.CICInterpolator(R_CIC, D_CIC, N_CIC, 'FixedPointDataType', 'Full precision');

% Use a scaling factor to compensate for CIC gain - create an FIR with one
% weight equal to the scaling factor
K = 1/(R_CIC^N_CIC);                        % gain compensation value
K_CIC = dsp.FIRFilter('Numerator', K);      % 1 weight filter (gain K)

% Visualise as scaled filter response
CICsc = cascade(K_CIC,CIC);                 % casade scaling and CIC
fvtool(CICsc);

% For System Generator design... scale by arithmetic shift and fine gain if
% not a power of 2 interpolation / decimation ratio
CIC_right_shift = log2(R_CIC^N_CIC);
CIC_left_shift = log2(R_CIC);

%--- for variation with 2x CICs doing rate changes of 40 each, +
% CIC compensation filters (2 each), plus final rate change of 5.  
% i.e. % 40 * 40 * 2 * 2 * 5 = 64000.
R_CIC_i = 40;
CIC_right_shift_i = log2(R_CIC_i^N_CIC);        % use this when using CIC sections
%---

CIC_shift_Tx = floor(CIC_right_shift - CIC_left_shift);
CIC_shift_Rx = floor(CIC_right_shift_i);        % use _i version here

CIC_fine_Tx = 2^-(CIC_right_shift - CIC_left_shift - CIC_shift_Tx);
CIC_fine_Rx = 2^(-(CIC_right_shift_i-CIC_shift_Rx));    % use _i version here

%% CIC compensator - precedes final stage CIC filter (derives some parameters from it so appears last).

% CIC compensator is generated as system object 'CICcomp' for analysis / 
% FVtool plotting using 'dsp.CICCompensationInterpolator'

CICcomp = dsp.CICCompensationInterpolator(CIC,'InterpolationFactor',2, ...
    'PassbandFrequency',0.3*fCICcomp, 'StopbandFrequency',0.4*fCICcomp, ...
    'StopbandAttenuation',80, 'PassbandRipple',0.1, 'SampleRate',fCICcomp);

% Use a scaling factor to compensate for CIC compensator gain - create an FIR with one
% weight equal to the scaling factor

V = 1/R_CICcomp;                                % gain compensation value
K_CICcomp = dsp.FIRFilter('Numerator', V);      % 1 weight filter (gain V)

CICcompsc = cascade(K_CICcomp,CICcomp);         % casade scaling and CICcomp

% Access coefficient values for use in System Generator.
WComp = coeffs(CICcomp);
%hdCICcomp = design(fdesign.ciccomp(D_CIC, N_CIC,0.3*fCICcomp/2,0.4*fCICcomp/2,0.1,80,fCICcomp),'SystemObject',true);

% Visualise response
fvc = fvtool(CICcompsc);%, WComp.Numerator);


%% Cascaded response

cascALL = cascade(RRC_Tx,HB,CICcompsc,K_CIC,CIC);

fvtool(cascALL);

%% Plotting of cascaded and individual responses

% plot a superposition of the responses using the filter visualisation tool
fv_all = fvtool(RRC_Tx,'Fs',fRRC,'ShowReference','off');
hold on
addfilter(fv_all, HB,'Fs',fHB,'ShowReference','off');
addfilter(fv_all, CICcompsc,'Fs',fCICcomp,'ShowReference','off');
addfilter(fv_all, CICsc,'Fs',fCIC,'ShowReference','off');
addfilter(fv_all, cascALL, 'Fs', fCIC,'ShowReference','off');
hold off
grid on
title('Cascaded Responses for a Chain of Interpolating Filters');
legend(fv_all,'RRC','HB','CICcomp (scaled)','CIC (scaled)','RRC-HB-CICcomp-CIC Cascade','Location','SouthEast');

%% Design Receiver Matched Filter (Root Raised Cosine)
% This filter will filter by the same filter response as in the transmitter
% but will not decimate (to facilitate synch).

hRRC2 = comm.RaisedCosineReceiveFilter(...
'Shape',                  'Square root', ...
'RolloffFactor',          RRC_rolloff, ...
'FilterSpanInSymbols',    RRC_span, ...
'InputSamplesPerSymbol',  R_RRC * R_HB, ...
'DecimationFactor',       1);

% Extract the weights from the filter object 
% (can then refer to as WRRC.Numerator in System Generator).
WRRC2 = coeffs(hRRC2);

% create a DSP system toolbox version to permit cascading of responses
RRC2 = dsp.FIRDecimator(1,WRRC2.Numerator);

% Use a scaling factor to compensate for filter gain 
% Create an FIR with one weight equal to the scaling factor
K_RRC2 = dsp.FIRFilter('Numerator', 1/sqrt(R_RRC*R_HB));      % 1 weight filter

% Visualise response
RRC_Rx = cascade(K_RRC2,RRC2);

% Visualise response
fvRRC2 = fvtool(RRC_Rx);

%% Design of CIC and CIC compensation filters for sub-CIC filter design, 
%% and R = 5 decimation filter

CIC_i = dsp.CICDecimator(R_CIC_i, D_CIC, N_CIC, 'FixedPointDataType', 'Full precision');

CICcomp_i = dsp.CICCompensationDecimator(R_CIC_i,'DecimationFactor',2, ...
    'PassbandFrequency',0.3*fCICcomp, 'StopbandFrequency',0.4*fCICcomp, ...
    'StopbandAttenuation',80, 'PassbandRipple',0.1, 'SampleRate',fCICcomp);

CICcomp_i = dsp.CICCompensationDecimator(R_CIC_i,'DecimationFactor',2, ...
    'PassbandFrequency',0.3*fCICcomp, 'StopbandFrequency',0.4*fCICcomp, ...
    'StopbandAttenuation',80, 'PassbandRipple',0.1, 'SampleRate',fCICcomp);

WComp_i = coeffs(CICcomp_i);

% Design the R = 5 decimator filter and extract coefficients for SysGen
% block
FIR_5_w = fir1(100,0.22);
FIR_5_dec = dsp.FIRDecimator(5,FIR_5_w);

W_FIR_5 = coeffs(FIR_5_dec);