
% TRABAJO

% Desarrollar un sistema de visión que resuelva Sudokus. Utilice una webcam
% o la cámara de un teléfono móvil (ver ejercicio 9). Se puede suponer que 
% frente a la cámara estará un (único) Sudoku estándar de 9x9 números (aquí
% verá muchos). Tras resolverlo se deberá mostrar en pantalla sobre la 
% imagen, en las posiciones vacías, los números faltantes.

% Autores: Ricardo Camacho, Pedro Estévez, Alberto García

clear, clc, close all;

%Cargamos la imagen del sudoku
sudoku = imread('sudoku.png');

% Creamos una copia a escala de grises
Grayscale = rgb2gray(sudoku);

% Y otra en blanco y negro
level = graythresh(Grayscale);
BW = imbinarize(Grayscale,level);

% Creamos otra imagen binaria complementada con la cuadrícula de casillas
BW2 = bwareafilt(imcomplement(BW),1,'largest');

% Nos quedamos con las coordenadas en las que esa matriz es 1, es decir,
% las líneas
[row,colom] = find(BW2==1);

% Cortamos la imagen
BW3 = BW(min(row):max(row),min(colom):max(colom));
BW4 = BW2(min(row):max(row),min(colom):max(colom));
BW5 = logical(imcomplement(BW3)-BW4);

% Calculamos los centroides  de cada casilla del sudoku
s = regionprops(imcomplement(BW2),'centroid');
centroids = cat(1, s.Centroid);

% Mostramos la imagen inicial con los centroides
imshow(BW3)
hold on
plot(centroids(:,1),centroids(:,2),'b*')
hold off
[width,height] = size(BW5);     % Calculamos el número de filas y columnas
sub_width = floor(width/9);      % Ancho de casilla
sub_height = floor(height/9);    % Altura de casilla
sudokoMatrix = [];              

% Procedemos a identificar los números
Xi=1;
for r = 1:9
    Yi=1;
    for c = 1:9
        BW6 = BW5(Xi:r*sub_height,Yi:c*sub_width);
        Yi = c*sub_width;%shifting in width direction
        %OCR of each cell
        l = ocr(BW6, 'CharacterSet', '0123456789', 'TextLayout','Block');
         T = double(l.Text);
         lenT = size(T);
           if (lenT(2)~=0)
            switch T(1)
                case 49
                    sudokoMatrix(r,c) = 1; 
                case 50
                    sudokoMatrix(r,c) = 2;
                case 51
                    sudokoMatrix(r,c) = 3;
                case 52
                    sudokoMatrix(r,c) = 4;
                case 53
                    sudokoMatrix(r,c) = 5;
                case 54
                    sudokoMatrix(r,c) = 6;
                case 55
                    sudokoMatrix(r,c) = 7;
                case 56
                    sudokoMatrix(r,c) = 8;
                case 57 
                    sudokoMatrix(r,c) = 9;
                otherwise
                    sudokoMatrix(r,c) = 0;
             end
            end
          if (lenT(2)==0)
               sudokoMatrix(r,c) = 0;
          end
    end
    Xi = r*sub_height;    % Variación en longitud
end

clc;
flag = 0;
for (i=1:9)
    for (k=1:9)
        if (sudokoMatrix(i,k)>0)
            c = [i,k,sudokoMatrix(i,k)]
                flag = 1; 
           break
           end
       end
     if(flag==1)
          break;
     end
end
 
for (i=1:9)
    for (k=1:9)
        if sudokoMatrix(i,k)>0
            b = [i,k,sudokoMatrix(i,k)]
            c = [b;c]
        end
    end
end
 
% Una vez identificados los números procedemos a dibujar el sudoku original
drawSudoku(c);

% Resolvemos el sudoku usando la toolbox de matlab
type sudokuEngine;
S = sudokuEngine(c);

% Y mostramos el resultado final
drawSudoku(S)
