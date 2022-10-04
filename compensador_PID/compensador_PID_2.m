clc
clear all
close all

%{
    Considere o sistema descrito na figura abaixo onde 
    G(s) = 165 / ((s + 1)(s + 2)(s + 10)). Deseja-se projetar um
    controlador PID na forma C(s) = Kp + Ki/s + Kds = K(s + z)^2/s para que
    o sistema, em malha fechada, tenha polos dominantes que forneçam
    sobressinal de 5% e tempo de acomodação de 2 segundos. 
    Adicionalmente, o erro em regime permanente para uma entrada do tipo 
    degrau deve ser nulo. Dica: para o cálculo da condição de ângulo,
    incorpore o integrador do controlador junta à G(s)
%}

num = 165;
den = [1 13 32 20];
G = tf(num, den)

up = 0.05;
ts = 2;

%{
    a) Para atender os requisitos de projeto, o coeficiente de
    amortecimento e frequência natural destes polos deve ser:
%}

damp = -log(up) / sqrt(pi^2 + (log(up))^2)
natural_frequency = 4 / (damp * ts)

%{
    b) A partir destes valores, os polos dominantes de malha fechada
    devem estar em : 
%}

real_s1 = - damp * natural_frequency;
img_s1 = natural_frequency * sqrt(1 - damp^2);
s1 = real_s1 + 1i * img_s1

%{
    c) A contribuição angular que o termo (s+z)^2 do compensador deve
    inserir no lugar das raízes é:
%}

s = tf('s');
ang = rad2deg(angle(evalfr(G / s, s1)));

if ang < 0
    phi = -180 - ang
else
    phi = 180 - ang
end

if phi < 0
    phi = 360 + phi
end

%{
    d) Para atender a contribuição angular ϕ, os zeros do compensador
    em s=−z devem estar:
%}

% Cada compensador contribuirá com um ânuglo phi/2

x = img_s1 / tand(phi/2)
z = real_s1 - x

a = 1;
b = 4.226;
c = 4.466;

num_c = [a b c];
den_c = [1 0];
C = tf(num_c, den_c)

%{
    e) O ganho do compensador vale:
%}

K = 1 / abs(evalfr(G * C, s1))  

%{
    f) Logo, os ganhos proporcional, integral e derivativo são dados por:
%}
 
Kp = K * b
Kd = K * a
Ki = K * c

%{
    g) Com o controlador PID projetado, o sistema em malha fechada
    tem polos dominantes em:
%}

Gc = K * C * G;
Gcmf = feedback(Gc, 1);
pole(Gcmf)

%{
    h) O sobressinal teórico e o tempo de acomodação teórico
    associado a estes polos é:
%}

real_s2 = 2.0002;
img_s2 = 2.097;

damp_c = sqrt((real_s2^2) / (real_s2^2 + img_s2^2));
natural_frequency_c = real_s2 / damp_c;

up_c = exp(-damp_c * pi / sqrt(1 - damp_c^2)) * 100
ts_c = 4 / (damp_c * natural_frequency_c)

%{
    i) Todavia, devido aos efeitos dos demais polos e zeros do
    sistema em malha fechada, o sobressinal do sistema compensado é:
%}

step(Gcmf)


