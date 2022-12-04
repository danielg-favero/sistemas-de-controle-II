clc
clear all
close all

%{
    Considere o circuito da figura abaixo onde u(t) representa uma fonte
    de corrente CC. Os valores dos componentes são L = 1mH, C = 100μF e
    R = 1Ω.
%}

R = 1;
L = 0.001;
Cap = 0.0001;

%{
    Por divisor de tensão obtemos a sequinte função de transferência
%}

num = 1 / (L * Cap)
den = [1 1/(R*Cap) 1/(L*Cap)];
G = tf(num, den)

%{
    A partir da função de transferência, os polos do sistema,
    em ordem decrescente, são: 
%}

pole(G)

%{
    A partir da função de transferência G(s), considerando x1(t) = y(t)
    pode-se obter uma representação para o sistema em espaço de estados
%}

A = [0 1; -1/(L*Cap) -1/(R*Cap)]
B = [0 ; 1/(L*Cap)]
C = [1 0]
D = 0

%{
    A partir da representação do sistema em espaço de estados,
    os polos do sistema, em ordem decrescente, são:
%}

eig(A)