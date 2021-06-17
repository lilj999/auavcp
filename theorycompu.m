P1 = 36;
P2 = 45;
P3 = 50;
T1 = 20;
%T2 = 30;
%T3 = 40;
for i = 2:20
    U(i-1) = i;
    COM1(i-1) = [(P1)^2.*U(i-1) + (P1)*U(i-1)*log(P1)]*(T1-U(i-1)+1);
    COM2(i-1) = [(P2)^2.*U(i-1) + (P2)*U(i-1)*log(P2)]*(T1-U(i-1)+1);
    COM3(i-1) = [(P3)^2.*U(i-1) + (P3)*U(i-1)*log(P3)]*(T1-U(i-1)+1);
end

%(P^2+P*u).*log(P^2+P.*u).*(T-u+1);
figure(6)
plot(U,COM1,'k*-');
xlabel('The window size');
ylabel('Number of calculations');
hold on
plot(U,COM2,'ko-');
plot(U,COM3,'kd-');