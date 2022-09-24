clc;
close all;
clear all;

%{
    Considere o sistema descrito na figura abaixo onde
    G(s) = 20 / (s+1)(s+4). Deseja-se projetar um controlador
    de atraso C(s) para que o sistema, em malha fechada, tenha erro em
    regime permanente de 0,05 para uma referência do tipo degrau. 
    Adicionalmente, a adição do controlador não deve alterar,
    significativamente, a resposta transitória do sistema em malha
    fechada sem o controlador.
%}

% Planta
num = 20;
den = [1 5 4];
G = tf(num, den);

% Erro em regime permanente desejado
e = 0.05;

%{
    a) Os polos de malha fechada do sistema sem compensação são:
%}

% Sistema a malha fechada
Gmf = feedback(G, 1)

% Polos do sistema a malha fechada
s1 = pole(Gmf)

%{
    b) O coeficiente de amortecimento e a frequência natural desses
    polos é:

    s = -2.5 + 4.213i

    ζ * wn          = 2.5
    wn * √1 - ζ^2   = 4.213
%}

dump = sqrt((2.5^2) / (2.5^2 + 4.213^2))
natural_frequency = 2.5 / dump

%{
    c) Para atender os requisitos de projeto, a constante de erro estático
    de posiçãodeve valer:

    para atender a especificação ec(∞) <= 0,05
    Kp = (1 - ec) / ec = 19
%}

ec = 0.05;
Kpc = (1 - ec) / ec 

%{
    d) Consequentemente, o parâmetro β do controlador deve valer:
    - Erro em regime permanente do sistema não compensado:
        Kp = lim G(s) = 5
        e = 1 / (1 + Kp) = 0.1667
%}

Kp = 5;
e = 1 / (1 + Kp)

beta = Kpc / Kp

%{
    e) Considerando que o zero do compensador esteja em -0,1,
    o polo do compensador deve estar em:

    z = -0.1
    1 / T = 0.1
    T = 10
    
    p = - 1 / (beta * T)
    1 / (beta * T) = 0.0263
    beta * T = 38.0228
%}
zc = 0.1;
pc = 0.0263;

% Compensador sem ganho
numC = [1 zc];
denC = [1 pc];
C = tf(numC, denC)

%{
    f) Para manter o mesmo coeficiente de amortecimento dos polos
    de malha fechada originais do sistema sem o compensador, 
    os polos de malha fechada, após a inserção do compensador
    devem estar em:
%}

rlocus(G)
hold on
rlocus(C * G)

% Pelo diagrama de lugar de raízes: 
s = -2.47 + 4.16i;

%{
    g) Para os novos polos de malha fechada do sistema compensado,
    o ganho do compensador projetado é:
%}

Kc = 1 / abs(((20 * (s + zc)) / ((s + pc) * (s + 1) * (s + 4))))

