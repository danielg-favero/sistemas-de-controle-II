clc
clear all
close all

%{
    Considere o sistema descrito na figura abaixo onde G(s) = 10 / (s(s+4))
    e C(s) é  um controlador PI dado por C(s) = 0,8(s+1) / s;

    Este sistema tem polos dominantes de malha fechada em s1,2 = −1 ± j1,732
    que deveriam fornecer um sobressinal Mp=16,3% e tempo de acomodação
    ts=4 s que são os objetivos de resposta transitória desejados. 
    Todavia, devido ao polo de malha fechada em s3 = −2 e ao zero de
    malha fechada em s = −1, a resposta do sistema exibe sobressinal de
    43,4% e tempo de acomodação de 4,14s.

    Visando aproximar a resposta transitória dos valores desejados e
    mantendo o erro nulo para entrada do tipo rampa, projete um
    controlador PID C(s) de forma a cancelar o polo da planta
    G(s) em s=−4 mantendo os polos dominantes desejados em
    s1,2 = −1 ± j1,732. Isso visa reduzir a ordem do sistema compensado
    de forma que ele se mantenha de segunda ordem após a introdução do
    controlador. Suponha que o controlador PID tenha a forma 
    C(s) = KcTd(s + 1/Td)(s + 1/Ti)/s = K(s + z1)(s + z2)/s. 
    Verifique se há melhora na resposta transitória em comparação com a
    compensação PI apresentada acima. Dica: para a determinação da
    condição de ângulo do lugar das raízes considere a porção do PID 
    responsável pelo zero para realizar o cancelamento com o polo da
    planta e o integrado juntamente com G(s).
%}

num_g = 10;
den_g = [1 4 0];
G = tf(num_g, den_g)

real_s1 = -1;
img_s1 = 1.732;
s1 = real_s1 + 1i * img_s1

%{
    a) A contribuição angular que o termo (s+z2) do compensador deve
    inserir no lugar das raízes é:
%}

s = tf('s');

%{
    Dica: para a determinação da condição de ângulo do lugar das raízes
    considere a porção do PID responsável pelo zero para realizar o
    cancelamento com o polo da planta (z1) e o integrado juntamente com G(s)
%}

ang = rad2deg(angle(evalfr((s + 4) * G / s, s1)));

if ang < 0
    phi = - 180 - ang
else
    phi = 180 - ang
end

if phi < 0
    phi =  phi + 360
end

%{
    b) Para atender a contribuição angular ϕ, o zero do compensador
    em s = −z2 deve estar:
%}

x = img_s1 / tand(phi)
z = -(-real_s1 + x)

%{
    c) O ganho do compensador vale:
%}

num_pd = [1 4];
den_pd = 1;
Cpd = tf(num_pd, den_pd);

num_pi = [1 -z];
den_pi = [1 0];
Cpi = tf(num_pi, den_pi);

K = 1 / abs(evalfr(Cpi * Cpd * G, s1))

%{
    d) O compensador na forma C(s):
%}

Cpd * Cpi

%{
    e) Com o controlador PID projetado, o sistema em malha fechada
    tem polos dominantes em:
%}

Gc = K * Cpi * Cpd * G;
Gcmf = feedback(Gc, 1);
s2 = pole(Gcmf);
real_s2 = real(s2(2))
img_s2 = imag(s2(2))

%{
    f) O sobressinal e o tempo de acomodação teórico
    associado a estes polos é:
%}

damp_c = sqrt((real_s2^2) /(real_s2^2 + img_s2^2));
natural_frequency_c = -real_s2 / damp_c;

up_c = exp(-damp_c * pi / sqrt(1 - damp_c^2)) * 100
ts_c = 4 / (damp_c * natural_frequency_c)

%{
    g) Todavia, mesmo o sistema resultante sendo de segunda ordem,
    devido aos efeitos do  zero em malha fechada, o sobressinal do
    sistema compensado é:
%}

step(Gcmf)
    