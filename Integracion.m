clear all;
%clc;
format long 
d=572;
salida=[];

f=@(x)(d*x.^2.*exp(-x)+(1/d)); % Valor de la función en los puntos elegidos.
a=0; % Límite inferior.
b=10; % Límite superior.
N=594; % Número de intervalos1. 
h=(b-a)/N; % Tamaño de cada intervalo.
intexacta=vpa(integral(f,a,b));

 % Cuadratura de Gauss de dos puntos.___________________________
 no = 2; % Número de puntos.
 h = (b-a)/(no/2); % Tamaño del intervalo.
 r = [-1/sqrt(3) 1/sqrt(3)]; % Raíces del polinomio de Legendre de orden 2.
 x = ((b-a).*r+b+a)/2; % Nodos.
 k = 1; % Contador de iteraciones.
 y=f(x);
 CuadraturaGauss2P= vpa((h/2)*(sum(y)));
 error7=abs(intexacta-CuadraturaGauss2P);
 
% Cuadratura de Gauss de tres puntos.___________________________
no2 = 3; % Número de puntos.
h = (b-a)/(no2/3); % Tamaño del intervalo.
r = [-sqrt(3/5) 0 sqrt(3/5)]; % Raíces del polinomio de Legendre de orden 3.
x = ((b-a).*r+b+a)/2; % Nodos.
y=f(x);
k = 1; % Contador de iteraciones.
% Primer resultado de la integral con un solo intervalo.
CuadraturaGauss3P= vpa((h/2)*((5/9)*y(1)+(8/9)*y(2)+(5/9)*y(3)));
 error8=abs(intexacta-CuadraturaGauss3P);

 

%h____________________________________________________________
h=(b-a)/N;

%Puntos internos______________________________________________
x=linspace(a,b,N+1); % Vector de muestras.
x=x(1:N); %rectangulos interiores
y=f(x);
IntegralPorIzq=vpa(sum(y*h));
error1=abs(intexacta-IntegralPorIzq);

%Puntos externos______________________________________________
x=linspace(a,b,N+1); % Vector de muestras.
x=x(2:N+1); %rectangulos exteriores
y=f(x);
IntegralPorDech=vpa(sum(y*h));
error2=abs(intexacta-IntegralPorDech);


%Puntos medios_______________________________________________
x=linspace(a,b,N+1); % Vector de muestras.
x=x(1:N)+(h/2); %rectangulos interiores
y=f(x);
IntegralPorCntr=vpa(sum(y*h));
error3=abs(intexacta-IntegralPorCntr);


%Trapecios___________________________________________________
x=linspace(a,b,N+1); % Vector de muestras.
y=(f(x(1))+2*sum(f(x(2:N)))+f(x(N+1)))/2;
IntegralPorTrap=vpa(sum(y*h));
error4=abs(intexacta-IntegralPorTrap);


%Simpson 1/3
sumai=0;
sumap=0;
for i=1:2:N-1
    sumai=sumai+feval(f,h*i+a);
end
for i=2:2:N-2
    sumap=sumap+feval(f,h*i+a);
end
IntegralPorSIM13=vpa((h/3)*(feval(f,a)+4*sumai+2*sumap+feval(f,b)));
error5=abs(intexacta-IntegralPorSIM13);


%Simpson 3/8
x(1)=a;
sum=f(a);
for i=2:N
    x(i)=x(i-1)+h;
end
for j=2:3:N
    sum=sum+3*f(x(j));
end
for k=3:3:N
    sum=sum+3*f(x(k));
end
for l=4:3:N
    sum=sum+2*f(x(l));
end
sum=sum+f(b);
IntegralPorSIM38=vpa(sum*3*h/8);
error6=abs(intexacta-IntegralPorSIM38);


%
 %

Resultados=[ [ IntegralPorIzq IntegralPorDech IntegralPorCntr IntegralPorTrap IntegralPorSIM13 IntegralPorSIM38 CuadraturaGauss2P CuadraturaGauss3P]' [error1, error2, error3, error4, error5, error6 error7 error8]'];

fprintf('h: %f\n', h); 
fprintf('Intergal exacta: %f\n', intexacta);
Resultados 