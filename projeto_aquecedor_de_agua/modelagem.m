
% Gráfico do primeiro ensaio
%stackedplot(PrimeiraSimulacao)

% Converter Joules em Kcal
Kph = 2.39 * 10^-4;

% Simulação da modelagem do sistema
Kcc = 4899.2;

%{
    Valor final: 80ºC
    63.2% do valor final: 50.56
    
    Tempo inicial: 17:46
    Tempo 63.2% do valor final: 18:14
    ΔT = 28min = 1680s
%}

num = Kcc;
den = [1680 1];
G = tf(num, den);

step(30.2 * (30.2 / 16.129) * Kph * G)

