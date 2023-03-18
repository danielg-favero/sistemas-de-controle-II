clc
clear all
close all

%{
    Projete um controlador por realimentação de estados para que o sistema
    em malha fechada tenha polos em s1,2=−2 e s3,4=−20, rastreie uma
    referência do tipo degrau com erro nulo e tenha maior capacidade de
    rejeitar variações paramétricas e perturbações nos estados. 

    Na sequência, projete um observador de estados para este sistema.
    Os autovalores do observador devem ser μ1,2 = −20 e μ3 = −200.
%}

A = [0 1 0 ; 0 0 1 ; -12 -19 -8];
B = [0 ; 0 ; 1];
C = [2 1 0];
D = 0;
sys = ss(A, B, C, D);

s1 = -2;
s2 = -2;
s3 = -20;
s4 = -20;
u1 = -20;
u2 = -20;
u3 = -200;

Aaum = [A zeros(3, 1); -C 0];
Baum = [B ; 0];
Caum = [C 0];
Daum = 0;

%{
    a) A soma dos elementos da matriz de controlabilidade do sistema
    a ser controlado vale:
%}

M = ctrb(Aaum, Baum)
sum(sum(M))

%{
    b) O posto da matriz de controlabilidade é:
%}

rank(M)

%{
    c) Assim, os ganhos do controlador são:
%}

Kbar = acker(Aaum, Baum, [s1 s2 s3 s4])

%{
    d) A soma dos elementos da matriz de observabilidade do sistema vale:
%}

N = obsv(A, C)
sum(sum(N))

%{
    e) O posto da matriz de observabilidade é:
%}

rank(N)

%{
    f) O vetor de ganhos do observador é dado por Ke:
%}

Ke = acker(A', C', [u1 u2 u3])

%{
    g)  Assim, os elementos da matriz AMFO são:
%}






