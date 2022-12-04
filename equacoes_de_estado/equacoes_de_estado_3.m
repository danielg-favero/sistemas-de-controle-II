clc
clear all
close all

%{
    Considere o sistema abaixo onde u(t) é um degrau unitário.
    Obtenha a solução das equações de estado
%}

A = [0 1 ; -13 -4];
B = [0  ; 1];
C = [1 0];
D = 0;
sys = ss(A, B, C, D);

%{
    a) Os polos do sistema são:
%}

eig(A)

%{
    b) A matriz ϕ(s) = (sI−A)^−1 tem a forma ϕ(s) = 1/den(s)[ϕ11(s) ϕ21(s) ;
    ϕ12(s) ϕ22(s)]. Os coeficientes do polinômio den(s) e dos elementos
    ϕij(s) da matriz são:
%}

syms s
phi_s = inv(s * eye(2) - A)

%{
    c) A matriz ϕ(t) = e^At tem a forma ϕ(t) = [ϕ11(t) ϕ21(t) ; 
    ϕ12(t) ϕ22(t)]. Os elementos ϕij(t) da matriz são:
%}

syms t
phi = ilaplace(inv(s * eye(2) - A))

%{
    d) A solução das equações de estados é dada por:
    onde,
%}

syms tau
f = int(expm(A * t) * B, tau, 0, t)

%{
    e) Consequentemente, considerando x(0) = 0, no instante t=1s a saída
    y(t) do sistema vale:
%}

% Condições iniciais
x0 = [0 ; 0];

% Tempo de simulação
time = linspace(0, 10, 100);

% Resposta a função forçante
[Yu t_plot Xu] = step(sys, time);
Yu;
