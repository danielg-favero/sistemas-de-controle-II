clc
close all
clear all

%{
    Considere o sistema G(s) = 2 / s^2 + 3s + 2. Obtenha as representações
    nas formas canônicas controlável, observável e diagonal ou de
    Jordan desse sistema. As representações tem a forma:
%}

num = 2
den = [1 3 2]
G = tf(num, den)

%{
    1) FORMA CANÔNICA CONTROLÁVEL:

    G(s) = b0*s^n + b1*s^(n-1) + ... + b(n-1)*s + bn
           -----------------------------------------
            s^n + a1*s^(n-1) + ... + a(n-1)*s + an
    
    |x1'  |   | 0    1     0   ...   0||x1  |   | 0 |
    |x2'  |   | 0    0     1   ...   0||x2  |   | 0 |
    |...  | = |...  ...   ...  ... ...||... | + |...|u
    |xn-1'|   | 0    0     0   ...   1||xn-1|   | 0 |
    |xn'  |   |-an -an-1 -an-2 ... -a1||xn  |   | 1 |
    
    y = [bn-an*b0 | b(n-1)-a(n-1)*b0 | ... | b1-a1*b0]|x1  | + b0*u
                                                      |x2  |
                                                      |... |
                                                      |xn  |
%}

A1 = [0 1; -2 -3]
B1 = [0 1]
C1 = [2 0]
D1 = 0

%{
    2) FORMA CANÔNICA OBSERVÁVEL:

    G(s) = b0*s^n + b1*s^(n-1) + ... + b(n-1)*s + bn
           -----------------------------------------
            s^n + a1*s^(n-1) + ... + a(n-1)*s + an
    
    |x1'  |   | 0    0    ...    0    -an ||x1  |   |     bn-an*b0     |
    |x2'  |   | 1    0    ...    0   -an-1||x2  |   | b(n-1)-a(n-1)*b0 |
    |...  | = | 0    1    ...    0   -an-2||... | + |       ...        |u
    |xn-1'|   | ... ...   ...    ...  ... ||xn-1|   |     b2-a2*b0     |
    |xn'  |   | 0    0    ...    1    -a1 ||xn  |   |     b1-a1*b0     |
    
    y = [0 0 ... 0 1]|x1  | + b0*u
                     |x2  |
                     |... |
                     |xn  |
%}

A2 = [0 -2 ; 1 -3]
B2 = [2 ; 0]
C2 = [0 1]
D2 = 0

%{
    3) FORMA CANÔNICA DIAGONAL OU DE JORDAN:

    Se a matriz 𝑨 do sistema tiver todos os autovalores distintos e a
    matriz de transformação 𝑷 for definida tendo em suas colunas os
    autovetores da matriz 𝑨, então, o sistema similar resultante estará
    na forma canônica diagonal.
%}

%{
    Polos do sistema:
%}

system_poles = pole(G)

[res, poles, k] = residue(num, den)

A3 = [poles(1) 0 ; 0 poles(2)]
B3 = [1 ; 1]
C3 = [res(1) res(2)]
D3 = 01

%{
    Comparando as 3 representações
%}
eig(A1)
eig(A2)
eig(A3)
