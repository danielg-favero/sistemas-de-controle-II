clc
clear all
close all

%{
    Considere o sistema abaixo:
%}

A = [1 2 ; -2 -3];
B = [0 ; 1];
C = [1 0];
D = 0;
sys = ss(A, B, C, D);

%{
    a) A soma dos coeficientes do numerador dos termos da matriz
%}

s = tf('s');
matriz = inv(s * eye(2) - A)
[num, den] = ss2tf(A, B, C, D)