% Trying to create a spectrum with Naa, Cr and Cho peaks. Starting off with
% FIDs corresponding to each frequency (each with a different amplitude), 
% then adding them together, adding noise, apodisation, zero filling, 0th and 1st order phase shifts.

ppm_naa = 2;
ppm_cr = 3;
ppm_cho = 3.2;                              % parts per million

hz_naa = 200e6*ppm_naa/1e6;
hz_cr = 200e6*ppm_cr/1e6;
hz_cho = 200e6*ppm_cho/1e6;                 % freqs in Hz

freq_naa = hz_naa*2*pi;                     % FID Frequency - Naa
freq_cr = hz_cr*2*pi;                       % FID Frequency - Cr
freq_cho = hz_cho*2*pi;                     % FID Frequency - Cho

amp_naa = 1;
amp_cr = 2;
amp_cho = 3;                                % amplitudes
    
T2 = 10e-3;                                 % T2
Dwt = 71.4e-6;                              % dwell time
apod = 10e-3;                               % apodisation
phase_deg = input('what phase do you want (in degrees)?')
phase_rad = (phase_deg*2*pi)/360
    %------------FID simulation--------------------------------------
for cnt = 1:1024 
    t = Dwt*cnt;                         % Partial FID time 
   
    noise1 = rand(1) - 0.5;                  % randomly generated noise. Done twice so it is different for the real and imaginary parts? 
    noise2 = rand(1) - 0.5;

    test_arrayr(cnt) = (exp(-t/T2)) *amp_naa* sin(freq_naa * t + phase_rad);    % FID with naa real component
    test_arrayi(cnt) = (exp(-t/T2)) *amp_naa* cos(freq_naa * t + phase_rad);    % FID with naa imaginary component
    
    test_arrayr2(cnt) = (exp(-t/T2)) *amp_cr* sin(freq_cr * t);    % FID with cr real component
    test_arrayi2(cnt) = (exp(-t/T2)) *amp_cr* cos(freq_cr * t);    % FID with cr imaginary component
    
    test_arrayr3(cnt) = (exp(-t/T2)) *amp_cho* sin(freq_cho * t);    % FID with cho real component
    test_arrayi3(cnt) = (exp(-t/T2)) *amp_cho* cos(freq_cho * t);    % FID with cho imaginary component
    
    test_arrayr4(cnt) = test_arrayr(cnt) +  test_arrayr2(cnt) + test_arrayr3(cnt);  % sum of 3 FIDs real
    test_arrayi4(cnt) = test_arrayi(cnt) +  test_arrayi2(cnt) + test_arrayi3(cnt);  % sum of 3 FIDs imaginary

    with_noiser(cnt) = test_arrayr4(cnt) + noise1;
    with_noisei(cnt) = test_arrayi4(cnt) + noise2;
    
    with_apodisationr(cnt)= with_noiser(cnt) * exp(-t/apod);
    with_apodisationi(cnt)= with_noisei(cnt) * exp(-t/apod);
    
 end 
 
comp_data = complex(test_arrayr, test_arrayi);         
comp_data2 = complex(test_arrayr2, test_arrayi2);        
comp_data3= complex(test_arrayr3, test_arrayi3);       
comp_data4 = complex(test_arrayr4, test_arrayi4);         % complex returns the complex result A + Bi
comp_noise = complex(with_noiser, with_noisei);
comp_apod = complex(with_apodisationr, with_apodisationi);

comp_1st_phase1 = comp_apod(1:900);                       % with different 1st order phase shifts
comp_1st_phase2 = comp_apod(1:800);
comp_1st_phase3 = comp_apod(1:700);
comp_1st_phase4 = comp_apod(1:600);

spec = fftshift(fft(comp_data));                         
spec2 = fftshift(fft(comp_data2));                       
spec3 = fftshift(fft(comp_data3));                          
spec4 = fftshift(fft(comp_data4));                         % FT 
spec_noise = fftshift(fft(comp_noise)); 
spec_apod = fftshift(fft(comp_apod)); 
spec_zf = fftshift(fft(comp_apod,2048));   %FT with zero filling?

