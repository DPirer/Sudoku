% TRABAJO

% Desarrollar un sistema de visi�n que resuelva Sudokus. Utilice una webcam
% o la c�mara de un tel�fono m�vil (ver ejercicio 9). Se puede suponer que 
% frente a la c�mara estar� un (�nico) Sudoku est�ndar de 9x9 n�meros (aqu�
% ver� muchos). Tras resolverlo se deber� mostrar en pantalla sobre la 
% imagen, en las posiciones vac�as, los n�meros faltantes.

% Autores: Ricardo Camacho, Pedro Est�vez, Alberto Garc�a

clear, clc, close all;

% Cargamos la imagen del sudoku a resolver y lo pasamos a BW
sudoku = imread('sudoku.png');
sudoku = im2bw(sudoku);
figure(1); imshow(sudoku);

% Cargamos la m�scaras de los n�meros y las pasamos a BW
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

% Realizamos la correlaci�n y la ploteamos
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
% surf(correlacion_uno); shading interp; title('Correlaci�n uno');
surf(correlacion_dos); shading interp; title('Correlaci�n dos');
% subplot(254); surf(correlacion_tres); shading interp; title('Correlaci�n tres');
% subplot(255); surf(correlacion_cuatro); shading interp; title('Correlaci�n cuatro');
% subplot(256); surf(correlacion_cinco); shading interp; title('Correlaci�n cinco');
% subplot(257); surf(correlacion_seis); shading interp; title('Correlaci�n seis');
% subplot(258); surf(correlacion_siete); shading interp; title('Correlaci�n siete');
% subplot(259); surf(correlacion_ocho); shading interp; title('Correlaci�n ocho');
% subplot(2,5,10); surf(correlacion_nueve); shading interp; title('Correlaci�n nueve');

