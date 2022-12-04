clc
clear all
close all

%{
    Utilize a técnica de realimentação de estados e projete o vetor de
    ganhos K de forma que os polos do sistema, em malha fechada,
    sejam s1,2=−2 e s3=−20.
%}

s1 = -2;
s2 = -2;
s3 = -20;

A = [0 1 0 ; 0 0 1 ; -8 -8 -4];
B = [0 ; 0 ; 1];
C = [4 0 0];
D = 0;

sys = ss(A, B, C, D);

%{
    a) Os polos do sistema são:
%}

eig(A)

%{
    b) A matriz de controlabilidade tem a forma M:
%}

M = ctrb(A, B)

%{
    c) O posto da matriz de controlabilidade é:
%}

rank(M)

%{
    d) O polinômio característico desejado para o sistema é: 
%}

syms s
phi = expand((s - s1) * (s - s2) * (s - s3))

%{
    e) A matriz ϕ(A) tem a forma ϕ(A):
%}

phi_A = (A - s1 * eye(3)) * (A - s2 * eye(3)) * (A - s3 * eye(3))

%{
    f) O vetor de ganhos do controlador é: 
%}

K = [0 0 1] * inv(M) * phi_A

%{
    g) Assim, os elementos da matriz AMF são:
%}

Amf = A - B * K