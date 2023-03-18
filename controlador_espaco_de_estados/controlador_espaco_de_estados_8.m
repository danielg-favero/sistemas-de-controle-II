clc
clear all
close all

%{
    Deseja-se que o sistema siga uma referência do tipo degrau com
    erro nulo tendo os polos de malha fechada  s1,2 = −2. Adicionalmente,
    deseja-se que o sistema em malha fechada rejeite perturbações nos
    estados e/ou variações paramétricas. Para isso, utiliza-se a
    estrutura de controle abaixo.
%}

A = [0 1 ; -8 -4];
B = [0 ; 1];
C = [1 0];
D = 0;
sys = ss(A, B, C, D);

%{
    a) Considerando que o 3º polo do sistema seja s3 = −10, o vetor de
    ganhos é dado por K¯=[K ⋮ −kI]=[k1 k2 −kI]. Assim, os ganhos do
    controlador são:
%}

s1 = -2;
s2 = -2;
s3 = -10;

%{
    Matrizes aumentadas do sistema:

    Aaum = [A 0nx1 ; -C 0]
    Baum = [B ; 0]
    Raum = [0xn1 ; 1]
    Caum = [C 0]
%}

Aaum = [A zeros(2, 1) ; -C 0];
Baum = [B ; 0];
Caum = [C 0];

Kbar = acker(Aaum, Baum, [s1 s2 s3])

%{
    b) Assim, os elementos da matriz AMF são:
%}

Amf = Aaum - Baum * Kbar

%{
    c) Assim, os elementos da matriz BMF são:
%}

Bmf = [0 ; 0 ; 1]

%{
    d) Assim, os elementos da matriz CMF são:
%}

Cmf = Caum

%{
    e) O ganho CC do sistema compensado vale
%}

sysMF = ss(Amf, Bmf, Cmf, D);
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
    se e(∞) = 1 -> r(∞) = 1
%}

%{
    h) Supondo uma variação paramétrica na matriz B do sistema,
    isto é, B=[0 1,5] o erro em regime permanente para o sistema
    compensado para uma referência do tipo degrau unitário vale 
%}

Bvar = [0 ; 1.5];

[num, den] = ss2tf(A, Bvar, C, D);
G = tf(num, den);
Gmf = feedback(G, 1);
step(Gmf)
dcgain(Gmf)



