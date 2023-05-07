[XX,YY] = meshgrid(linspace(0,1,101),linspace(0,1,101));

div_poly = [];
div_tryg = [];

% dla K-1, gdzie K=5
[x, y, f, xp, yp] = lazik(4);

[p] = polyfit2d(x,y,f);
[FP_prev] = polyval2d(XX,YY,p);

[t] = trygfit2d(x,y,f);
[FT_prev] = trygval2d(XX,YY,t);

for K = 5:45
    [x, y, f, xp, yp] = lazik(K);

    % interpolacja wielomianowa
    [p] = polyfit2d(x,y,f);
    [FP] = polyval2d(XX,YY,p);

    % interpolacja trygonometryczna
    [t] = trygfit2d(x,y,f);
    [FT] = trygval2d(XX,YY,t);

    div_poly = [div_poly, max(max(abs(FP-FP_prev)))];
    div_tryg = [div_tryg, max(max(abs(FT-FT_prev)))];
    FP_prev = FP;
    FT_prev = FT;
end

figure();
plot(div_poly);
title("Zbierzność interpolacji wielomianowej");
ylabel("Maksymalna różnica pomiędzy wartościami interpolacji");
xlabel("Liczba węzłów interpolacji K");
saveas(gcf, 'zbieznosc_interpolacji_wielomianowej.png');

figure();
plot(div_tryg);
title("Zbierzność interpolacji trygonometrycznej");
ylabel("Maksymalna różnica pomiędzy wartościami interpolacji");
xlabel("Liczba węzłów interpolacji K");
saveas(gcf, 'zbieznosc_interpolacji_trygonometrycznej.png');