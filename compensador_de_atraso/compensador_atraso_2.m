clc;
clear all;
close all;

%{
    Deseja-se projetar um compensador de atraso para um sistema
    G(s) = 1 / s(s+10) com realimentação unitária de forma que o erro
    em regime permanente para uma referência do tipo rampa seja 0.1

    a) Para isso, a constante de erro estático de: velocidade
%}

%{
    b) deve valer: 
    - Para um sistema compensado com ec(∞) <= 0.1
        ec(∞) = 0.1
        Kvc = 1 / ec(∞) = 10
%}

ec = 0.1;
Kvc = 1 / ec

%{
    c) Assim, o parâmetro β do controlador deve valer:
    - Para o sistema sem compensação:
        Kv = lim sG(s) = 0.1
        e = 1 / Kv = 10
%}

Kv = 0.1;
e = 1 / Kv;

beta = Kvc / Kv







