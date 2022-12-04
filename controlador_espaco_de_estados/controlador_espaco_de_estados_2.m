clc
clear all
close all

%{
    Na parte 1, o sobressinal e o tempo de acomodação foram distintos
    dos especificados por termos escolhido o terceiro polo s3 muito
    próximo dos polos dominantes de malha fechada. Para aproximar o
    comportamento transitório deste sistema de terceira ordem do
    comportamento de um sistema de segunda ordem, escolha o terceiro
    polo mais afastado dos polos dominantes, isto é, s3=−20. Recalcule o
    vetor de ganhos K e o ganho Kr. Observe os valores dos ganhos, o
    sobressinal e o tempo de acomodação obtidos através de simulação.
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
s3 = -20;

%{
    a) O vetor de ganhos do controlador é:
%}

M = ctrb(A, B);
K = place(A, B, [s1, s2, s3])

%{
    b) O ganho CC do sistema compensado é:
%}

Amf = A - B * K

sysMF = ss(Amf, B, C, D);
dcGain = dcgain(sysMF)

%{
    c) O valor do ganho que pondera a referência é: Kr
%}

kr = 1 / dcGain

Bmf = B * kr
Cmf = C
Dmf = D;

sysMF = ss(Amf, Bmf, Cmf, Dmf);

%{
    d) A partir da simulação do sistema compensado, o sistema exibe um
    sobressinal de:
%}

figure;
time = linspace(0, 10, 100);
step(sysMF, time);
title('Resposta do sistema a um degrau unitário')
xlabel('t(s)');
ylabel('Amplitude')

