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

A = [0 1 0 ; 0 0 1 ; -6 -11 -6]
B = [0 ; 0 ; 1]
C = [2 1 0]
D = 0

[num, den] = ss2tf(A, B, C, D)