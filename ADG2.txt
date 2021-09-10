load('CERT2_ADG_SERIES.mat')


figure()
plot(SG1(:,1),SG1(:,2),'LineWidth',2) 
axis tight
grid on
xlabel('Tiempo [años]')
ylabel( 'Magnitud')
title('Sismicidad de magnitud superior o igual a 6.9, sobre toda la tierra entre los años 1900 y 2019')


%%%%%%%%%%%%%%
anos=[1900:2018];
anos=anos'

n=0;
k=1/12; % 1 mes
u=1/24; % 15 dias
y0=anos(1,1)-u; %esto me deja en diciembre
c=y0+k; %esto me deja en enero 15 
for i=1:1416 %2018-1900
    n=n+k;
    x(i,1)=c+n-k-u;
end

SG1_INT2(:,1)=x(:,1);


inter2=interp1(SG1(:,1),SG1(:,2),SG1_INT2(:,1),'cubic');
SG1_INT2(:,2)=inter2;

plot(SG1(:,1),SG1(:,2),'r')
hold on
plot(SG1_INT(:,1),inter)

SG1_INT(:,3)=mean(SG1_INT(:,2)); %media de la serie
SG1_INT(:,4)=std(SG1_INT(:,2)); %desviacion estandar de la serie

p=polyfit(SG1_INT(:,1),SG1_INT(:,2),1);
pv=polyval(p,SG1_INT(:,1));

%pendiente de -0.0014 y coef de 10.2256

figure()
plot(SG1_INT(:,1),SG1_INT(:,2),'LineWidth',2)
hold on
plot(SG1_INT(:,1),pv,'r','LineWidth',2)
hold on 
plot(SG1_INT(:,1),SG1_INT(:,3),'k','LineWidth',2)
plot(SG1_INT(:,1),SG1_INT(:,3)-SG1_INT(:,4),'g','LineWidth',2)
plot(SG1_INT(:,1),SG1_INT(:,3)+SG1_INT(:,4),'g','LineWidth',2)
axis tight

title('Sismicidad de magnitud superior o igual a 6.9, sobre toda la tierra entre los años 1900 y 2019')
legend('Serie original','Pendiente','Media','Desviacion estandar')
xlabel('Tiempo [años]')
ylabel('Magnitud')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
figure()
boxplot(SG1_INT(:,2),'orientation','horizontal','whisker',1)
title('boxplot serie de datos interpolada')


%%%%%%%%%%%%%%%%%%%%%%%55
%ej 4
m=0;
for i=1:12:length(SG1_INT)-12
    m=m+1;
    SG1_AN(m,1)=SG1_INT(i+6,1); %se fecha a la mitad del año
    SG1_AN(m,2)=mean(SG1_INT(i:i+12,2));
end

figure()
plot(SG1_INT(:,1),SG1_INT(:,2))
hold on
plot(SG1_AN(:,1),SG1_AN(:,2),'r')
xlabel('Año')
ylabel('Magnitud')
title('Eventos sísmicos mayores o iguales a 6.9 sobre la Tierra entre 1900 y 2019 con datos interpolados y media anual')

hold off






figure()
plot(SG1_INT(:,1),SG1_INT(:,2),'b','Linewidth',2)
hold on
plot(SG1_AN(:,1),SG1_AN(:,2),'r','Linewidth',2)
xlabel('Tiempo [años]')
ylabel('Magnitud')
title('Eventos sismiscos de magnitud igual o superior a 6.9')
legend('Serie original','serie anual')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=9;
l=length(SG1_AN(:,2)); %calcula el largo del vector
c=N-1;
for i=1:(l-c)
medianamovil(i,1)=median(SG1_AN(i:(i+c),2)); %calcula la mediana movil
QI25_CMV(i,1)=prctile(SG1_AN(i:(i+c),2),25);
QI75_CMV(i,1)=prctile(SG1_AN(i:(i+c),2),75);

yearmovil(i,1) = sum(SG1_AN(i:(N+i-1),1))/N;
end

plot(SG1_AN(:,1),SG1_AN(:,2),'b','Linewidth',3)
hold on
plot(yearmovil,medianamovil,'r','Linewidth',3)
hold on 
plot(yearmovil,QI25_CMV,'g:','Linewidth',3)
hold on 
plot(yearmovil,QI75_CMV,'g.','Linewidth',3)
xlabel('Tiempo [años]')
ylabel('Magnitud')
title('Sismos de magnitud igual o superior a 6.9')
legend('Serie Anual','mediana movil', ',Cuartil 25', 'Cuartil 75')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%tenemos que 0.111 años-1 equivale a 9 años 
ventana=9;
vg1=gausswin(ventana);
bg1 =vg1./sum(vg1);
v9 = filtfilt(bg1,1,SG1_AN(:,2));

%
ventana2=21; %años
vg=gausswin(ventana2);
bg2 =vg./sum(vg);
v21= filtfilt(bg2,1,SG1_AN(:,2));

pasaalto=SG1_AN(:,2)-v21;
pasabanda= v9-v21;

s(1)=subplot(3,1,1)

plot(SG1_AN(:,1),SG1_AN(:,2),'b','LineWidth',2)
hold on
plot(SG1_AN(:,1),v9,'r','LineWidth',2)
legend('Serie anual','Filtro pasa bajo de 1/9 años -1')
title(s(1),'Eventos sismicos de magnitud igual o mayor a 6.9')
xlabel(s(1),'Tiempo[años]')
ylabel(s(1),'Magnitud')

s(2)=subplot(3,1,2)

plot(SG1_AN(:,1),SG1_AN(:,2),'b','LineWidth',2)
hold on
plot(SG1_AN(:,1),pasaalto,'r','LineWidth',2)
legend('Serie anual', 'filtro pasa alto de 1/21 años -1')
title(s(2),'Eventos sismicos de magnitud igual o mayor a 6.9')
xlabel(s(2),'Tiempo[años]')
ylabel(s(2),'Magnitud')

s(3)=subplot(3,1,3)

plot(SG1_AN(:,1),SG1_AN(:,2),'b','LineWidth',2)
hold on
plot(SG1_AN(:,1),v9-v21,'r','LineWidth',2)
legend('Serie anual', 'filtro pasa banda entre 1/9 y 1/21 años -1')
title(s(3),'Eventos sismicos de magnitud igual o mayor a 6.9')
xlabel(s(3),'Tiempo[años]')
ylabel(s(3),'Magnitud')


