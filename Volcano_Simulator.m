clc; clf; clear all;

%Grafica del volcan
str = '#A52A2A';  %Establecer color café
color = sscanf(str(2:end), '%2x%2x%2x', [1 3])/255; %Establecer color café
a = 5321;
b = 100; %Base mayor
ba = 50; %Base menor
f = [-b, -ba, ba, b];
h = [0,a,a,0];
subplot(2, 5, 1:5)
fill (f, h, color) %Dibujar y colorear el volcán
set(gca,'Color','c') %Poner el fondo de color azul claro
axis ([-1250 1250 0 6000]) %Poner límites en los ejes
title ('Proyectil Volcan Nevado del Ruiz')
xlabel ('Distancia (m)')
ylabel('Altura (m)')
hold on

%Datos proyectil (Cambian dependiendo el volcan)
%En este caso se simulará el Volcan Nevado del Ruiz
y0 = input("Ingresa la altura(m) del volcán: "); %Altura inicial en m
v0 = input("Ingresa la velocidad (100-300 m/s): "); %Velocidad inicial
an = deg2rad(input("Ingresa el angulo de salida " + ...
    "(10-70 grados o 100-160 grados): ")); %Ángulo de salida
m = input("Ingresa la masa(kg): "); %Masa
delta = 0.1; %Incremento en el tiempo

%Fuerza de arrastre
cd = 0.35; %Coeficiente de arrastre
d = 1.29; %Densidad del aire
a = 3.14; %Área de la sección transversal del objeto

%Inicializacion
g = 9.8; %Gravedad
x0 = 0; %Posición inicial en x
vx0 = v0*cos(an); %Velocidad en x
vy0 = v0*sin(an); %Velocidad en y
k = (cd * d * a) / 2; %Constante k

i = 1;  %Iniciamos contador
x(i) = x0; 
vx(i) = vx0; 
ax(i) = (-k/m) * v0 * vx0; %Aceleración en x
y(i) = y0;
vy(i) = vy0; 
ay(i) = -g - (k/m) * v0 * vy0; %Aceleración en x
v(i) = v0; 
t(i) = 0;

while min(y) > 0 %Método de Euler
    t = [t, t(i) + delta];
    vx = [vx, vx(i) + ( ax(i) * delta )];
    vy = [vy, vy(i) + ( ay(i) * delta )];
    x = [x, x(i)+ (vx(i+1)*delta)];
    y = [y, y(i)+ (vy(i+1)*delta)];
    
    v = [v, sqrt(vx(i+1).^2 + vy(i+1).^2)];
    ax = [ax, (-k/m) * v(i+1) * vx(i+1)];
    ay = [ay, -g - (k/m) * v(i+1) * vy(i+1)];
    
    i = i + 1;
end

figure(1)
subplot(2, 5, 1:5)
for i=1:5:length(x) 
	 plot(x(i),y(i),'or') %Graficamos los puntos obtenidos mediante Euler
     pause(0.05) %Pausa para lograr efecto de animación
     hold on
end

%Velocidad en x
subplot(2, 5, 6)
plot (t, vx, 'g', 'LineWidth', 2) %Graficamos velocidad x con tiempo
title ('Velocidad en x')
xlabel ('Tiempo en segundos')
ylabel('Velocidad en x (m/s)')
axis('tight')
grid on %Activar cuadriculado
hold on

%Velocidad en y
subplot(2, 5, 7)
plot (t, vy, 'g', 'LineWidth', 2) %Graficamos velocidad y con tiempo
title ('Velocidad en y')
xlabel ('Tiempo en segundos')
ylabel('Velocidad en y (m/s)')
axis('tight')
grid on
hold on

%Aceleracion en x
subplot(2, 5, 8)
plot (t, ax, 'c', 'LineWidth', 2) %Graficamos aceleración x con tiempo
title ('Aceleracion en x')
xlabel ('Tiempo en segundos')
ylabel('Aceleracion en x (m/s^2)')
axis('tight')
grid on
hold on

%Aceleracion en y
subplot(2, 5, 9)
plot (t, ay, 'c', 'LineWidth', 2) %Graficamos aceleración y con tiempo
title ('Aceleracion en y')
xlabel ('Tiempo en segundos')
ylabel('Aceleracion en y (m/s^2)')
axis('tight')
grid on
hold on

%Velocidad
subplot(2, 5, 10) 
plot (t, v, 'm', 'LineWidth', 2) %Graficamos vector velocidad con tiempo
title ('Velocidad')
xlabel ('Tiempo en segundos')
ylabel('Velocidad (m/s)')
axis('tight')
grid on
hold on
