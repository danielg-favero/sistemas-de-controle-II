clc
clear all
close all

%{
    Considere o sistema descrito na figura abaixo onde
    G(s) = 10 / (s+1)(s+5) e C(s) = Kp (1 + 1 / Tis + Tds) é um
    controlador PID a ser projetado. Deseja-se que o sobressinal
    máximo para a entrada degrau unitário seja de, aproximadamente, 25%.
    Preencha as lacunas com as respostas com 3 algarismos significativos
    após a vírgula.
%}

num_g = 10;
den_g = [1 6 5];
G = tf(num_g, den_g)

up = 0.25;
T = 1.62 - 0.106;
L = 0.106;

step(G)

%{
    a) Os parâmetros do compensador, de acordo com o método de
    Ziegler-Nichols:
%}

Kp = 1.2 * T / L
Ti = 2 * L
Td = 0.5 * L

%{
    b) Com isso, o controlador PID tem a função de transferência dada por:
%}

s = tf('s');
C = minreal(Kp * (1 + 1 / (Ti * s) + Td * s))

%{
    c) O sobressinal obtido com esse controlador (via simulação) é:
%}

Gc = C * G;
Gcmf = feedback(Gc, 1);
step(Gcmf)

%{
    d) Para aproximar o sobressinal desejado, podemos elevar o valor de Td:
%}

new_Td = 0.075;
new_C = minreal(Kp * (1 + 1 / (Ti * s) + new_Td * s))
new_Gc = new_C * G;
new_Gcmf = feedback(new_Gc, 1);
step(new_Gcmf)

