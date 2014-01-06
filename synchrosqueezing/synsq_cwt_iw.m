% function x = synsq_cwt_iw(Tx, fs, opt)
%
% Inverse Synchrosqueezing transform of Tx with associated
% frequencies in fs.  This implements Eq. 5 of [1].
%
% 1. G. Thakur, E. Brevdo, N.-S. Fučkar, and H.-T. Wu,
% "The Synchrosqueezing algorithm for time-varying spectral analysis: robustness
%  properties and new paleoclimate applications," Signal Processing, 93:1079-1094, 2013.
%
% Input:
%   Tx, fs: See help synsq_cwt_fw
%   opt: options structure (see help synsq_cwt_fw)
%      opt.type: type of wavelet used in synsq_cwt_fw
%
%      other wavelet options (opt.mu, opt.s) should also match
%      those used in synsq_cwt_fw
%
% Output:
%   x: reconstructed signal
%
% Example:
%   [Tx,fs] = synsq_cwt_fw(t, x, 32); % Synchrosqueezing
%   Txf = synsq_filter_pass(Tx, fs, -Inf, 1); % Pass band filter
%   xf = synsq_cwt_iw(Txf, fs);  % Filtered signal reconstruction
%
%---------------------------------------------------------------------------------
%    Synchrosqueezing Toolbox
%    Authors: Eugene Brevdo, Gaurav Thakur
%---------------------------------------------------------------------------------
function x = synsq_cwt_iw(Tx, fs, opt, t)
    if nargin<3, opt = struct(); end
    if ~isfield(opt, 'type'), opt.type = 'morlet'; end

    % Find the admissibility coefficient Cpsi
    Css = synsq_adm(opt.type, opt);

    % Due to linear discretization of integral in log(fs), this becomes a simple normalized sum.
  x = 1/Css*sum(real(Tx),1);
end