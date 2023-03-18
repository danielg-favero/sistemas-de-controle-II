clc
clear all
close all

%{
    Considere o sistema abaixo:

    Projete um observador de estados para o sistema acima utilizando a
    fórmula abaixo e considerando os autovalores do observador em
    μ1 = μ2 = −15.
%}

A = [1 2 ; -2 -3];
B = [0 ; 1];
C = [1 0];
D = 0;
sys = ss(A, B, C, D);

u = -15;

%{
    a) O posto da matriz de observabilidade é:
%}

N = obsv(A, C);
rank(N)

%{
    b) A soma dos elementos da matriz de observabilidade é:
%}

sum(sum(N))

%{
    c) Os coeficientes do polinômio característico do observador são:
%}

s = tf('s');
phi = (s - u) * (s - u)

%{
    d) A soma dos elementos da matriz Φ(A) é:
%}

phi_a = (A - u * eye(2)) * (A - u * eye(2));
sum(sum(phi_a))

%{
    e) O vetor de ganhos do observador é um vetor:
%}

Ke = phi_a * inv(N) * [0 ; 1]