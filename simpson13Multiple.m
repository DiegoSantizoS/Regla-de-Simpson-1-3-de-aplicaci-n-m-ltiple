clc; clear all;
% Definición de la función
f = @(x) 0.2 + 25*x - 200*x.^2 + 675*x.^3 - 900*x.^4 + 400*x.^5;

% Parámetros de integración
a = 0;
b = 0.8;
n = 6; % Número de subintervalos (debe ser par)
h = (b - a) / n; % Tamaño del subintervalo

% Puntos de evaluación
x = linspace(a, b, n + 1);
y = f(x);

% Aplicación de la regla de Simpson 1/3 compuesta
S = y(1) + y(end) + 4 * sum(y(2:2:end-1)) + 2 * sum(y(3:2:end-2));
I_simpson = (h / 3) * S;

% Cálculo de la cuarta derivada de f(x)
syms xs
fs = 0.2 + 25*xs - 200*xs^2 + 675*xs^3 - 900*xs^4 + 400*xs^5;
f4_sym = diff(fs, xs, 4);
f4 = matlabFunction(f4_sym);

% Valor medio de la cuarta derivada en [a, b]
media_f4 = integral(f4, a, b) / (b - a);

% Estimación del error de truncamiento
error_trunc = -((b - a) * h^4 / 180) * media_f4;

% Valor exacto de la integral
I_exacto = 1.640533;

% Cálculo del error relativo porcentual
error_relativo = abs((I_exacto - I_simpson) / I_exacto) * 100;

% Mostrar resultados
fprintf('Integral aproximada (Simpson 1/3 Múltiple): %.6f\n', I_simpson);
fprintf('Valor medio de la cuarta derivada: %.6f\n', media_f4);
fprintf('Error de truncamiento estimado: %.6f\n', error_trunc);
fprintf('Error relativo porcentual: %.6f%%\n', error_relativo);
