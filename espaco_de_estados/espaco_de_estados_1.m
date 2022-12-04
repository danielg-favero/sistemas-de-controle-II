clc
close all
clear all

%{
    Considere o circuito da figura abaixo onde u(t) representa uma fonte
    de corrente CC. Os valores dos componentes são L = 1mH, C = 100μF e
    R = 1Ω. Obtenha uma representação em espaço de estados para o sistema
    onde x1(t)=iL(t)=y(t) e x2(t)=vC(t). Considere 3 algarismos
    significativos nas respostas.
%}

R = 1;
L = 0.001;
Cap = 0.0001;

%{
    OBTENDO AS EQUAÇÕES
    x1(t) = iL(t) = y(t)
    x2(t) = vC(t)

    x1' = iL'
    x2' = vC'

    iL + iC + iR = u(t)
    iC = -iL - iR = 0

    iL = (1 / L) ⌠vC
                 ⌡
    iL' = vC / L
    x1' = x2 / L                        (1)


    vC = (1 / C)⌠iC
                ⌡
    vC' = iC / C
    vC' = (-iL -iR + u) / C
    x2' = -x1 / C - x2 / RC + u/C       (2)

    REPRESENTAÇÃO MATRICIAL
    |x1'| = |  0    1/L||x1| + | 0 |u
    |x2'|   |-1/C -1/RC||x2|   |1/C|
%}

A = [0 1/L ; -1/Cap -1/(R*Cap)]
B = [0 ; 1/Cap]
C = [1 0]
D = 0;

G1 = ss(A, B, C, D)

%{
    Resposta do sistema ao degrau
%}

[Y1 T1 X1] = step(G1 , 0.12)

plot(T1, Y1, 'linewidth', 2);
legend('Saída');
ylabel('Amplitude');

%{
    Os polos do sistema, em ordem decrescente:
%}

eig(A)

