clc;
clear all;
close all;

%{
    Deseja-se realizar o projeto de um controlador de avanço para que o
    sistema a ser compensado tenha, em malha fechada com realimentação
    unitária, um sobressinal de 10% e tempo de acomodação de 2 segundos
    para o critério de 2%.

    %UP     = 10%
    Ts(2%)  = 2s 
%}

up = 0.1;
ts = 2;

%{
    a) Para atender a estas especificações, o coeficiente de amortecimento
    dos polos dominantes de malha fechada deve ser:
%}

dump = -log(up) / sqrt(pi^2 + (log(up))^2)

%{
    b) A frequência natural dos polos dominantes de malha fechada deve ser:
%}

natural_frequency = 4 / (ts * dump)

%{
    c) A partir destes valores, os polos dominantes de
    malha fechada do sistema compensado devem ser:
%}

poles = [
            -(dump * natural_frequency)
            natural_frequency * sqrt(1 - dump^2)
        ]