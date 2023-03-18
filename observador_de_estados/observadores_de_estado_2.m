clc
clear all
close all

%{
    Dado o sistema abaixo, projete um observador de estados de forma que
    os autovalores do observador sejam μ1,2,3 = −50
%}

A = [0 0 -150 ; 1 0 -95 ; 0 1 -18];
B = [150 ; 1 ; 0];
C = [0 0 1];
D = 0;
sys = ss(A, B, C, D);

u = -50;

%{
    a) Os polos da planta são (do menor para o maior):
%}

eig(A)

%{
    b)  Assim, os elementos da matriz N são:
%}

N = obsv(A, C)

%{
    c) O posto da matriz de observabilidade é:
%}

rank(N)

%{
    d) O polinômio característico desejado para o observador é:
%}

s = tf('s');
phi = (s - u) * (s - u) * (s - u)

%{
    e) Logo, os elementos da matriz ϕ(A) são:
%}

phi_a = (A - eye(3) * u) * (A - eye(3) * u) * (A - eye(3) * u)

%{
    f) Assim, o vetor de ganhos associado ao observador é Ke
%}

Ke = acker(A', C', [u u u])'

%{
    g)  A matriz Aobs e seus elementos são:
%}

Aobs = A - Ke * C

%{
    h)  A matriz Bobs e seus elementos são:
%}

Bobs = [B Ke]

%{
    i)  A matriz Cobs e seus elementos são:
%}

Cobs = eye(3)

