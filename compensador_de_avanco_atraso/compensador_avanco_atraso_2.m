clc;
clear all;
close all;

%{
    Considere o sistema descrito na figura abaixo onde G(s) = 1 / s(s+4).
    Deseja-se projetar um controlador C(s) para que o sistema,
    em malha fechada, tenha polos dominantes que forneçam sobressinal
    de 5% e tempo de acomodação de 2 segundos. Adicionalmente,
    o erro em regime permanente para uma entrada do tipo rampa
    deve ser de 0,2. Caso seja necessário um termo de atraso no
    controlador, considere que o zero deste termo está em s=−0.1.
    Neste caso, também considere a modificação do lugar das raízes
    devido ao termo de atraso e obtenha os novos polos de malha fechada
    nesse novo lugar das raízes mantendo o coeficiente de amortecimento
    dos polos de malha fechada originalmente desejados.

    %UP = 0.05
    Ts = 2
    e(∞) = 0.2
    zat = -0.1
%}

G = tf([0 0 1], [1 4 0]);

up = 0.05;
ts = 2;
ec = 0.2;
zat = -0.1;

%{
    a) Para atender os requisitos de projeto o coeficiente de
    amortecimento dos polos dominantes de malha fechada deve ser
%}

dump = -log(up) / sqrt(pi^2 + (log(up))^2)
wn = 4 / (dump * ts)

%{
    b) A partir destes valores, os polos dominantes de malha fechada
    devem estar em:
%}

dominant_poles = -wn * dump + i * wn * sqrt(1 - dump^2)

%{
    c) O ganho do controlador é Kc:
%}

% Contribuição angular que os polos dominantes geram no sistema
dominant_pole_angle = rad2deg(angle(evalfr(G, dominant_poles)));

%{
    dominant_pole_angle = 180º => portanto os polos dominantes pertencem
    ao lugar de raízes, portanto não é preciso um compensador de avanço
    para esse sistema
%}

% Encontrando Kv para um compensador de atraso
e = 0.25;
Kv = 1 / e;
Kvc = 1 / ec;

beta = Kvc / Kv;

% Encontrando polo e zero para o controlador
% Assumindo que um zero é dado (s = -0.1)
T = 1 / zat;
pat = 1 / (beta * T);
Cat = tf([1 zat], [1 pat]);

rlocus(G);
hold on
rlocus(Cat * G)

% Pelo diagrama de lugar de raízes, os polos dominantes, mantendo o mesmo
% amortecimento e frequência natural
s = -2 + 2.1 * i;

% Encontrando o ganho Kc para o sistema
Kc = 1 / abs(evalfr(G, s) * evalfr(Cat, s))