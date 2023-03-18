clc
clear all
close all

%{
    Considere o sistema abaixo:

    Deseja-se que a saída siga uma referência do tipo degrau com erro
    nulo e seja capaz de rejeitar perturbações aplicadas na entrada do
    sistema. Assim, projete o controlador adequado. Se for o controlador
    sem integral do erro de rastreamento da referência, utilize como
    autovalores desejados para o sistema em malha fechada os valores
    s1 = s2 = −5. Se for o controlador com integral do erro de
    rastreamento, utilize como autovalores desejados para o sistema em
    malha fechada os valores s1 = s2 = −5 e s3 = −30. Com base na sua
    escolha e projeto, preencha adequadamente as questões abaixo:
%}

A = [1 2 ; -2 -3];
B = [0 ; 1];
C = [1 0];
D = 0;
sys = ss(A, B, C, D);

% Deve ser feito um controlador com integral de erro
s1 = -5;
s2 = -5;
s3 = -30;

%{
    a) O posto da matriz de controlabilidade é:
%}

Aaum = [A zeros(2, 1); -C 0];
Baum = [B ; 0];
Caum = [C 0];
Daum = 0;

M = ctrb(Aaum, Baum)
rank(M)

%{
    b) A soma dos elementos da matriz de controlabilidade é: 
%}

sum(sum(M))

%{
    d) A soma dos coeficientes do polinômio característico desejado para
    o controlador é:
%}

s = tf('s');
phi = (s - s1) * (s - s2) * (s - s3)

%{
    e) O vetor de ganhos do controlador é um vetor:
%}

Ke = acker(Aaum, Baum, [s1 s2 s3])