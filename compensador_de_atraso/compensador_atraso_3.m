clc;
clear all;
close all;

%{
    Calcule o valor de Kcc para a condição de módulo
    ∣(Kcc * 2 * (s + 0,01)) / ((s + 0,001) * s * (s + 2))∣ 
    em s = −0,99 + j0,99
%}

s = -0.99 + j * 0.99;

Kcc = 1 / abs((2 * (s + 0.01)) / (s * (s + 0.001) * (s + 2)))