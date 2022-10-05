clc
clear all
close all

%{
    Considere o sistema descrito na figura abaixo onde
    G(s) = 1 / s(s + 1)(s + 20) e C(s) = Kp (1 + 1 / Tis + Tds) é um
    controlador PID a ser projetado pelo segundo método de
    Ziegler-Nichols. Deseja-se que o sobressinal para a entrada
    degrau unitário seja de no máximo 10%.
%}

% Não é possível utilizar o primeiro método, pois há um integrador na
% planta

num_g = 1;
den_g = [1 21 20 0];
G = tf(num_g, den_g)

%{
    a) Para estes sistema, o ganho crítico é:
%}

Kcr = 420

%{
    b) E o período crítico é:
%}

step(feedback(G * Kcr, 1))
Pcr = 1.410

%{
    c) Os parâmetros do compensador, de acordo com o método de
    Ziegler-Nichols:
%}

Kp = 0.6 * Kcr
Ti = 0.5 * Pcr
Td = 0.125 * Pcr

%{
    d) Com isso, o controlador PID tem a função de transferência dada por:
%}

s = tf('s');
C = minreal(Kp * (1 + 1 / (Ti * s) + Td * s))

%{
    e) O sobressinal obtido com esse controlador é:
%}

Gc = C * G;
Gcmf = feedback(Gc, 1);
step(Gcmf)

%{
    f) Para aproximar o sobressinal desejado, podemos definir que os
    dois zeros do controlador PID estejam em s = -0.5. Assim:
%}

% Kp (1 + 1 / Tis + Tds)
% Kp + Ki / s + Kd * s
% (Kd * s^2 + Kp * s + Ki) / s

z = 0.5;
new_Ti = 1 / (z * z)
new_Td = 1 / (z + z)

%{
    g) Mantendo o ganho Kp calculado, o controlador obtido é:
%}

new_C = minreal(Kp * (1 + 1 / (new_Ti * s) + new_Td * s))

%{
    h) o sobressinal obtido é de:
%}

step(feedback(G * new_C, 1))





