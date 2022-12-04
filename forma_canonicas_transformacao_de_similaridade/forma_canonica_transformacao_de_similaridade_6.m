clc
close all
clear all

%{
    Considere o sistema G(s) = (s + 1) / s^2 + 6s + 9. Obtenha a
    representação em espaço de estados na forma canônic
    diagonal ou de Jordan.
%}

num = [1 1];
den = [1 6 9];
G = tf(num, den)

%{
    Polos do sistema
%}

pole(G)

%{
    Como os polos são iguais, é preciso usar a forma canônica de Jordan
%}

[res, poles, k] = residue(num, den)

A = [poles(1) 0 ; 0 poles(2)]
B = [0 1]
C = [res(2) res(1)]
D = 0

eig(A)