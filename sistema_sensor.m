function [H,f_s]=sistema_sensor(Omega)

f_s=20000;

H=zeros(1,length(Omega));

H=H+1/1*((Omega>=0) & Omega<(2*pi*900/f_s));

H=H+1/0.15*(Omega>=(2*pi*900/f_s) & Omega<(2*pi*1600/f_s));

H=H+1/1.27*(Omega>=(2*pi*1600/f_s) & Omega<(2*pi*3500/f_s));

H=H+1/0.85*(Omega>=(2*pi*3500/f_s) & Omega<(2*pi*5000/f_s));

H=H+1/0.95*(Omega>=(2*pi*5000/f_s) & Omega<(2*pi*6500/f_s));

H=H+1/1*(Omega>=(2*pi*6500/f_s) & Omega<=(2*pi*10000/f_s));

