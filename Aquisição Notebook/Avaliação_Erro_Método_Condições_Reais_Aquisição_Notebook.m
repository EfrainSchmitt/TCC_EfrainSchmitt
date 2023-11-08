clear;      #Limpa memoria
close all;  #Fecha todas as figuras
clc;        #Limpa janela de comandos
pkg load signal; #Importa biblioteca de sinal


#Flag que define se plot gráficos
plotEnable = 0;

#Loop para realizar o método para as 8 fonte sonoras
for i=1:8,
  #Faz a leitura dos sinais de audio
  [MIC1 fs] = audioread(["FR_T",num2str(i),"_microfone_1.wav"]);
  [MIC2 fs] = audioread(["FR_T",num2str(i),"_microfone_2.wav"]);
  [MIC3 fs] = audioread(["FR_T",num2str(i),"_microfone_3.wav"]);

  #Calcula as correlacoes cruzadas
  r12 = xcorr(MIC1,MIC2);         #Eq. (4)
  n12 = find(r12==max(r12));      #Eq. (5)
  t12 = (n12 - length(MIC1))/fs;  #Conversão em tempo

  r23 = xcorr(MIC2,MIC3);         #Eq. (4)
  n23 = find(r23==max(r23));      #Eq. (5)
  t23 = (n23 - length(MIC2))/fs;  #Conversão em tempo

  r31 = xcorr(MIC3,MIC1);         #Eq. (4)
  n31 = find(r31==max(r31));      #Eq. (5)
  t31 = (n31 - length(MIC3))/fs;  #Conversão em tempo

  #Plot do resultado das correlações cruzadas
  if plotEnable
    figure();
    subplot(3,1,1);
    plot(r12);
    title(["Correlação Cruzada entre MIC1 e MIC2 - FR-",num2str(i)]);
    subplot(3,1,2);
    plot(r23);
    title(["Correlação Cruzada entre MIC2 e MIC3 - FR-",num2str(i)]);
    subplot(3,1,3);
    plot(r31);
    title(["Correlação Cruzada entre MIC3 e MIC1 - FR-",num2str(i)]);
  endif

  #Calculando ângulo
  T = [-sqrt(1/6) sqrt(1/2) sqrt(1/3); sqrt(2/3) 0 sqrt(1/3); -sqrt(1/6) -sqrt(1/2) sqrt(1/3)]; %Eq.(29)
  tau = [t12 t23 t31]';   #Eq. (33)
  tau_linha = T'*tau;     #Eq. (28)

  thetaRad = atan(tau_linha(1)/tau_linha(2));   #Eq. (27)
  thetaGraus(i) = thetaRad * 180/pi;            #Converte em graus
endfor

#Imprime no display
display(["        ", "Real[º]", "   ", "Calculado[º]", "    ", "Diferença[º]"]);
display(["FR_T1   ", "90 ",   "        ", num2str(90-thetaGraus(1)), "         ", num2str(abs(90-(90-thetaGraus(1))))]);
display(["FR_T2   ", "51.3",   "       ", num2str(90-thetaGraus(2)),"        ", num2str(abs(51.3-(90-thetaGraus(2))))]);
display(["FR_T3   ", "26.5 ",   "      ", num2str(90-thetaGraus(3)), "         ", num2str(abs(26.5-(90-thetaGraus(3))))]);
display(["FR_T4   ", "0 ",   "         ", num2str(90-thetaGraus(4)), "          ", num2str(abs(0-(90-thetaGraus(4))))]);
display(["FR_T5   ", "323.1",   "      ", num2str(270-thetaGraus(5)), "        ", num2str(abs(323.1-(270-thetaGraus(5))))]);
display(["FR_T6   ", "270",   "        ", num2str(270-thetaGraus(6)),"        ", num2str(abs(270-(270-thetaGraus(6))))]);
display(["FR_T7   ", "225",   "        ", num2str(270-thetaGraus(7)),"        ", num2str(abs(225-(270-thetaGraus(7))))]);
display(["FR_T8   ", "168.7",   "      ", num2str(90-thetaGraus(8)),"         ", num2str(abs(168.7-(90-thetaGraus(8))))]);
