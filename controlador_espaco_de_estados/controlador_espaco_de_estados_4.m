clc
close all
clear all

%{
    Este é um sistema instável. Deseja-se que o sistema siga uma
    referência do tipo degrau com erro nulo. Adicionalmente,
    o sistema deve se comportar como um sistema criticamente amortecido,
    isto é, o sobressinal deve ser nulo. A frequência natural dos polos
    de malha fechada deve ser ωn=4 rad/s. Projete o vetor de ganhos K e o
    ganho Kr para atender as especificações do problema.
%}

up = 0;
damp = 1;
natural_frequency = 4;

A = [0 1 ; 1 0];
B = [0 ; 1];
C = [1 0];
D = 0;

sys = ss(A, B, C, D);

%{
    a) Os polos do sistema são (do menor para o maior):
%}

eig(A)

%{
    b) Assim, os polos do sistema compensado são:
%}

real_s = -damp * natural_frequency;
img_s = natural_frequency * sqrt(1 - damp^2)
s1 = real_s + i * img_s
s2 = real_s - i * img_s

%{
    c) A matriz de controlabilidade tem a forma:
%}

M = ctrb(A, B)

%{
    d) O posto da matriz de controlabilidade é:
%}

rank(M)

%{
    e) O vetor de ganhos do controlador é:
%}

phi = (A - s1 * eye(2)) * (A - s2 * eye(2));
K = [0 1] * inv(M) * phi

%{
    f) O ganho CC do sistema compensado é:
%}

Amf = A - B * K;
sysMF = ss(Amf, B, C, D);
dcGain = dcgain(sysMF)

%{
    g) O valor do ganho que pondera a referência é: 
%}

kr = 1 / dcGain

%{
    h) A partir da simulação do sistema compensado, o sistema exibe um
    sobressinal e tempo de acomodação de:
%}

Bmf = B * kr;

step(Amf, Bmf, C, D)
