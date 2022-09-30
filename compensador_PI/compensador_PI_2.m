clc;
clear all;
close all;

%{
    Considere o sistema descrito na figura abaixo onde G(s) = 10 / s(s+4).
    Deseja-se que os polos dominantes de malha fechada forneçam
    sobressinal de 16,3% e tempo de acomodação de 4 segundos.
    Adicionalmente, o erro em regime permanente para uma referência do
    tipo rampa deve ser nulo. Projete um controlador PI
    C(s) = Kp * (s + 1 /Ti ) / s que atenda esses requisitos.

    %UP = 16,3%
    Ts = 4s
    e(∞) = 0
%}

num = 10;
den = [1 4 0];
G = tf(num, den)

up = 0.163;
ts = 4;

%{
    a) Para atender os requisitos de projeto o coeficiente de
    amortecimento e a frequência natural dos polos dominantes de malha 
    fechada deve ser
%}

damp = -log(up) / sqrt(pi^2 + (log(up)^2))
natural_frequency = 4 / (damp * ts)

%{
    b) A partir destes valores, os polos dominantes de malha
    fechada devem estar em:
%}

real_s1 = -damp * natural_frequency;
img_s1 = natural_frequency * sqrt(1 - damp^2)
s1 = real_s1 + 1i * img_s1

%{
    c) A contribuição angular que o compensador PI deve inserir no
    lugar das raízes é:
%}

ang = rad2deg(angle(evalfr(G, s1)))

if ang < 0
    phi = -180 -ang
else 
    phi = 180 -ang
end

%{
    d) O zero do compensador deve estar em:
%}

z = tand(phi) * img_s1

%{
    e) Com isso, Ti:
%}

Ti = - 1 / z

%{
    e) O ganho do compensador projetado é:
%}

num_c = [1 -z];
den_c = [1 0];
C = tf(num_c, den_c)

Kp = 1 / abs(evalfr(C * G, s1))

%{
    f) O sistema compensado em malha fechada tem polos em:
%}

% Lugar das raízes para o sistema compensado
rlocus(Kp * C * G)

%{
    g) O sobressinal e o tempo de acomodação do sistema compensado é:
%}

step(feedback(Kp * C * G, 1))
