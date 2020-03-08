clear all;
close all;
t_skok = 500;
ro_p = 1.2;  %gestosc powietrza [kg/m^3]
cp = 1000;  %cieplo wlasciwe powietrza [J/kgK]
%Wartosci nominalne
TzN = 30;    %temperatura medium grzewczego;
TzewN = -2; %temperatura na zewnatrz budynku
fpN = 1;    %natezenie strumienia grzewczego [m^3/s]
TwewN = 22; %temperatura w glownym pomieszczeniu
TpN = 18;   %temperatura poddasza
Vw = 10*10*3; %objetosc glownego pomieszczenia
Vp = 10*10*2; %objetosc poddasza
Cvw = cp*ro_p*Vw; %pojemnosc cieplna J/K*m^3
Cvp = cp*ro_p*Vp;
a = 0.25;

A = [TpN-TwewN TzewN-TwewN;TwewN-TpN a*(TzewN-TpN)];
B = [(-1)*cp*ro_p*fpN*(TzN-TwewN);0];
X = inv(A)*B;

K1 = X(1);
Kw = X(2);
Kp = X(2)*a;

vTz0 = [TzN,TzN-5,TzN-5];
vTzew0 =[TzewN,TzewN+5,TzewN+5];
vfp0=[fpN,fpN,fpN*0.5];
mark={'r','*g','b'};
for j=1:3
    switch j
        case 1
        d_Tz = 2;
        d_Tzew = 0;
        d_fp =0;
        opis = 'Tp(t)   Skok dTz = 2';
        case 2
        d_Tz = 0;
        d_Tzew = 3;
        d_fp =0;
        opis = 'Tp(t)  Skok dTzew = 3';
        case 3
        d_Tz = 0;
        d_Tzew = 0;
        d_fp =0.1;
        opis = 'Tp(t)   Skok dfp = 0.1';
    end  
for i=1:3
    
Tz0 = vTz0(i);
Tzew0 = vTzew0(i);
fp0 = vfp0(i);

C = [cp*ro_p*fp0+K1+Kw  K1*(-1);K1*(-1) K1+Kp];
D = [cp*ro_p*fp0*Tz0+Kw*Tzew0;Kp*Tzew0];
Y = inv(C) * D;

Twew0 = Y(1)
Twew1 = (cp*ro_p*fp0*Tz0 + Tzew0*(Kw+K1*(Kp/(K1+Kp))))/(cp*ro_p*fp0+K1+Kw-((K1^2)/(K1+Kp)))
Tp1 = (Kp * Tzew0 + K1*Twew0)/(K1+Kp)
Tp0 = Y(2)


hold on;
sim('model.slx',5000);
figure(j);
plot(ans.t,ans.Tp,mark{i});
xlabel('Czas [s]');
ylabel('Tp [°C]');
legend('1szy punkt pracy','2gi punkt pracy','3ci punkt pracy');
title(opis);
grid on;


% 
% plot(ans.t,ans.Tp);
% xlabel('Czas [s]');
% ylabel('Tp [C]');
% hold off;
end



end
%Wyznaczanie temperatur nominalnych
% 
% C = [cp*ro_p*fp0+K1+Kw  K1*(-1);K1*(-1) K1+Kp];
% D = [cp*ro_p*fp0*Tz0+Kw*Tzew0;Kp*Tzew0];
% Y = inv(C) * D
% TwewN = Y(1);
% TpN = Y(2);











