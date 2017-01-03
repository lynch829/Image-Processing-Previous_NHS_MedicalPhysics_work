
function [Afp,Bfp]=freeprecess(T,T1,T2,df)

%	Simulating the Mz relaxation and FID
%	over a time interval T, for relaxation times T1 and T2

dT = 1;		% 1ms delta-time.
T = 1;	% total duration in secs
N = ceil(T/dT); % number of time steps.
df = 10;	% Hz off-resonance.
T1 = 200;	% ms.
T2 = 150;	% ms.

phi = 2*pi*df*T/1000;	% Resonant precession, radians.
E1 = exp(-T/T1);	
E2 = exp(-T/T2);

Afp = [E2 0 0;0 E2 0;0 0 E1]*zrot(phi);
Bfp = [0 0 1-E1]';



