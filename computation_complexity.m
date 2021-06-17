P = 36;
u1 = 4;
u2 = 8;
u3 = 12;
T = 20:2:40;
 
F1 = P*T + (P)^2.*T + (P).*T.*log(P);
F2 = P*T + [(P)^2*u1 + (P).*u1.*log(P)];
F3 = P*T + [(P)^2*u2 + (P).*u2.*log(P)];
F4 = P*T + [(P)^2*u3 + (P).*u3.*log(P)];
F5 = P*T+(P^2.*T + P*T)+(P*T+T).*log(P*T+T);
 figure(4);   
plot(T, F2,'ks-',T, F3, 'ko-',T,F4,'k^-',T,F1,'kx-',T,F5,'k+-');
xlabel('Number of targets');
ylabel('Computational Complexity');
%legend('offline','online', 'graph replication','Location','SouthEast');
hold on
legend('Online algorithm (window size =4)','Online algorithm (window size =8)','Online algorithm (window size =12)','Khuller algorithm','Liao algorithm');
