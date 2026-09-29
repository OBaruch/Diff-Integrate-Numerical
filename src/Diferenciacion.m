clear all;
clc;
format long
d=572;
%Método con la definición (de diferencias).
h=10.^(-(1:10));
x=d/333;
f=@(x)((0.005043774869925*x.^2)+(-0.108438359449052*x)+(0.584546100474274));



%DiferenciacionPorDefinicion
DiferenciacionPorDefinicion=(f(x+h)-f(x))./h;

%Método con el polinomio de Taylor (diferencias centradas).
DiferenciacionCentrada=(f(x+h)-f(x-h))./(2*h);

%Método de aproximación a la segunda derivada.
SegundaDerivada=(f(x+h)-2*f(x)+f(x-h))./h.^2;
%vpa([h' dfa' dfa2' dfa3'])

%ERRORS
d1faexacto=@(x)(2*x.*exp(-x)-x.^2.*exp(-x));
    % CONPMPARDO CON LA DE DEFINICION 
errorEnDiferencias=abs(DiferenciacionPorDefinicion-d1faexacto(x));
    % CONPMPARDO CON LA DE CENTRADA 
errorEnCentrada=abs(DiferenciacionCentrada-d1faexacto(x));



TITULO=(['      h            ' 'DiferenciacionPorDefinicion' '        DiferenciacionCentrada' '          SegundaDerivada''                             errorEnDiferencias''                            errorEnCentrada']);
TITULO
y=(vpa([h' DiferenciacionPorDefinicion' DiferenciacionCentrada' SegundaDerivada' errorEnDiferencias' errorEnCentrada']));
y
