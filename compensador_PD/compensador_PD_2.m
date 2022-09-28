clc;
clear all;
close all;

%{
    Considere o sistema descrito na figura abaixo onde G(s) = 1 / s(s^2+2).
    Esta planta, em malha fechada com realimentação unitária e sem
    controlador é instável. Deseja-se que o sistema, em malha fechada,
    tenha polos dominantes s1,2 = −1+j√3. Utilize compensação PD na
    forma CPD(s) = Kp(Tds+1) para atender o requisito de projeto.
%}

% Planta do sistema
den = [1 0 2 0];
num = 1;
G = tf(num, den)

% Polos dominantes do sistema
real_s1 = -1;
img_s1 = sqrt(3);
s1 = real_s1 + 1i * img_s1;

%{
    a) A contribuição angular que o controlador deve inserir no
    lugar das raízes é:
%}

angle = rad2deg(angle(evalfr(G, s1)));

if angle >= 0
    phi = 180 - angle
else
    phi = -180 + angle
end

%{
    b) Como essa contribuição angular é muito elevada, um único controlador
    PD não é capaz de resolver o problema. Assim, propõe-se o uso de dois
    controladores PD idênticos em cascata. Com isso, a contribuição
    angular de cada controlador no lugar das raízes é:
%}

%{
    Como os controladores estão em cascata, vamos ter C1 * C2, cada um com
    sua magnitude e fase

    |C1| fase C1
    |C2| fase C2

    como estamos multiplicando números complexos, iremos:
    1 - Múltiplicar as magnitudes
    2 - Somar os ângulos
    
    como o controlador no final deve deve contribuir com 210º, cada
    controlador deve contribuir com 105º cada.
%}

%{
    c) O zero de cada compensador PD deve estar em:
%}

z = (img_s1 / tand(phi / 2)) + real_s1

%{
    d) A constante de tempo derivativo para cada compensador PD vale:
%}

Td = -1 / z

%{
    e) O ganho proporcional de cada compensador projetado é:
%}

num_c = [1 -z];
den_c = 1;
C = tf(num_c, den_c)

Kp = sqrt(1 / abs(evalfr(Td^2 * C * C * G, s1)))

%{
    f) A função de transferência do controlador C(s) para atender a
    especificação do problema é:
%}
