K = [5, 15, 25, 35];
[XX,YY] = meshgrid(linspace(0,1,101),linspace(0,1,101));
for i = 1:length(K)
    [x, y, f, xp, yp] = lazik(K(i));

    figure();
    
    subplot(2,2,1);
    plot(xp,yp,'-o','linewidth',2);
    title('Tor ruchu łazika');
    xlabel('x');
    ylabel('y');

    subplot(2,2,2);
    surf(reshape(x,K(i),K(i)),reshape(y,K(i),K(i)),reshape(f,K(i),K(i)));
    shading flat;
    title('Wartosci próbek');
    xlabel('x');
    ylabel('y');
    zlabel('f(x, y)');

    % interpolacja wielomianowa
    [p] = polyfit2d(x,y,f);
    [FP] = polyval2d(XX,YY,p);

    subplot(2,2,3);
    surf(XX,YY,FP);
    shading flat;
    title('Interpolacja wielomianowa');
    xlabel('x');
    ylabel('y');
    zlabel('f(x, y)');

    % interpolacja trygonometryczna
    [t] = trygfit2d(x,y,f);
    [FT] = trygval2d(XX,YY,t);

    subplot(2,2,4);
    surf(XX,YY,FT);
    shading flat;
    title('Interpolacja trygonometryczna');
    xlabel('x');
    ylabel('y');
    zlabel('f(x, y)');

    sgtitle(strcat('K=', int2str(K(i))));
    saveas(gcf, strcat('rozwiazanie_dla_k_', int2str(K(i)), '.png'));
end