clc;
clear all;
close all;

%{
    Considere o sistema descrito na figura abaixo onde 
    G(s) = 4 / s(s+1)(s+2). Deseja-se projetar um controlador de
    avanço-atraso C(s) para que o sistema, em malha fechada,
    tenha polos dominantes que forneçam sobressinal de 10% e tempo de
    acomodação de 5 segundos. Adicionalmente, o erro em regime permanente
    para uma entrada do tipo rampa deve ser de 0,05.

    %UP = 0.1
    Ts = 5s
    e(∞) = 0.05
%}

%{
    a) Para atender os requisitos de projeto o coeficiente de
    amortecimento e frequência natural dos polos dominantes de
    malha fechada deve ser:
%}

num = 4;
den = [1 3 2 0];
G = tf(num, den)

up = 0.1;
ts = 5;
ec = 0.05;

dump = -log(up) / sqrt(pi^2 + (log(up)^2))
natural_frequency = 4 / (dump * ts)

%{
    b) A partir destes valores, os polos dominantes de malha fechada
    devem estar em:
%}

pole = -dump * natural_frequency + i * natural_frequency * sqrt(1 - dump^2)

%{
    c) A contribuição angular que o termo de avanço do compensador
    deve inserir no lugar das raízes é:
%}

pole_angle = rad2deg(angle(evalfr(G, pole)));
phi = 180 - pole_angle

%{
    d) Considerando que o zero do termo de avanço do compensador
    esteja em s = −1, seu polo deve estar em:

    Segundo o diagrama de lugar das raízes:
    s = -6,1784

    Dessa relação obtemos:
    - T1 = 1
    - alpha = 0.1619
%}

alpha = 0.1619;

%{
    e) O ganho do termo de avanço do compensador projetado é:
%}

zav = 1;
pav = 6.1784;
Cav = tf([1 zav], [1 pav])

Kc = 1 / abs(evalfr(Cav, pole) * evalfr(G, pole))

% Verificando se atendeu as especificações de resposta transitória
Gav = minreal(Kc* G * Cav)
Gavmf = feedback(Gav, 1);
Gavmf = minreal(Gavmf)
% step(Gavmf)

%{
    f) Para atender a especificação de erro em regime permanente,
    a constante de erro estático de velocidade do sistema compensado
    deve ser:
%}

Kvc = 1 / ec


%{
    g) Logo, o parâmetro β do termo de atraso do controlador vale:
%}

% constante de erro atual da planta G(s) sem compensasção
Kv = 2;

beta = Kvc / (alpha * Kc * Kv)

%{
    h) Considerando que o zero do termo de atraso do controlador
    esteja em s = −0,04 o polo do termo de atraso deve estar em

    1/T2 = 0.04
    T2 = 25

    1/ (beta * T2) = p
    p = 0.0020
%}

zat = 0.04;
pat = 0.0020;
Cat = tf([1 zat], [1 pat]);

%{
    i) Com o controlador de avanço-atraso projetado,
    o sistema em malha fechada tem polos dominantes em:
%}

Gc = Kc * Cat * Cav * G;
Gmfcv = minreal(feedback(Gc, 1))
compensated_poles = roots([1 8.18 12.37 12.07 0.4819])

%{
    j) O sobressinal teórico associado a estes polos e o tempo de
    acomodação teórico associado são de:
%}

dumpc = sqrt((0.781^2) / ((0.781^2) + (1.072^2)));
wnc = 0.781 / dumpc;

upc = exp(-dumpc * pi / sqrt(1 - dumpc^2)) * 100
ts = 4 / (dumpc * wnc)

%{
    k) Todavia, devido aos efeitos dos demais polos e zeros do sistema
    em malha fechada, o sobressinal do sistema compensado e seu tempo de
    acomodação é de:
%}

step(Gmfcv);
