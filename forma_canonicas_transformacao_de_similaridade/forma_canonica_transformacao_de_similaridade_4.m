clc
close all
clear all

%{
    Dada a representação em espaço de estados determine a função de
    transferência G(s) associada.
%}

%{
    𝐺(𝑠) = 𝑌(𝑠) = = 𝑪(𝑠𝑰 − A)^-1B + D
           ----
           𝑈(𝑠)
%}

A = [-1 0 ; 0 -2]
B = [1 ; 1]
C = [1 -1]
D = 0

[num, den] = ss2tf(A, B, C, D)