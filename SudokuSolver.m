
% TRABAJO

% Desarrollar un sistema de visi�n que resuelva Sudokus. Utilice una webcam
% o la c�mara de un tel�fono m�vil (ver ejercicio 9). Se puede suponer que 
% frente a la c�mara estar� un (�nico) Sudoku est�ndar de 9x9 n�meros (aqu�
% ver� muchos). Tras resolverlo se deber� mostrar en pantalla sobre la 
% imagen, en las posiciones vac�as, los n�meros faltantes.

% Autores: Ricardo Camacho, Pedro Est�vez, Alberto Garc�a

clear, clc, close all;

% Cargamos la imagen del sudoku
sudoku = imread('sudoku.png');

% Creamos una copia a escala de grises
Grayscale = rgb2gray(sudoku);

% Y otra en blanco y negro
BW = imbinarize(Grayscale,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);

% Creamos otra imagen binaria complementada, de forma que las l�neas del
% sudoku est�n a 1
BW2 = bwareafilt(imcomplement(BW),1,'largest');

% Identificamos las cordennadas de esas l�neas
[fila,columna] = find(BW2==1);

% Y como ya tenemos las l�neas, podemos quedarnos con todo lo de dentro, es
% decir, cortamos la imagen para quedarnos s�lo con el sudoku

% Primero nos quedamos con la imagen original recortada
BW3 = BW(min(fila):max(fila),min(columna):max(columna));

% Luego con la imagen complementada recortada
BW4 = BW2(min(fila):max(fila),min(columna):max(columna));

% Y finalmente restamos las dos para que nos queden exclusivamente los
% n�meros en blanco sobre un fondo negro
BW5 = logical(imcomplement(BW3)-BW4);

% Calculamos los centroides  de cada casilla del sudoku
s = regionprops(imcomplement(BW4),'centroid');
centroids = cat(1, s.Centroid);

% Mostramos la imagen inicial con los centroides
imshow(BW3)
hold on
plot(centroids(:,1),centroids(:,2),'b*')
hold off

% Calculamos ahora los p�xeles de las casillas, porque �stos depender�n de
% la resoluci�n de la imagen
[ancho,alto] = size(BW5);     
ancho_casilla = floor(ancho/9);      
alto_casilla = floor(alto/9);   

% Inicializamos nuestra matriz
sudokuMatrix = [];              

% Procedemos a identificar los n�meros
Xi = 1;
for f = 1:9
    Yi = 1;
    for c = 1:9
        BW6 = BW5(Xi:f*alto_casilla,Yi:c*ancho_casilla);
        Yi = c*ancho_casilla;   %shifting in width direction
        % OCR of each cell
        l = ocr(BW6, 'CharacterSet', '0123456789', 'TextLayout','Block');
         T = double(l.Text);
         lenT = size(T);
           if (lenT(2) ~= 0)
            switch T(1)
                case 49
                    sudokuMatrix(f,c) = 1; 
                case 50
                    sudokuMatrix(f,c) = 2;
                case 51
                    sudokuMatrix(f,c) = 3;
                case 52
                    sudokuMatrix(f,c) = 4;
                case 53
                    sudokuMatrix(f,c) = 5;
                case 54
                    sudokuMatrix(f,c) = 6;
                case 55
                    sudokuMatrix(f,c) = 7;
                case 56
                    sudokuMatrix(f,c) = 8;
                case 57 
                    sudokuMatrix(f,c) = 9;
                otherwise
                    sudokuMatrix(f,c) = 0;
             end
            end
          if (lenT(2)==0)
               sudokuMatrix(f,c) = 0;
          end
    end
    Xi = f*alto_casilla;    % Variaci�n en longitud
end

clc;
flag = 0;
for i=1:9
    for k=1:9
        if (sudokuMatrix(i,k) > 0)
            c = [i,k,sudokuMatrix(i,k)]
                flag = 1; 
           break
           end
       end
     if(flag == 1)
          break;
     end
end
 
for i=1:9
    for k=1:9
        if sudokuMatrix(i,k)>0
            b = [i,k,sudokuMatrix(i,k)]
            c = [b;c]
        end
    end
end
 
% Una vez identificados los n�meros procedemos a dibujar el sudoku original
drawSudoku(c);

% Resolvemos el sudoku usando la toolbox de matlab
type sudokuEngine;
S = sudokuEngine(c);

% Y mostramos el resultado final
drawSudoku(S)
