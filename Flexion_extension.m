clear variables;
clear m;

m = mobiledev;

m.AccelerationSensorEnabled = 1;
m.SampleRate = 100;

figure;

theta = linspace(0, pi, 180);
x = cos(theta);
y = sin(theta);
plot(x, y, 'k'); 
hold on;

for deg = 0:5:180
    x1 = cosd(deg);
    y1 = sind(deg);
    if mod(deg, 15) == 0
        x2 = 0.9 * cosd(deg);
        y2 = 0.9 * sind(deg);
        plot([x1, x2], [y1, y2], 'k', 'LineWidth', 2);
        text(1.05 * x1, 1.05 * y1, num2str(deg), 'HorizontalAlignment', 'center');
    else
        x2 = 0.95 * cosd(deg);
        y2 = 0.95 * sind(deg);
        plot([x1, x2], [y1, y2], 'k', 'LineWidth', 1);
    end
end

plot([-1 1], [0 0], 'k', 'LineWidth', 2.2);

hLine = plot([0 0], [0 1], 'r', 'LineWidth', 2.5);

axis equal;
xlim([-1 1]);
ylim([0 1]);

set(gca, 'XColor', 'none', 'YColor', 'none', 'Box', 'off');

title('Inclinación del torso', 'FontSize', 18, 'Units', 'normalized', 'Position', [0.5 1.2 0]);

hAngleText = text(0, -0.1, '', 'HorizontalAlignment', 'center', 'FontSize', 16);

xlabel('Eje X');
ylabel('Eje Y');

m.Logging = 1;

pause(3);

while true
    accel = accellog(m); 
    if ~isempty(accel)
        angulo_inclinacion = atan2d(accel(end, 2), accel(end, 3)); 
       
        angulo_inclinacion = mod(angulo_inclinacion, 180);

        x = cosd(angulo_inclinacion);
        y = sind(angulo_inclinacion);

        set(hLine, 'XData', [0 x], 'YData', [0 y]);

        set(hAngleText, 'String', sprintf('Ángulo de inclinación: %.2f°', angulo_inclinacion));

        drawnow;
    end
end

