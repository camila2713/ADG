function [m,s]=movil(v,n)
%% VARIABLES DE ENTRADA
% v es el vector sin tiempo
% n es el espaciado
%% VARIABLES DE SALIDA
% m es la media movil
% s desviacion estandar movil
l=length(v); %calcula el largo del vector
for i=1:(l-n+1)
mv(i)=mean(v(i:(i+n-1))); %calcula la media movil
st_mv(i)=std(v(i:(i+n-1)));
end
m=mv;
s=st_mv;
end