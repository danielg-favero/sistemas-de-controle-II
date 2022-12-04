clc
clear all
close all


num = 1;
den = [1 9 18 0];
G = tf(num, den)

damp = 0.707;
natural_frequency = 2.83;

%{
    a) Para atender esse requisito, esses polos devem estar em:
%}

real_s1 = damp * natural_frequency;
img_s1 = natural_frequency * sqrt(1 - damp^2);
s1 = -real_s1 + 1i * img_s1

%{
    b) A contribuição angular que o compensador de avanço deve inserir no
    lugar das raízes é:
%}

ang = rad2deg(angle(evalfr(G, s1)));

phi = 180 - ang

z = -2;
x = tand(phi) * img_s1

p = real_s1 - x

%{
    c) O ganho do compensador projetado é Kc:
%}

num_c = [1 -z];
den_c = [1 -p];
C = tf(num_c, den_c)

Kc = 1 / abs(evalfr(C * G, s1))

Gc = Kc * C * G;
Gcmf = feedback(Gc, 1);
step(Gcmf)


