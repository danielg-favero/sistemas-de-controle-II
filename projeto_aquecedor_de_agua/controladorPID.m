clear
close all
clc

% Definindo s como função de transferência
s = tf('s');

%{
    Dados da modelagem
%}
num = 4899.2;
den = [2153 1];
G = tf(num, den);

K_ph = 2.39 * 10^-4;
R = 16.129;
P = 1 / R;
Kcciclos = 1349.80;
Ksensor = 0.1;

G_planta = G * K_ph * P * Kcciclos * Ksensor;
Gmf = feedback(G_planta, 1);    

p = pole(Gmf)
damp = 1.2;
settling_time = 480;
natural_frequency = 4 / (damp * settling_time);

% Encontrando os polos dominantes do sistema
img_s1 = natural_frequency * sqrt(1 - damp^2);
real_s1 = - damp * natural_frequency;
s1 = real_s1 + img_s1;

% Encontrando o ângulo entre o polo e o zero do controlador PD
% Se ang = 180, é necessário apenas encontrar o ganho do controlador

ang = rad2deg(angle(evalfr(G_planta, s1)));

if ang < 0
    phi = -180 - ang
else
    phi = 180 - ang
end

if phi < 0
    phi = 360 + phi
end

x = img_s1 / tand(phi)
z = - real_s1
Td = - 1 / z;

Kc = 1 / abs(evalfr(Td * (s + 1 / Td) * G_planta, s1))

C_pd = (s + 1 / Td); % Controlador PD

% Encontrando valor do zero do integrador
zero_int = - 1 / 100;
C_pi = (s - zero_int) / s; % Controlador PI

T_i = -1 / zero_int;
C = Kc *  C_pd * C_pi;
G_c = minreal(G_planta * C)
% rlocus(feedback(G_c, 1))
% figure()
% step(30.2 * G)
figure()
title('Sistema compensado')
step(feedback(G_c, 1))

% Definindo os valores dos componentes do circuito
C_1 = 100 * 10^-6; % valor escolhido para o projeto
C_2 = 100 * 10^-6;
R_1 = Td / C_1;
R_2 = T_i / C_2;
R_3 = 50 * 10^3;
R_4 = Kc * R_1 * R_3 / R_2;