spec_1st_phase1 = fftshift(fft(comp_1st_phase1));         % FT with different 1st order phase shifts
spec_1st_phase2 = fftshift(fft(comp_1st_phase2));
spec_1st_phase3 = fftshift(fft(comp_1st_phase3));
spec_1st_phase4 = fftshift(fft(comp_1st_phase4));

% figure(1);
% plot(test_arrayr);
% title(strcat('Time Domain(real) ', num2str(phase_deg)));   % Signal 1
% 
% figure(2);
% plot(test_arrayi);
% title(strcat('Time Domain(imag) ', num2str(phase_deg)));  
% 
% figure(3);
% plot(test_arrayr2);
% title('Time Domain(real)');                 % Signal 2
% 
% figure(4);
% plot(test_arrayi2);
% title('Time Domain(imag)');
% 
% figure(5);
% plot(test_arrayr3);
% title('Time Domain(real)');                 % Signal 3
% 
% figure(6);
% plot(test_arrayi3);
% title('Time Domain(imag)');

figure(7);
plot(test_arrayr4);
title('Time Domain(real)');                 % All 3 added together

figure(8);
plot(test_arrayi4);
title('Time Domain(imag)');

% figure(9)
% plot(real(spec));
% title(strcat('Fourier Transform - real ', num2str(phase_deg)));          % FT of signal 1
% 
% figure(10)
% plot(imag(spec));
% title(strcat('Fourier Transform - imag ', num2str(phase_deg)));  
% 
% figure(11)
% plot(real(spec2));
% title('Fourier Transform - real');          % FT of signal 2     
% 
% figure(12)
% plot(imag(spec2));
% title('Fourier Transform - imag');
% 
% figure(13)
% plot(real(spec3));
% title('Fourier Transform - real');          % FT of signal 3
% 
% figure(14)
% plot(imag(spec3));
% title('Fourier Transform - imag');

figure(15)
plot(real(spec4));
title('Fourier Transform - real');          % FT of all 3 signals added together

figure(16)
plot(imag(spec4));
title('Fourier Transform - imag');

figure(17);
plot(with_noiser);
title('Time Domain(real)');                 % All 3 added together with random noise

figure(18);
plot(with_noisei);
title('Time Domain(imag)');

figure(19);
plot(with_apodisationr);
title('Time Domain(real)');                 % All 3 added together with random noise then apodised

figure(20);
plot(with_apodisationi);
title('Time Domain(imag)');

% figure(21)
% plot(real(spec_noise));
% title('Fourier Transform - real');          % FT with noise     
% 
% figure(22)
% plot(imag(spec_noise));
% title('Fourier Transform - imag');

figure(23)
plot(real(spec_apod));
title('Fourier Transform - real');          % FT with apodisation    

figure(24)
plot(imag(spec_apod));
title('Fourier Transform - imag');

figure(25)
plot(real(spec_1st_phase1));
title('Fourier Transform - real');          % FT 1st order phasing

figure(26)
plot(imag(spec_1st_phase1));
title('Fourier Transform - imag');

figure(27)
plot(real(spec_1st_phase2));
title('Fourier Transform - real');          % FT 1st order phasing

figure(28)
plot(imag(spec_1st_phase2));
title('Fourier Transform - imag');

figure(29)
plot(real(spec_1st_phase3));
title('Fourier Transform - real');          % FT 1st order phasing

figure(30)
plot(imag(spec_1st_phase3));
title('Fourier Transform - imag');

figure(31)
plot(real(spec_1st_phase4));
title('Fourier Transform - real');          % FT 1st order phasing

figure(32)
plot(imag(spec_1st_phase4));
title('Fourier Transform - imag');

figure(33)
plot(real(spec_zf));
title('Fourier Transform - real');          % FT with zero filling?

figure(34)
plot(imag(spec_zf));
title('Fourier Transform - imag');

