% TRABAJO

% Desarrollar un sistema de visión que resuelva Sudokus. Utilice una webcam
% o la cámara de un teléfono móvil (ver ejercicio 9). Se puede suponer que 
% frente a la cámara estará un (único) Sudoku estándar de 9x9 números (aquí
% verá muchos). Tras resolverlo se deberá mostrar en pantalla sobre la 
% imagen, en las posiciones vacías, los números faltantes.

% Autores: Ricardo Camacho, Pedro Estévez, Alberto García

clear, clc, close all;

% Cargamos la imagen del sudoku a resolver y lo pasamos a BW
sudoku = imread('sudoku.png');
sudoku = im2bw(sudoku);
figure(1); imshow(sudoku);

% Cargamos la máscaras de los números y las pasamos a BW
uno = imread('uno.jpg');
uno = im2bw(uno);
dos = imread('dos.jpg');
dos = im2bw(dos);
tres = imread('tres.jpg');
tres = im2bw(tres);
cuatro = imread('cuatro.jpg');
cuatro = im2bw(cuatro);
cinco = imread('cinco.jpg');
cinco = im2bw(cinco);
seis = imread('seis.jpg');
seis = im2bw(seis);
siete = imread('siete.jpg');
siete = im2bw(siete);
ocho = imread('ocho.jpg');
ocho = im2bw(ocho);
nueve = imread('nueve.jpg');
nueve = im2bw(nueve);

% Realizamos la correlación y la ploteamos
% correlacion_uno = normxcorr2(uno,sudoku); 
correlacion_dos = normxcorr2(dos,sudoku); 
% correlacion_tres = normxcorr2(tres,sudoku); 
% correlacion_cuatro = normxcorr2(cuatro,sudoku); 
% correlacion_cinco = normxcorr2(cinco,sudoku); 
% correlacion_seis = normxcorr2(seis,sudoku); 
% correlacion_siete = normxcorr2(siete,sudoku); 
% correlacion_ocho = normxcorr2(ocho,sudoku); 
% correlacion_nueve = normxcorr2(nueve,sudoku); 

figure(2); 
% surf(correlacion_uno); shading interp; title('Correlación uno');
surf(correlacion_dos); shading interp; title('Correlación dos');
% subplot(254); surf(correlacion_tres); shading interp; title('Correlación tres');
% subplot(255); surf(correlacion_cuatro); shading interp; title('Correlación cuatro');
% subplot(256); surf(correlacion_cinco); shading interp; title('Correlación cinco');
% subplot(257); surf(correlacion_seis); shading interp; title('Correlación seis');
% subplot(258); surf(correlacion_siete); shading interp; title('Correlación siete');
% subplot(259); surf(correlacion_ocho); shading interp; title('Correlación ocho');
% subplot(2,5,10); surf(correlacion_nueve); shading interp; title('Correlación nueve');

