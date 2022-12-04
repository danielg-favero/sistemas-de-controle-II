clc
clear all
close all

%{
    Na parte 2, observamos que  sobressinal e o tempo de acomodação se
    aproximaram dos especificados. Todavia, houve um aumento dos ganhos
    do controlador. Ganhos elevados podem trazer problemas de implementação.
    Também implicam em maior energia necessária para se impor a dinâmica
    desejada. Estes fatores devem ser analisados ao se especificar os
    polos de malha fechada desejados. Agora, afaste ainda mais o terceiro
    polo s3, isto é, considere s3=−50. Recalcule o vetor de ganhos K e o
    ganho Kr. Observe os valores dos ganhos, o sobressinal e o tempo de
    acomodação obtidos através de simulação. É esperada uma maior
    aproximação da resposta dos valores especificados para o sobressinal e
    tempo de acomodação. Todavia, os ganhos devem ser ainda maiores.
%}

up = 0.1630;
ts = 2;

A = [0 1 0 ; 0 0 1 ; 0 -2 -3];
B = [0 ; 0 ; 1];
C = [2 0 0];
D = 0;

sys = ss(A, B, C, D);

damp = -log(up) / sqrt(pi^2 + (log(up))^2);
natural_frequency = 4 / (ts * damp);

real_s = -damp * natural_frequency;
img_s = natural_frequency * sqrt(1 - damp^2);
s1 = real_s + i * img_s;
s2 = real_s - i * img_s;
s3 = -50;

%{
    a) O vetor de ganhos do controlador é:
%}

K = place(A, B, [s1 s2 s3])

%{
    b) O ganho CC do sistema compensado é:
%}

Amf = A - B * K;
sysMF = ss(Amf, B, C, D);
dcGain = dcgain(sysMF)

%{
    c) O valor do ganho que pondera a referência é:
%}

kr = 1 / dcGain

%{
    d) A partir da simulação do sistema compensado, o sistema exibe um
    sobressinal de:
%}

Bmf = B * kr;
Cmf = C;
Dmf = D;

sysMF = ss(Amf, Bmf, Cmf, Dmf);

figure;
time = linspace(0, 10, 100);
step(sysMF, time);
title('Resposta do sistema a um degrau unitário');
xlabel('t(s)')
ylabel('Amplitude')

