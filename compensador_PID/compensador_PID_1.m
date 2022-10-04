clc
clear all
close all

%{
    Considere o sistema descrito na figura abaixo onde
    G(s) = 165 / ((s+1)(s+2)(s+10)). Deseja-se projetar um controlador
    PID na forma C(s) = Kp + Kis + Kds = K(s+z1)(s+z2)/s para que o
    sistema, em malha fechada, tenha polos dominantes que forneçam
    sobressinal de 5% e tempo de acomodação de 2 segundos.
    Adicionalmente, o erro em regime permanente para uma entrada do
    tipo degrau deve ser nulo.

    %UP = 5%
    Ts = 2s
    e(∞) = 0
%} 

up = 0.05;
ts = 2;

num = 165;
den = [1 13 32 20];
G = tf(num, den)

%{
    a) Para atender os requisitos de projeto, o coeficiente de
    amortecimento e a frequência natural dos polos dominantes de malha
    fechada deve ser:
%}

damp = -log(up) / sqrt(pi^2 + (log(up)^2))
natural_frequency = 4 / (ts * damp)

%{
    b) A partir destes valores, os polos dominantes de malha fechada devem
    estar em:
%}

real_s1 = -damp * natural_frequency;
img_s1 = natural_frequency * sqrt(1 - damp^2);
s1 = real_s1 + 1i * img_s1

%{
    c) A contribuição angular que o termo (s+z1) do compensador deve
    inserir no lugar das raízes é:
%}

ang = rad2deg(angle(evalfr(G, s1)))

if ang < 0
    phi = - 180 - ang
else
    phi = 180 - ang
end

if phi < 0
    phi = 360 + phi
end

%{
    d) Para atender a contribuição angular ϕ, o zero do compensador em
    s = −z1 deve estar em:
%}

x = img_s1 / tan(phi);
zpd = x + real_s1

%{
    e) O ganho do compensador vale K:
%}

num_pd = [1 -zpd];
den_pd = 1;
Cpd = tf(num_pd, den_pd);

K = 1 / abs(evalfr(G * Cpd, 1))

%{
    f) Considerando que o zero do termo (s+z2) esteja em s = −0,1
    o compensador na forma C(s) = K(a⋅^2+b⋅s+c) / s
%}

zpi = -0.1;

syms s
expand((s - zpd) * (s - zpi))

a = 1;
b = 4.809;
c = 0.471;

%{
    g) Logo, os ganhos proporcional, integral e derivativo são dados por:
%}

Kp = b * K
Ki = c * K
Kd = a * K

%{
    h) Com o controlador PID projetado, o sistema em malha fechada
    tem polos dominantes em:
%}

smf = tf('s');
C = K * (smf - zpd) * (smf - zpi) / smf;

Gcmf = feedback(C * G, 1);
s2 = pole(Gcmf)

real_s2 = 1.8985;
img_s2 = 2.080;

damp_c = sqrt((real_s2^2) / (real_s2^2 + img_s2^2));
natural_frequency_c = real_s2 / damp_c;

up_c = exp(-damp_c * pi / sqrt(1-damp_c^2)) * 100
ts_c = 4 / (damp_c * natural_frequency_c)

%{
    i) O sobressinal teórico associado a estes polos é:
%}

stepinfo(Gcmf)




