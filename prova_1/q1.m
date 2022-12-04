clc
clear all
close all

ts = 1; 

num = 1;
den = [1 1];
G = tf(num, den)

%{
    a) Para atender os requisitos de projeto, o coeficiente de
    amortecimento dos polos de malha fechada deve ser:
%}

damp = 1
%{
    b) Para atender os requisitos de projeto, a frequência natural
    dos polos de malha fechada deve ser:
%}

natural_frenquency = 4 / (damp * ts)

%{
    c) Os polos de malha fechada dominantes devem estar em:
%}

real_s1 = damp * natural_frenquency
img_s1 = natural_frenquency * sqrt(1 - damp^2)
s1 = -real_s1 + 1i * img_s1

%{
    d) O ganho Kp é:
%}

% Da forma geral de um controlador PI
% Kp (s + 1 / Ti) / s = Kp (1 + 1 / Ti*s) = Kp + Kp / Ti *s 

ang = rad2deg(angle(evalfr(G, s1)))

phi = 180 - ang

% O polo já pertence ao lugar de raízes
% Escolhendo um zero para o compensador

z = -0.05

num_c = [1 -z];
den_c = [1 0];  
C = tf(num_c, den_c)

Kp = 1 / abs(evalfr(G, s1))

%{
    e) O ganho Ki:
%}

Ti = 1 / -z;
Ki = Kp / Ti

Gc = Kp * C * G;
Gcmf = feedback(Kp * C * G, 1);

step(Gcmf)

