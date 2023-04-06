
clc;
close all;
clear all;

%Longitud del filtro
N_h=251;


%Se determina si se desea una respuesta impulsional
%simétrica o antisimétrica
is_antisimetric=1;

if (rem(N_h,2)) 
    %Impar
    k=0:((N_h-1)/2);
else
    %Par
    k=0:(N_h/2); 
end

%Vector de frecuencias
Omega_k=2*pi*k/N_h;


[H_r, fs]=sistema_sensor(Omega_k);


%Se evalua la respuesta deseada
if(is_antisimetric)
    G=-j*H_r;
else
    G=H_r;
end


figure;
stem(Omega_k,abs(G));
grid on;
hold on;
Omega_k=0:0.001:pi;
plot(Omega_k,sistema_sensor(Omega_k),'r');


%Se calcula la reflexión
if (rem(N_h,2)) 
    %Impar
    H=[G conj(fliplr(G(2:(N_h+1)/2)))];
else
    %Par
    H=[G conj(fliplr(G(2:N_h/2)))];
end


figure;
stem(2*pi*(0:N_h-1)/N_h,abs(H));
grid on;

%Se vuelve causal
if (rem(N_h,2)) 
    %Impar
    H_c=H.*exp(-j*2*pi*(0:(N_h-1))/N_h*(N_h-1)/2);
else
    %Par
  
    H_c=H.*(-1).^(0:(N_h-1));
end

%Se obtiene la respuesta al impulso
 
   h_c=real(ifft(H_c)).*hanning(N_h)';

%Respuesta en frecuencia
[H ,Omega ]=freqz(h_c);

figure;
plot(Omega/(2*pi)*fs,(abs(H)));
grid on;
figure;
stem(h_c);
grid on;




