clc
clear all
close all

%{
    Deseja-se que o sistema siga uma referência do tipo degrau com
    erro nulo. Adicionalmente, os polos de malha fechada devem ser
    s1,2 = −2. Para isso, utiliza-se a estrutura de controle
    abaixo com os seguintes ganhos K=[−4 0] e kr=4.
%}

A = [0 1 ; -8 -4];
B = [0 ; 1];
C = [1 0];
D = 0;
sys = ss(A, B, C, D);

K = [-4 0];
Kr = 4;
s1 = -2;

%{
    a) Os elementos das matrizes AMF, BMF e CMF são:
%}

Amf = A - B * K
Bmf = B * Kr
Cmf = C

sysMF = ss(Amf, Bmf, Cmf, D)

%{
    b) O ganho CC do sistema compensado vale:
%}

dc_gain = dcgain(sysMF)

%{
    c) O erro em regime permanente para o sistema compensado para uma
    referência do tipo degrau unitário vale:

    e(∞) = r(∞) - r(∞) * dc_gain
    e(∞) = r(∞)
%}

%{
    d)  Logo, a saída em regime permanente do sistema compensado
    para uma referência do tipo degrau unitário vale:
%}

step(sysMF)

%{
    e) Supondo uma variação paramétrica na matriz B do sistema, isto é:
%}

B_var = [0 ; 1.5];

%{
    A saída do sistema em regime permanente vale:
%}

Amf_var = A - B_var * K;
Bmf_var = B_var * Kr;
sysMF_var = ss(Amf_var, Bmf_var, Cmf, D);
dcgain(sysMF_var)
step(sysMF_var)

%{
    Validando os polos em malha fechada do sistema
%}
eig(Amf)
eig(Amf_var)
