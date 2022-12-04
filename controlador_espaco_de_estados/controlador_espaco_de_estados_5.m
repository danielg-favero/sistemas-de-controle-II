clc
clear all
close all

%{
    Deseja-se que o sistema siga uma referência do tipo degrau com erro
    nulo. Adicionalmente, os polos de malha fechada devem ser
    s1,2 = −5 ± j3√3 e s3 = −50. Para isso, utiliza-se a estrutura de
    controle abaixo com os seguintes ganhos K=[2600, 352, 30] e kr=2600
%}

A = [0 1 0 ; 0 0 1 ; 0 -200 -30];
B = [0 ; 0 ; 1];
C = [1 0 0];
D = 0;

sys = ss(A, B, C, D);

K = [2600 352 30];
Kr = 2600;

%{
    a) Os elementos das matrizes AMF, BMF e CMF são:
%}

Amf = A - B * K
Bmf = B * Kr
Cmf = C

sysMF = ss(Amf, Bmf, Cmf, D);

%{
    b) O ganho CC do sistema compensado vale:
%}

dc_gain = dcgain(sysMF)

%{
    c) O erro em regime permanente para o sistema compensado para uma
    referência do tipo degrau unitário vale:

    e(∞) = r(∞) - r(∞) * dc_gain
    e(∞) = 0
%}

%{
    d) Logo, a saída em regime permanente do sistema compensado para
    uma referência do tipo degrau unitário vale:
%}

[num, den] = ss2tf(Amf, Bmf, Cmf, D)
Gmf = tf(num, den)
step(sysMF)

%{
    e) Supondo uma variação paramétrica na matriz C do sistema, isto é,
    C=[0,500] o erro em regime permanente para o sistema compensado
    para uma referência do tipo degrau unitário vale:
%}

Cvar = [0.5 0 0]
sysMF_var = ss(Amf, Bmf, Cvar, D);

dc_gain_var = dcgain(sysMF_var)
step(sysMF_var)

%{
    Validando os polos em malha fechada do sistema
%}

eig(Amf)


