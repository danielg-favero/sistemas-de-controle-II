clc
clear all
close all

%{
    Deseja-se que o sistema siga uma referência do tipo degrau com
    erro nulo tendo os polos de malha fechada s1,2 = −5 ± j√33  e s3 = −50.
    Adicionalmente, deseja-se que o sistema em malha fechada rejeite
    perturbações nos estados e/ou variações paramétricas. Para isso,
    utiliza-se a estrutura de controle abaixo.
%}

A = [0 1 0 ; 0 0 1 ; 0 -200 -30];
B = [0 ; 0 ; 1];
C = [1 0 0];
D = 0;
sys = ss(A, B, C, D);

%{
    a) Considerando que o 4º polo do sistema seja s4 = −50, o vetor de
    ganhos é dado por K' = [K ⋮ −kI] = [k1 k2 k3 −kI]. Assim, os ganhos
    do controlador são:
%}

s1 = -5 + 1i * 3 * sqrt(3);
s2 = -5 - 1i * 3 * sqrt(3);
s3 = -50;
s4 = -50;

%{
    Matrizes aumentadas do sistema

    Aaum = [A   0nx1 ; -C   0]  
    Baum = [B ; 0]
    Raum = [0nx1 ; 1]
    Caum = [C   0]
%}

Aaum = [A zeros(3, 1) ; -C 0]
Baum = [B ; 0]
Caum = [C 0]

Kbar = acker(Aaum, Baum, [s1 s2 s3 s4])

%{
    b)Assim, os elementos da matriz AMF são:
%}

Amf = Aaum - Baum * Kbar

%{
    c) Assim, os elementos da matriz BMF são:
%}

Bmf = [0 ; 0 ; 0 ; 1]

%{
    d) Assim, os elementos da matriz CMF são:
%}

Cmf = Caum
Dmf = 0;

%{
    e) O ganho CC do sistema compensado vale:
%}
sysMF = ss(Amf, Bmf, Cmf, Dmf);
dcgain(sysMF)

%{
    f) O erro em regime permanente para o sistema compensado para uma
    referência do tipo degrau unitário vale:

    e(∞) = r(∞) - r(∞) * dc_gain
    e(∞) = r(∞) - r(∞)
    e(∞) = 0
%}

%{
    g) Logo, a saída em regime permanente do sistema compensado para
    uma referência do tipo degrau unitário vale:
%}

step(sysMF)

%{
    h) Supondo uma variação paramétrica na matriz C do sistema, isto é,
    C=[0,5 0 0] o erro em regime permanente para o sistema compensado
    para uma referência do tipo degrau unitário vale:
%}