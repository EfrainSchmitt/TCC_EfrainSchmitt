clear;      %Limpa memoria
close all;  %Fecha todas as figuras
clc;        %Limpa janela de comandos
pkg load signal; #Importa biblioteca de sinal

#Coordenadas fontes sonoras [x y]
FS_T1 = [3.5 3.5];
FS_T2 = [3.5 -3.5];
FS_T3 = [4 2.5];
FS_T4 = [0 5];
FS_T5 = [-3 4];
FS_T6 = [-1 -3];
FS_T7 = [0 -2];
FS_T8 = [-6 -5];

#Calcula angulos reais [º]
#OBS.: Todos os ângulos são ajustados tomando como referência o eixo da abcissa iniciando no primeiro quadrante em sentido anti-horário
Theta_FS_T1 = atan(FS_T1(2)/FS_T1(1))*180/pi;
Theta_FS_T2 = 360 + (atan(FS_T2(2)/FS_T2(1))*180/pi);
Theta_FS_T3 = atan(FS_T3(2)/FS_T3(1))*180/pi;
Theta_FS_T4 = atan(FS_T4(2)/FS_T4(1))*180/pi;
Theta_FS_T5 = 180 + (atan(FS_T5(2)/FS_T5(1))*180/pi);
Theta_FS_T6 = 180 + (atan(FS_T6(2)/FS_T6(1))*180/pi);
Theta_FS_T7 = 360 + (atan(FS_T7(2)/FS_T7(1))*180/pi);
Theta_FS_T8 = 180 + (atan(FS_T8(2)/FS_T8(1))*180/pi);

#Posição no plano dos microfones
Pos_MIC1 = [0 0.57725];
Pos_MIC2 = [0.5 -0.28875];
Pos_MIC3 = [-0.5 -0.28875];

#Descobre as distâncias em relação a cada microfone
d11 = sqrt((FS_T1(1)-Pos_MIC1(1))^2 + (FS_T1(2)-Pos_MIC1(2))^2);
d21 = sqrt((FS_T1(1)-Pos_MIC2(1))^2 + (FS_T1(2)-Pos_MIC2(2))^2);
d31 = sqrt((FS_T1(1)-Pos_MIC3(1))^2 + (FS_T1(2)-Pos_MIC3(2))^2);

d12 = sqrt((FS_T2(1)-Pos_MIC1(1))^2 + (FS_T2(2)-Pos_MIC1(2))^2);
d22 = sqrt((FS_T2(1)-Pos_MIC2(1))^2 + (FS_T2(2)-Pos_MIC2(2))^2);
d32 = sqrt((FS_T2(1)-Pos_MIC3(1))^2 + (FS_T2(2)-Pos_MIC3(2))^2);

d13 = sqrt((FS_T3(1)-Pos_MIC1(1))^2 + (FS_T3(2)-Pos_MIC1(2))^2);
d23 = sqrt((FS_T3(1)-Pos_MIC2(1))^2 + (FS_T3(2)-Pos_MIC2(2))^2);
d33 = sqrt((FS_T3(1)-Pos_MIC3(1))^2 + (FS_T3(2)-Pos_MIC3(2))^2);

d14 = sqrt((FS_T4(1)-Pos_MIC1(1))^2 + (FS_T4(2)-Pos_MIC1(2))^2);
d24 = sqrt((FS_T4(1)-Pos_MIC2(1))^2 + (FS_T4(2)-Pos_MIC2(2))^2);
d34 = sqrt((FS_T4(1)-Pos_MIC3(1))^2 + (FS_T4(2)-Pos_MIC3(2))^2);

d15 = sqrt((FS_T5(1)-Pos_MIC1(1))^2 + (FS_T5(2)-Pos_MIC1(2))^2);
d25 = sqrt((FS_T5(1)-Pos_MIC2(1))^2 + (FS_T5(2)-Pos_MIC2(2))^2);
d35 = sqrt((FS_T5(1)-Pos_MIC3(1))^2 + (FS_T5(2)-Pos_MIC3(2))^2);

d16 = sqrt((FS_T6(1)-Pos_MIC1(1))^2 + (FS_T6(2)-Pos_MIC1(2))^2);
d26 = sqrt((FS_T6(1)-Pos_MIC2(1))^2 + (FS_T6(2)-Pos_MIC2(2))^2);
d36 = sqrt((FS_T6(1)-Pos_MIC3(1))^2 + (FS_T6(2)-Pos_MIC3(2))^2);

d17 = sqrt((FS_T7(1)-Pos_MIC1(1))^2 + (FS_T7(2)-Pos_MIC1(2))^2);
d27 = sqrt((FS_T7(1)-Pos_MIC2(1))^2 + (FS_T7(2)-Pos_MIC2(2))^2);
d37 = sqrt((FS_T7(1)-Pos_MIC3(1))^2 + (FS_T7(2)-Pos_MIC3(2))^2);

d18 = sqrt((FS_T8(1)-Pos_MIC1(1))^2 + (FS_T8(2)-Pos_MIC1(2))^2);
d28 = sqrt((FS_T8(1)-Pos_MIC2(1))^2 + (FS_T8(2)-Pos_MIC2(2))^2);
d38 = sqrt((FS_T8(1)-Pos_MIC3(1))^2 + (FS_T8(2)-Pos_MIC3(2))^2);

