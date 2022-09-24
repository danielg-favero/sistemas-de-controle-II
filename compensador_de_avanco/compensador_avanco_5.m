clc;
clear all;
close all;

%{
    Considere o sistema descrito na figura abaixo onde G(s) = 16 / s(s+4).
    Deseja-se projetar um controlador de avanço C(s) para que o sistema,
    em malha fechada, tenha sobressinal de 5% e tempo de acomodação de
    0,5 segundos.

    %UP     = 5%
    Ts(2%)  = 0.5s 
%}

up = 0.05;
ts = 0.5;

%{
    a) Para atender a estas especificações, o coeficiente de amortecimento
    dos polos dominantes de malha fechada deve ser:
%}

dump = -log(up) / sqrt(pi^2 + (log(up))^2)

%{
    b) A frequência natural destes polos deve ser:
%}

natural_frequency = 4 / (ts * dump)

%{
    c) A partir destes valores, os polos dominantes de malha fechada 
    devem estar em:
%}

s = -(dump * natural_frequency) + j * natural_frequency * sqrt(1 - dump^2)

%{
    d) A contribuição angular que o compensador de avanço deve inserir
    no lugar das raízes é:
%}

Gs = 16 / (s * (s + 4));

a = angle(Gs) * 180 / pi;
phi = 180 - a

%{
    e) O ganho do compensador projetado é:

    Pelo diagrama de lugar de raízes, podemos escolher o zero do
    controlador como z = -4 para ser cancelado pelo polo da planta
    
    Assim obtemos um ângulo φ1 = 25.49º

    Podemos obter φ2 por: φ2 = φ - φ1 = 43.6385º

    Com φ2 obtemos a posição do polo do controlador no eixo real:
    p = -16
%}

z = 4;
p = 16

Gcs = (s + z) / (s + p);

% Assim, obtemos o controlador (sem ganho Kc)


% Obtemos assim o ganho Kc pela condição de módulo do sistema compensado
Kc = 1 / abs(Gcs * Gs)
