clc;
clear all;
close all;

%{
    Considere um sistema descrito por G(s)=1 / s(s+1).
    Deseja-se projetar um controlador de avanço pelo
    método do lugar das raízes para que o sistema compensado tenha,
    em malha fechada com realimentação unitária, polos dominantes s1,2=−1±j1. 
    Considerando o polo dominante com parte imaginária positiva e o sistema
    mencionado responda considerando 3 algarismos significativos:
%}

% Planta
num = 1;
den = [1 1 0];
G = tf(num, den);

% Polos dominantes desejados
s = -1 + 1j;

%{
    a) A condição de ângulo do lugar das raízes para esse polo é um 
       valor negativo e vale ∠G(s)|s=−1+j1
%}

% Condição de ângulo para os polos dominantes desejados
angle(1 / (s * (s + 1))) * 180 / pi