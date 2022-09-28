clc;
clear all;
close all;

%{
    Considere o sistema G(s)=1/(s^2−2). Esta planta, em malha fechada com 
    realimentação unitária e sem controlador é instável. 
    Deseja-se projetar um controlador PD C(s)=Kp(Tds+1) para que o
    sistema, em malha fechada, seja estabilizado e tenha polos
    dominantes com coeficiente de amortecimento ζ = 0,707 e
    frequência natural ωn = 2 rad/s.
%}

num = 1;
den = [1 0 -2];
G = tf(num, den)

natural_frequency = 2;
damp = 0.707;

%{
    Segundo o diagrama de lugar das raízes, o ganho da parte proporcional
    do controlador, que deverá ser aplicado ao sistema para que o mesmo
    seja estável é de 2
%}

K = 2;

%{
    a) Os polos dominantes de malha fechada após a compensação
    devem estar em:
%}

s1 = -natural_frequency * damp + 1i * natural_frequency * sqrt(1 - damp^2)

%{
    b) A contribuição angular que o compensador PD deve inserir
    no lugar das raízes é:
%}

% Verificando se os polos dominantes pertencem ao lugar de raízes
angle = rad2deg(angle(evalfr(G, s1)));

if angle >= 0
    phi = 180 - angle 
else
    phi = -180 - angle
end

%{
    c) O zero do compensador PD deve estar em:
%}

z = natural_frequency * sqrt(1 - damp^2) / tand(phi) + natural_frequency * damp


%{
    d) A constante de tempo derivativo vale Td:
%}

Td = 1 / z

%{
    e) O ganho proporcional do compensador projetado é Kp e a função de
    transferência do controlador PD  é:
%}

num = [1 z];
den = 1;
C = tf(num, den)

Kp = (1 / abs(evalfr(Td * C * G, s1)))
