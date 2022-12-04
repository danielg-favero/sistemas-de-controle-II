clc
clear all
close all

%{
    Observe que esse sistema é instavel, uma vez que seus polos são
    s1,2 = ±2. Para estabilizar o sistema, utilize a técnica de
    realimentação de estados e projete o vetor de ganhos K de forma que
    os polos do sistema, em malha fechada, sejam s1,2 = −2.
%}

A = [0 1 ; 4 0];
B = [0 ; 1];
C = [2 0];
D = 0;

sys = ss(A, B, C, D);

s1 = -2;
s2 = -2;

%{
    a) A matriz de controlabilidade tem a forma M:
%}

M = ctrb(A, B)

%{
    b) O posto da matriz de controlabilidade é:
%}

rank(M)

%{
    c) O polinômio característico desejado para o sistema é:
%}

syms s
phi = expand((s - s1) * (s - s2))

%{
    d) A matriz ϕ(A) tem a forma ϕ(A):
%}

phi_A = (A - s1 * eye(2)) * (A - s2 * eye(2))

%{
    e) O vetor de ganhos do controlador é:
%}

K = [0 1] * inv(M) * phi_A

%{
    f) Assim, os elementos da matriz AMF são:
%}

Amf = A - B * K

%{
    g) Assim, os elementos da matriz BMF são:
%}

Bmf = 0;

%{
    h) Assim, os elementos da matriz CMF são:
%}

Cmf = C;