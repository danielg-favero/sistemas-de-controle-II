clear
close all
clc

% Definindo s como função de transferência
s = tf('s');

% Planta do sistema
num = 4899.2;
den = [2153 1];
G = tf(num, den); % função de transferência do sistema
Kph = 2.39 * 10^-4;
Kcciclos = 1349.8;
Ksensor = 0.1;
R = 16.129;
P = 1 / R;
Gplanta = G * Kph * P * Kcciclos * Ksensor;
Gmf = feedback(Gplanta, 1);    

% Polos do sistema a malha fechada
p = pole(Gplanta)

% Zero do integrador
Ti = 1/p
Gpi = (s - 1/Ti) / s;

% Sistema compensado
Ki = 8.5;
C = Ki * Gpi;
[numC, denC] = tfdata(C, 'v')
Gc = Gplanta * C;

% Lugar de raízes do sistema compensado
rlocus(Gc);

% Resposta ao degrau unitário do sistema compensado
figure()
step(feedback(Gc, 1));

% Valores dos componentes do circuito
C2 = 100 * 10^-3;   
R2 = -Ti / C2;
R1 = 1000;
R3 = 1000;
R4 = Ki * R1 * R3 / R2;


