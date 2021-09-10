% funcion para obtener todos los estadisticos necesarios
% recordar poner [mm,dm,s]=estadisticos(data1)
function [Mm,Dm,S]=estadisticos(x,N)
media = mean(x);
desviacion = std(x);
varianza = var(x);

% estadisticos moviles cada N datos, restamos N-1 para asi tomar el
% intervalo de datos que necesita la media/desviasion movil
c=N-1;
for j=1:length(x)-c
  med_m(j)=mean(x(j:j+c));
  desv_m(j)=std(x(j:j+c));
end

Mm=med_m
Dm=desv_m;
S=[media desviacion varianza];

end

