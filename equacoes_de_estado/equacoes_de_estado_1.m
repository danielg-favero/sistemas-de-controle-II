clc
clear all
close all

%{
    Considere o sistema abaixo onde u(t) é um degrau unitário.
    Obtenha a solução das equações de estado.
%}

A = [0 1; -6 -5]
B = [0 ; 1]
C = [1 0]
D = 0
sys = ss(A, B, C, D);

%{
    a) Os polos do sistema são (do maior para o menor):
%}

eig(A)

%{
    b) Os coeficientes do polinômio den(s) e dos elementos ϕij(s)
    da matriz são:
%}

syms s
phi_s = inv(s * eye(2) - A)

%{
    c) A matriz ϕ(t)=e^At tem a forma ϕ(t)=[ϕ11(t) ϕ21(t) ; ϕ12(t) ϕ22(t)].
    Os elementos ϕij(t) da matriz são:
%}

syms t
phi = expm(A * t)

%{
    d) A solução das equações de estados é dada por:
    onde,
%}

syms tau
f = expand(int(expm(A * (t-tau)) * B, tau, 0, t))

%{
    e) Consequentemente, considerando x(0) = 0, no instante t = 1s a saída
    y(t) do sistema vale:
%}

% Condições iniciais
x0 = [0; 0];

% Tempo de simulação
time = linspace(0, 10, 100);

% Resposta à função forçante
[Yu t_plot Xu] = step(sys, time);
Yu;

figure;
plot(t_plot, Xu);
title('Resposta do sistema à função forçanete')
xlabel('t(s)');
ylabel('Amplitude');
legend('x_1', 'x_2');

% Resposta às condições iniciais
[Yo t_plot0 Xo] = initial(sys, x0, time);
Yo;

figure;
plot(t_plot0, Xo);
title('Resposta do sistema às condições iniciais')
xlabel('t(s)');
ylabel('Amplitude');
legend('x_1', 'x_2');

% Resposta completa
Xt = Xu + Xo;

figure;
plot(t_plot0, Xt);
title('Resposta completa')
xlabel('t(s)');
ylabel('Amplitude');
legend('x_1', 'x_2');