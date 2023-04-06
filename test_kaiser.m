clc;
close all;
clear all;

%Frecuencia de muestreo
fs=200;

%Frecuencia de corte del filtro pasa-bajos
fc=20;

%Normaliza la frecuencia de corte
Omc=2*pi*fc/fs;

%Ancho de banda de transición
Delta_Hz = 5;

%Atenuación en la banda de rechazo
A=40;


delta= 10^(A/-20);







[M, alpha]=kaiser_params(delta*100,Delta_Hz/fs);

n=-M:M;


h_lp = Omc/pi*sinc(Omc/pi*n);

[H ,Om]=freqz(h_lp,1,65536);

figure;
plot(Om/(2*pi)*fs,20*log10(abs(H)));


h_wk=h_lp.*kaiser(2*M+1,alpha)';



[H, Om]=freqz(h_wk,1,65536);

figure;
 plot(Om/(2*pi)*fs,20*log10(abs(H)));
% plot(Om/(2*pi)*fs,(abs(H)));
grid on;
xlabel('Hz');
ylabel('dB');


file=fopen('../arduino/test_conv/coefs_filter.h','w+');


fprintf(file,'#define P %d\n',2*M+1);
fprintf(file,'#define FS %d\n\n',int16(fs));
fprintf(file,'double h[P]={\n');
fprintf(file,'%f,\n',h_wk);
fprintf(file,'};\n');

fclose(file);

