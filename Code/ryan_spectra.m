% FID and spectra simulation

dwell_time = 1e-2;  % dwell time is the sampling interval 
BW = 1/dwell_time ;    % Bandwidth is 1/dwell time . Typically 10kHz
f = 50;    % frequency
omega = 2*pi*f;
       
phase =0;  % No phase shift so set to 0 
W =  3 ; % Water concentration
A = 10; % Concentration of metabolite A
B =6 ; % Concentration of metabolite B 
T2star_W = 0.2;
T2star_A = 0.3;
T2star_B = 0.25;

t = zeros(1,1024);

for count =1:1024;

    t(count) = dwell_time*(count-1);

end

FID_real_water = W*cos(omega*t+ phase).*exp(-t/T2star_W);
FID_imaginary_water =W*sin(omega*t + phase).*exp(-t/T2star_W);
FID_real_A = A*cos(omega*t+ phase).*exp(-t/T2star_A);
FID_imaginary_A =A*sin(omega*t + phase).*exp(-t/T2star_A);
FID_real_B = B*cos(omega*t + phase).*exp(-t/T2star_B);
FID_imaginary_B = B*cos(omega*t + phase).*exp(-t/T2star_B);


Sum_real = FID_real_water + FID_real_A + FID_real_B;
Sum_Imag = FID_imaginary_water + FID_imaginary_A + FID_imaginary_B;

complex_FID = complex(Sum_real,Sum_Imag);
spectra = fftshift(fft(complex_FID)) ;
real_spectra =real(spectra);
imaginary_spectra = imag(spectra);

%%-----------------------------------------------------

figure(1) 
plot(t,Sum_real);
title('real FID');
xlabel('Time from the start of the FID ')
ylabel('Amplitude of FID'); 

figure(2)
plot(t,Sum_Imag);
title('imaginary FID');
xlabel('Time from the start of the FID ')
ylabel('Amplitude of FID');


figure(3)
plot(t,complex_FID);
title('complex FID');
xlabel('Time from the start of the FID ')
ylabel('Amplitude of FID');

figure(4)
plot(t,real_spectra);
title('Spectra- Real part');
xlabel('ppm')
ylabel('Amplitude');

figure(5)
plot(t,imaginary_spectra);
title('Spectra- Imaginary part');
xlabel('ppm')
ylabel('Amplitude');

figure(6)
plot(t,spectra);
title('Spectra-complex FID');
xlabel('ppm')
ylabel('Amplitude');
