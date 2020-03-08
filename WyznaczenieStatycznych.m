clear all;
t_skok = 100;
ro_p = 1.2;  %gestosc powietrza [kg/m^3]
cp = 1000;  %cieplo wlasciwe powietrza [J/kgK]
%Wartosci nominalne
TzN = 30;    %temperatura medium grzewczego;
TzewN = -2; %temperatura na zewnatrz budynku
fpN = 1;    %natezenie strumienia grzewczego [m^3/s]
TwewN = 22; %temperatura w glownym pomieszczeniu
TpN = 18;   %temperatura poddasza


Tz0 = TzN;
Tzew0 = TzewN; 
fp0 = fpN;   
Twew0 = TwewN; 
Tp0 = TpN;   
Vw = 10*10*10; %objetosc glownego pomieszczenia
Vp = 10*10*2; %objetosc poddasza
Cvw = cp*ro_p*Vw; %pojemnosc cieplna J/K*m^3
Cvp = cp*ro_p*Vp;
a = 0.25;

d_Tz = 0;
d_Tzew = 0;
d_fp =0;


A = [Tp0-Twew0 Tzew0-Twew0;Twew0-Tp0 a*(Tzew0-Tp0)];
B = [(-1)*cp*ro_p*fp0*(Tz0-Twew0);0];
X = inv(A)*B;

K1 = X(1)
Kw = X(2)
Kp = X(2)*a


%Od Tzew
Tzew_stat=-30:1:10;
L_stat=Kw.*Tzew_stat+cp*ro_p*fp0*Tz0+(K1*Kp.*Tzew_stat)/(K1+Kp);
M_stat=(cp*ro_p*fp0+K1+Kw-(K1*K1)/(K1+Kp));

Twew_stat=L_stat./M_stat;
Tp_stat=(K1.*Twew_stat+Kp.*Tzew_stat)/(K1+Kp);

figure(1);
plot(Tzew_stat, Twew_stat);
xlabel('Tzew [°C]'); 
ylabel('Twew [°C]');
grid on;
title('Charakterystyka statyczna Twew od Tzew')
figure(2);
plot(Tzew_stat, Tp_stat);
xlabel('Tzew [°C]'); ylabel('Tp [°C]'); grid on;
title('Charakterystyka statyczna Tp od Tzew')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%od Tz
Tz_stat=0:1:90;
L_stat2=Kw*Tzew0+cp*ro_p*fp0.*Tz_stat+(K1*Kp*Tzew0)/(K1+Kp);
M_stat2=(cp*ro_p*fp0+K1+Kw-(K1*K1)/(K1+Kp));
Twew_stat2=L_stat2./M_stat2;
Tp_stat2=(K1.*Twew_stat2+Kp*Tzew0)/(K1+Kp);

figure(3);
plot(Tz_stat, Twew_stat2);
xlabel('Tz [°C]'); ylabel('Twew [°C]'); grid on
title('Charakterystyka statyczna Twew od Tz')
figure(4);
plot(Tz_stat, Tp_stat2);
xlabel('Tz [°C]'); ylabel('Tp [°C]'); grid on;
title('Charakterystyka statyczna Tp od Tz')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%od fp
fp_stat=0:0.1:4;
L_stat3=Kw*Tzew0+cp*ro_p.*fp_stat*Tz0+(K1*Kp*Tzew0)/(K1+Kp);
M_stat3=(cp*ro_p.*fp_stat+K1+Kw-(K1*K1)/(K1+Kp));
Twew_stat3=L_stat3./M_stat3;
Tp_stat3=(K1.*Twew_stat3+Kp*Tzew0)/(K1+Kp);

figure(5);
plot(fp_stat, Twew_stat3);
xlabel('fp [m^3/s]'); ylabel('Twew [°C]'); grid on
title('Charakterystyka statyczna Twew od fp')
figure(6);
plot(fp_stat, Tp_stat3);
xlabel('fp [m^3/s]'); ylabel('Tp [°C]'); grid on;
title('Charakterystyka statyczna Tp od fp')
