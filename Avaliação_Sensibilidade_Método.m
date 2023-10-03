clear;      #Limpa memoria
close all;  #Fecha todas as figuras
clc;        #Limpa janela de comandos
pkg load signal; #Importa biblioteca de sinal

#Lendo todos os sinais de audio
[FS_T1_MIC1 fs] = audioread('FS_T1_MIC1.wav');
[FS_T1_MIC2 fs] = audioread('FS_T1_MIC2.wav');
[FS_T1_MIC3 fs] = audioread('FS_T1_MIC3.wav');

[FS_T2_MIC1 fs] = audioread('FS_T2_MIC1.wav');
[FS_T2_MIC2 fs] = audioread('FS_T2_MIC2.wav');
[FS_T2_MIC3 fs] = audioread('FS_T2_MIC3.wav');

[FS_T3_MIC1 fs] = audioread('FS_T3_MIC1.wav');
[FS_T3_MIC2 fs] = audioread('FS_T3_MIC2.wav');
[FS_T3_MIC3 fs] = audioread('FS_T3_MIC3.wav');

[FS_T4_MIC1 fs] = audioread('FS_T4_MIC1.wav');
[FS_T4_MIC2 fs] = audioread('FS_T4_MIC2.wav');
[FS_T4_MIC3 fs] = audioread('FS_T4_MIC3.wav');

[FS_T5_MIC1 fs] = audioread('FS_T5_MIC1.wav');
[FS_T5_MIC2 fs] = audioread('FS_T5_MIC2.wav');
[FS_T5_MIC3 fs] = audioread('FS_T5_MIC3.wav');

[FS_T6_MIC1 fs] = audioread('FS_T6_MIC1.wav');
[FS_T6_MIC2 fs] = audioread('FS_T6_MIC2.wav');
[FS_T6_MIC3 fs] = audioread('FS_T6_MIC3.wav');

[FS_T7_MIC1 fs] = audioread('FS_T7_MIC1.wav');
[FS_T7_MIC2 fs] = audioread('FS_T7_MIC2.wav');
[FS_T7_MIC3 fs] = audioread('FS_T7_MIC3.wav');

[FS_T8_MIC1 fs] = audioread('FS_T8_MIC1.wav');
[FS_T8_MIC2 fs] = audioread('FS_T8_MIC2.wav');
[FS_T8_MIC3 fs] = audioread('FS_T8_MIC3.wav');

#Flag que define se plot gráficos
plotEnable = 1;

cor_angulo = [90 270 90 90 90 270 270 270];
#Loop para realizar o método para as 8 fonte sonoras
for i=1:8,
  for j=1:3,
    for n=1:20,
      #Atribui o sinal da fonte sonora em análise
      MIC1 = eval(["FS_T",num2str(i),"_MIC1"]);
      MIC2 = eval(["FS_T",num2str(i),"_MIC2"]);
      MIC3 = eval(["FS_T",num2str(i),"_MIC3"]);

      #Soma valor de n ao MIC correspondente 'j'
      if j==1
        MIC1 = MIC1(n:end);
        MIC2 = MIC2(1:end-n+1);
        MIC3 = MIC3(1:end-n+1);
      elseif j==2
        MIC1 = MIC1(1:end-n+1);
        MIC2 = MIC2(n:end);
        MIC3 = MIC3(1:end-n+1);
      elseif j==3
        MIC1 = MIC1(1:end-n+1);
        MIC2 = MIC2(1:end-n+1);
        MIC3 = MIC3(n:end);
      endif

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

      #Calculando ângulo
      T = [-sqrt(1/6) sqrt(1/2) sqrt(1/3); sqrt(2/3) 0 sqrt(1/3); -sqrt(1/6) -sqrt(1/2) sqrt(1/3)]; %Eq.(29)
      tau = [t12 t23 t31]';   #Eq. (33)
      tau_linha = T'*tau;     #Eq. (28)

      thetaRad = atan(tau_linha(1)/tau_linha(2));   #Eq. (27)
      thetaGraus(i,j,n) = cor_angulo(i) - (thetaRad * 180/pi);            #Converte em graus
    endfor
  endfor
    #Plot do resultado das correlações cruzadas
  if plotEnable
    figure();
    plot(thetaGraus(i,1,:),'r');
    hold on;
    plot(thetaGraus(i,2,:), 'g');
    plot(thetaGraus(i,3,:), 'b');
    legend('Defasando amostras do MIC1', 'Defasando amostras do MIC2', 'Defasando amostras do MIC3');
    title(["Defasagem para a fonte sonora FS-T",num2str(i)]);
    xlabel("Defasagem [amostras]");
    ylabel("Ângulo [º]");
    axis([1,20 ,]);
  endif
endfor

###Imprime no display
##display(["        ", "Real[º]", "   ", "Calculado[º]", "    ", "Diferença[º]"]);
##display(["FS_T1   ", "45 ",   "       ", num2str(90-thetaGraus(1)), "         ", num2str(abs(45-(90-thetaGraus(1))))]);
##display(["FS_T2   ", "315",   "       ", num2str(270-thetaGraus(2)),"        ", num2str(abs(315-(270-thetaGraus(2))))]);
##display(["FS_T3   ", "32 ",   "       ", num2str(90-thetaGraus(3)), "         ", num2str(abs(32-(90-thetaGraus(3))))]);
##display(["FS_T4   ", "90 ",   "       ", num2str(90-thetaGraus(4)), "              ", num2str(abs(90-(90-thetaGraus(4))))]);
##display(["FS_T5   ", "127",   "       ", num2str(90-thetaGraus(5)), "        ", num2str(abs(127-(90-thetaGraus(5))))]);
##display(["FS_T6   ", "251",   "       ", num2str(270-thetaGraus(6)),"        ", num2str(abs(251-(270-thetaGraus(6))))]);
##display(["FS_T7   ", "270",   "       ", num2str(270-thetaGraus(7)),"             ", num2str(abs(270-(270-thetaGraus(7))))]);
##display(["FS_T8   ", "220",   "       ", num2str(270-thetaGraus(8)),"        ", num2str(abs(220-(270-thetaGraus(8))))]);
