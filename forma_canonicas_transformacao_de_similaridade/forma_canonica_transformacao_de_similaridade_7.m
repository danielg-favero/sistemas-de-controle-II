clc
close all
clear all

%{
    Dada a representação abaixo, ache a matriz de transformação P
    que diagonaliza o sistema. Também ache sua representação na
    forma canônica diagonal.
%}

A = [0 0 -20 ; 1 0 -32 ; 0 1 -13]
B = [20 ; 0 ; 0]
C = [0 0 1]

%{
    Os autovalores desse sistema, em ordem decrescente, são:
%}

[eig_vectors, eig_values] = eig(A)

%{
    A matriz de transformação tem a forma P. Logo, os elementos desta
    matriz são:
%}

% eig_vectors já está no formato desejado
P = eig_vectors 

%{
    Logo, o sistema diagonalizado tem a forma:
    𝒛 = 𝑷^−1𝑨𝑷𝒛 + 𝑷^−1𝑩u
    𝒚 = 𝑪𝑷𝒛 + 𝑫u
%}


% Matriz A:
Ad = inv(P) * A * P

% Matriz B:
Bd = inv(P) * B

% Matriz C:
Cd = C * P
