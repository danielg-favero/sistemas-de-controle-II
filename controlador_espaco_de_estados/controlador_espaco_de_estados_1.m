clc
clear all
close all

%{
    Deseja-se que o sistema siga uma referência do tipo degrau com
    erro nulo. Adicionalmente, os polos dominantes devem fornecer
    sobressinal de 16,3% e tempo de acomodação de 2 segundos para o
    critério de 2%. Projete o vetor de ganhos K e o ganho Kr para
    atender as especificações do problema.
%}

up = 0.1630;
ts = 2;

A = [0 1 0 ; 0 0 1 ; 0 -2 -3];
B = [0 ; 0 ; 1];
C = [2 0 0];
D = 0;
sys = ss(A, B, C, D)

%{
    a) Para atender as especificações do problema, o coeficiente de 
    amortecimento dos polos dominantes e a frequência natural associada é:
%}

damp = -log(up) / sqrt(pi^2 + (log(up))^2)
natural_frequency = 4 / (damp * ts)

%{
    b) Assim, os polos dominantes do sistema compensado são: 
%}

real_s1 = -damp * natural_frequency;
img_s1 = natural_frequency * sqrt(1 - damp^2)
s1 = real_s1 + i * img_s1
s2 = real_s1 - i * img_s1

%{
    Para o cálculo do vetor de ganhos K e do ganho Kr considere que o
    terceiro polo do sistema compensado é s3 = −5.
%}

s3 = -5;

%{
    c) A matriz de controlabilidade tem a forma
%}

M = ctrb(A, B)
rank(M)

%{
    d) O vetor de ganhos do controlador é:
%}

phi = (A - s1 * eye(3)) * (A - s2 * eye(3)) * (A - s3 * eye(3))
K = [0 0 1] * inv(M) * phi

%{
    Ou então...

    desired_poles = [s1 s2 s3];
    K = place(A, B, desired_poles)
%}

%{
    e) O ganho CC do sistema compensado é:
%}

kr = 1

Amf = A - B * K;
Bmf = B * kr;
Cmf = C;
Dmf = D;

sysMF = ss(Amf, Bmf, Cmf, Dmf);
dcGain = dcgain(sysMF)

%{
    f) O valor do ganho que pondera a referência é:
%}

kr = 1 / dcGain
Bmf = B * kr

sysMF = ss(Amf, Bmf, Cmf, Dmf)

% Resultados obtidos

time = linspace(0, 10, 100);
figure;
step(sysMF, time);
title('Resposta do sistema a um degrau unitário')
xlabel('t(s)');
ylabel('Amplitude');