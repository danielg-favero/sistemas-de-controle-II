clc;
clear all;
close all;

%{
    Considere o sistema descrito na figura abaixo onde G(s) = 10 / s(s+4)
    e C(s) é um controlador a ser projetado.

    Deseja-se  sobressinal Mp = 16,3%,  tempo de acomodação ts = 4s e erro
    nulo em regime permanente para entrada rampa. Para atender os
    requisitos de resposta transitória, os polos dominantes de malha
    fechada devem ser s1,2 = −1 ± j1,732 e deve-se incluir um integrador
    para zerar o referido erro de interesse. Um controlador PI dado
    por C(s) = 0,8(s+1)/s zera o erro e fornece os polos de malha
    fechada desejados. Todavia, devido ao polo de malha fechada em
    s3 = −2 e ao zero de malha fechada em s = −1, a resposta do sistema
    exibe sobressinal de 43,4% e tempo de acomodação de 4,14s.

    Visando melhorar a resposta transitória ao mesmo tempo em que se
    zera o erro em regime permanente para a entrada rampa,
    é possível se projetar um controlador C(s) do tipo PID de forma a
    cancelarmos o polo da planta em s = −4. Isso faz com que o sistema
    compensado seja de segunda ordem e há  uma melhora da resposta.
    Ainda assim, devido ao zero do sistema em malha fechada, devido ao
    controlador, obtém-se um sobressinal maior do que o desejado e o
    sistema tem tempo de acomodação menor do que o especificado. 
    Para atendermos o mais próximo possível as especificações do problema,
    uma possível abordagem é o uso do controlador PID com o cancelamento
    do polo da planta em s = −4 porém, devemos escolher polos dominantes
    de malha fechada com um coeficiente de amortecimento ζ maior para
    reduzirmos o sobressinal e frequência natural ωn menor para deixarmos
    o sistema mais lento. Assim, escolhendo zeta = 0,89 e ωn = 1,3 rad/s
    resulta nos polos dominantes de malha fechada s1,2 = −1,157 ± j0,593.
    Com base nesses novos polos de malha fechada, projete um controlador
    PID na forma C(s) = KcTd(s + 1/Td)(s + 1/Ti)/s = K(s + z1)(s + z2)/s e
    verifique se as especificações do problema são atendidas.

    Dica: para a determinação da condição de ângulo do lugar das raízes
    considere a porção do PID responsável pelo zero para realizar o
    cancelamento com o polo da planta e o integrado juntamente com G(s)
%}

num_g = 10;
den_g = [1 4 0];
G = tf(num_g, den_g)

z1 = -4;
num_pd = [1 -z1];
den_pd = 1;
Cpd = tf(num_pd, den_pd)

real_s1 = -1.157;
img_s1 = 0.593;
s1 = real_s1 + 1i * img_s1

%{
    a) A contribuição angular que o termo (s + z2) do compensador deve
    inserir no lugar das raízes é:
%}

s = tf('s');
ang = rad2deg(angle(evalfr(Cpd * G / s, s1)))

if ang < 0
    phi = - 180 - ang
else
    phi = 180 - ang
end

if phi < 0
    phi = 360 + phi
end

%{
    b) Para atender a contribuição angular ϕ, o zero do compensador em
    s = −z2, deve estar:
%}

x = img_s1 / tand(180 - phi);
z2 = -(-real_s1 - x)

%{
    c) O ganho do compensador vale:
%}

num_pi = [1 -z2];
den_pi = [1 0];
Cpi = tf(num_pi, den_pi);

K = 1 / abs(evalfr(G * Cpi * Cpd, s1))

%{
    d) O compensador na forma C(s) = K(as^2 + bs + c) / s é:
%}

Cpi * Cpd

%{
    e) Com o controlador PID projetado, o sistema em malha fechada
    tem polos dominantes em:
%}

Gc = K * G * Cpi * Cpd;
Gcmf = feedback(Gc, 1);
s2 = pole(Gcmf);
real_s2 = real(s2(2))
img_s2 = imag(s2(2))

%{
    f) O sobressinal e o tempo de acomodação teórico associado
    a estes polos é:
%}

damp_c = sqrt((real_s2^2) / (real_s2^2 + img_s2^2));
natural_frequency_c = -real_s2 / damp_c;

up_c = exp(-damp_c * pi / sqrt(1 - damp_c^2)) * 100
ts_c = 4 / (damp_c * natural_frequency_c)

%{
    g) Todavia, mesmo o sistema resultante sendo de segunda ordem,
    devido aos efeitos do  zero em malha fechada, o sobressinal do
    sistema compensado e o seu tempo de acomodação são de:
%}

step(Gcmf);











