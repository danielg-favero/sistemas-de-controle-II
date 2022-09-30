clc;
clear all;
close all;

%{
    Considere o sistema descrito na figura abaixo onde 
    G(s) = K / (s^2 + 2s + 1) e K é um ganho ajustável pelo usuário.
    Deseja-se projetar um controlador PI C(s) = Kp(1 + 1 / (Ti * s))
    para que o sistema, em malha fechada, tenha tenha polos dominantes
    próximos de s1,2 = −1 ± j√3 e erro em regime permanente nulo para uma
    referência do tipo degrau.
%}

%{
    a) O ganho K do sistema deve ser:
%}

real_s1 = -1;
img_s1 = sqrt(3);
s1 = real_s1 + 1i * img_s1

num = 1;
den = [1 2 1];
G = tf(num, den)

% Lugar das raízes para encontrar o K que leve aos polos dominantes
rlocus(G)
hold on
K = 3;

%{
    b) Se o zero do compensador está em s = −0,05, tem-se que Ti:
%}

z = -0.05;
Ti = - 1 / z

%{
    c) Para manter o mesmo coeficiente de amortecimento dos polos de
    malha fechada originais do sistema sem o compensador,
    os polos de malha fechada, após a inserção do compensador devem
    estar em:
%}

num_c = [1 -z];
den_c = [1 0];
C = tf(num_c, den_c)

% Pelo lugar de raízes da planta sem compensação G, temos que:
damp = 0.5;

% Usando o lugar das raízes para descobrir os polos dominantes do sistema
% compensado
rlocus(C * K * G)

real_s2 = -0.981;
img_s2 = 1.7;
s2 = real_s2 + 1i * img_s2

%{
    d) Para os novos polos de malha fechada do sistema compensado,
    o ganho proporcional do compensador projetado é:
%}

Kp = 1 / abs(evalfr(K * C * G, s2))

% step(feedback(Kp * C * K * G, 1))