#Converte as distâncias em amostras
n11 = round(d11/340*48000);
n21 = round(d21/340*48000);
n31 = round(d31/340*48000);

n12 = round(d12/340*48000);
n22 = round(d22/340*48000);
n32 = round(d32/340*48000);

n13 = round(d13/340*48000);
n23 = round(d23/340*48000);
n33 = round(d33/340*48000);

n14 = round(d14/340*48000);
n24 = round(d24/340*48000);
n34 = round(d34/340*48000);

n15 = round(d15/340*48000);
n25 = round(d25/340*48000);
n35 = round(d35/340*48000);

n16 = round(d16/340*48000);
n26 = round(d26/340*48000);
n36 = round(d36/340*48000);

n17 = round(d17/340*48000);
n27 = round(d27/340*48000);
n37 = round(d37/340*48000);

n18 = round(d18/340*48000);
n28 = round(d28/340*48000);
n38 = round(d38/340*48000);

#Constroi plot dos pontos
figure();

#Plot distâncias do ponto FS_T1
x = [Pos_MIC1(1) FS_T1(1)];
y = [Pos_MIC1(2) FS_T1(2)];
plot (x,y, "r:-");

hold on;

x = [Pos_MIC2(1) FS_T1(1)];
y = [Pos_MIC2(2) FS_T1(2)];
plot (x,y, "b:-");

x = [Pos_MIC3(1) FS_T1(1)];
y = [Pos_MIC3(2) FS_T1(2)];
plot (x,y, "g:-");

#Plot da fonte sonoras
x = [FS_T1(1) FS_T2(1) FS_T3(1) FS_T4(1) FS_T5(1) FS_T6(1) FS_T7(1) FS_T8(1)];
y = [FS_T1(2) FS_T2(2) FS_T3(2) FS_T4(2) FS_T5(2) FS_T6(2) FS_T7(2) FS_T8(2)];
plot (x, y, "r x");

#Traça eixos x e y e ajusta grid
a = [-10 10];
b = a-a;
plot(a,b, 'k');
plot(b,a, 'k');
axis([-7,7 -6,6]);
xticks(-7:1:7)
yticks(-6:1:6)
grid on;

#Plot da posição dos microfones
x = [Pos_MIC1(1) Pos_MIC2(1) Pos_MIC3(1)];
y = [Pos_MIC1(2) Pos_MIC2(2) Pos_MIC3(2)];
plot (x, y, "b o");

#Informações do gráfico
title("Coordenadas das fontes sonoras");
xlabel("Distância [m]");
ylabel("Distância [m]");
legend("d11", "d21", "d31");

%Lendo sinal de audio de referência
[X fs] = audioread('Sinal_Base.wav');

#Gera os sinais
audiowrite("FS_T1_MIC1.wav",X(1+n11:240000+n11),fs);
audiowrite("FS_T1_MIC2.wav",X(1+n21:240000+n21),fs);
audiowrite("FS_T1_MIC3.wav",X(1+n31:240000+n31),fs);

audiowrite("FS_T2_MIC1.wav",X(1+n12:240000+n12),fs);
audiowrite("FS_T2_MIC2.wav",X(1+n22:240000+n22),fs);
audiowrite("FS_T2_MIC3.wav",X(1+n32:240000+n32),fs);

audiowrite("FS_T3_MIC1.wav",X(1+n13:240000+n13),fs);
audiowrite("FS_T3_MIC2.wav",X(1+n23:240000+n23),fs);
audiowrite("FS_T3_MIC3.wav",X(1+n33:240000+n33),fs);

audiowrite("FS_T4_MIC1.wav",X(1+n14:240000+n14),fs);
audiowrite("FS_T4_MIC2.wav",X(1+n24:240000+n24),fs);
audiowrite("FS_T4_MIC3.wav",X(1+n34:240000+n34),fs);

audiowrite("FS_T5_MIC1.wav",X(1+n15:240000+n15),fs);
audiowrite("FS_T5_MIC2.wav",X(1+n25:240000+n25),fs);
audiowrite("FS_T5_MIC3.wav",X(1+n35:240000+n35),fs);

audiowrite("FS_T6_MIC1.wav",X(1+n16:240000+n16),fs);
audiowrite("FS_T6_MIC2.wav",X(1+n26:240000+n26),fs);
audiowrite("FS_T6_MIC3.wav",X(1+n36:240000+n36),fs);

audiowrite("FS_T7_MIC1.wav",X(1+n17:240000+n17),fs);
audiowrite("FS_T7_MIC2.wav",X(1+n27:240000+n27),fs);
audiowrite("FS_T7_MIC3.wav",X(1+n37:240000+n37),fs);

audiowrite("FS_T8_MIC1.wav",X(1+n18:240000+n18),fs);
audiowrite("FS_T8_MIC2.wav",X(1+n28:240000+n28),fs);
audiowrite("FS_T8_MIC3.wav",X(1+n38:240000+n38),fs);
