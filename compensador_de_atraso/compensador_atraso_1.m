clc;
clear all;
close all;

%{
    Deseja-se projetar um compensador de atraso para um sistema 
    G(s) = 1 / (s+2)(s+4) com realimentação unitária de forma que o erro
    em regime permanente para uma referência do tipo degrau seja 0,05.

    a) Para isso, a constante de erro estático de: posição
%}

%{
    b) deve valer: 
    - Para um sistema compensado com ec(∞) <= 0.05
        ec(∞) = 0.05
        Kpc = (1 - ec(∞)) / ec(∞) = 21
%}

ec = 0.05;
Kpc = (1 - ec) / ec

%{
    c) Assim, o parâmetro β do controlador deve valer:
    - Para o sistema sem compensação:
        Kp = lim G(s) = 0.125
        e = 1 / (1 + Kp) = 0.8889
%}

Kp = 0.125;
e = 1 / (1 + Kp);

beta = Kpc / Kp







