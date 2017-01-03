

[A,B] = freeprecess(T,T1,T2,df); 

M = zeros(3,N);	% Keep track of magnetization at all time points.
M(:,1)=[1;0;0];	% Starting magnetization.

for d=2:N
	M(:,d) = A*M(:,d-1)+B;
end;


% Plots

time = [0:dT:T];
figure;
plot(time,M(1,:),'b');
xlabel('Time(msecs)');
ylabel('Magnetization');
axis([min(time) max(time) -1 1.3]);
figure;
plot(time,M(3,:),'r');

xlabel('Time (ms)');
ylabel('Mz');
axis([min(time) max(time) 0 1.1]);




