function [M, alpha]=kaiser_params(ripple_p,Delta)


A=-20*log10(ripple_p/100);

if((A<=21)) alpha=0; end
if((A>21) && (A<50) ) alpha=0.5842*(A-21)^0.4+0.07886*(A-21); end
if (A>=50) alpha=0.1102*(A-8.7); end

M=ceil((A-7.95)/(28.72*Delta));
