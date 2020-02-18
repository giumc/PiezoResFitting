%Preconditioning 
clear all
close all
clc

%% Read file

%[filename1, pathname] = uigetfile('.s2p','Select the S-parameter file');
%filename = strcat(pathname, filename1);
filename = '/Users/lcolombo/Desktop/Fitting test/R3C5_80MHz_140MHz_Pm20dB_vacuum.s2p';
data = read(rfdata.data, filename);

freq = data.freq;
om=(2*pi).*freq;

%% Extract S-parameters
s_params = extract(data, 'S_PARAMETERS',50);
s11 = squeeze(s_params(1,1,:));
s12 = squeeze(s_params(1,2,:));
s21 = squeeze(s_params(2,1,:));
s22 = squeeze(s_params(2,2,:));

% Read Y-parameters
y_params = s2y(s_params, 50);
y11 = squeeze(y_params(1,1,:));
y12 = squeeze(y_params(1,2,:));
y21 = squeeze(y_params(2,1,:));
y22 = squeeze(y_params(2,2,:));

%% Fitting test

%x = [C0, Q, kt2];

Ydata = -y12;
[Ymax, posYmax] = max(abs(Ydata));
fs = freq(posYmax);
oms = 2*pi*fs;

C0dummy = 100e-15;
Qsdummy = 1000;
kt2dummy = 0.1;

C0 = @(x) C0dummy*x(1); 
Qs = @(x) Qsdummy*x(2);
kt2 = @(x) kt2dummy*x(3);

Rm = @(x) pi^2/8*1./(oms*C0(x)*kt2(x)*Qs(x));
Lm = @(x) pi^2/8*1./(oms^2*C0(x)*kt2(x));
Cm = @(x) 8/pi^2*C0(x).*kt2(x);

Yfit = @(x) 1i*om*C0(x) + 1./(Rm(x) + 1i*om*Lm(x) + 1./(1i*om*Cm(x)));

%F = @(x) sum(abs(Yfit(x) - Ydata)).^2;
%F = @(x) sum(abs(20*log10(abs(Yfit(x))) - 20*log10(abs(Ydata)))).^2;
F = @(x) sum(abs(angle(Yfit(x)) - angle(Ydata))).^2;

%% Optimization

%Initial guess
x0 = [1 1 1];

%Other parameters
A = [];                 %Matrix of linear inequalities unknown
b = [];                 %Vector of known linear inequalities parameters
Aeq = [];               %Matrix of linear equalities unknown
beq = [];               %Vector of known linear inequalities parameters
lb = zeros(3,1);        %Lower boundary (of each x(i))
ub = [];                %Upper boundary (of each x(i))

%Options
options = optimset;
options.OptimalityTolerance = 0.1e-15;

%Optimization
[x, fval, ef, output, lambda] = fmincon(F, x0, A, b, Aeq, beq, lb, ub, [], options);

C0Fit = x(1)*C0dummy;
QsFit = x(2)*Qsdummy;
kt2Fit = x(3)*kt2dummy;

figure(1)
plot(freq/1e6, 20*log10(abs(Ydata)),'LineWidth',3)
hold on
plot(freq/1e6, 20*log10(abs(Yfit(x))),'LineWidth',3)
xlabel('Frequency, {\itf} [MHz]')
ylabel('Admittance, {\itY} [dB]')
grid on
legend('Data','Fitting')

set(gcf,'color','white')
set(gca,'FontSize',13)