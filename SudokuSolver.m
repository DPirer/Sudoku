
% TRABAJO

% Desarrollar un sistema de visi�n que resuelva Sudokus. Utilice una webcam
% o la c�mara de un tel�fono m�vil (ver ejercicio 9). Se puede suponer que 
% frente a la c�mara estar� un (�nico) Sudoku est�ndar de 9x9 n�meros (aqu�
% ver� muchos). Tras resolverlo se deber� mostrar en pantalla sobre la 
% imagen, en las posiciones vac�as, los n�meros faltantes.

% Autores: Ricardo Camacho, Pedro Est�vez, Alberto Garc�a

clear, clc, close all;

% Cargamos la imagen del sudoku
sudoku = imread('hardest_sudoku.jpg');

% Creamos una copia a escala de grises
grayscale = rgb2gray(sudoku);

% Y otra en blanco y negro
BW = imbinarize(grayscale,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);

% Para poder reconocer bien distintos sudokus, tenemos que comprobar si el 
% sudoku tiene un borde negro o no
prompt = 'Tiene el sudoku un borde negro? -> ';
x = input(prompt);
if (x ~= 1)
    dimension = size(BW);
    for i=1:dimension(1)
        for j=1:dimension(2)
            if ((i<=10)||(i>=dimension(1)-10)||(j<=10)||(j>=dimension(2)-10))
                BW(j,i)= 0;
            end     
        end
    end
end

% Creamos otra imagen binaria complementada sin los n�meros, de forma que
% nos quedamos con s�lo el fondo del sudoku y las l�neas est�n a 1
BW2 = bwareafilt(imcomplement(BW),1,'largest');

% Identificamos todas las coordenadas de esas l�neas
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

% Procedemos a identificar los n�meros. Los offsets avanzan la posici�n al
% inicio de la casilla que queremos escanear, y los bucles indican el final
offset_filas = 1; 
for f = 1:9
    offset_columnas = 1; 
    for c = 1:9
        BW6 = BW5(offset_filas:f*alto_casilla,offset_columnas:c*ancho_casilla);
        offset_columnas = c*ancho_casilla;   % Avanzamos el offset de las columnas
        
        % OCR reconoce el texto de cada casilla
        identificacion = ocr(BW6, 'CharacterSet', '0123456789', 'TextLayout','Block');
        numero = str2num(identificacion.Text);
        
        % Y le asignamos un n�mero a esa posici�n
        % El switch no puede operar con un congunto vac�o, as� que tenemos
        % que poner un if para comprobar si es un cero
        if (isempty(numero) == 1) 
            sudokuMatrix(f,c) = 0;
        else
            switch numero 
                case 1
                    sudokuMatrix(f,c) = 1; 
                case 2
                    sudokuMatrix(f,c) = 2;
                case 3
                    sudokuMatrix(f,c) = 3;
                case 4
                    sudokuMatrix(f,c) = 4;
                case 5
                    sudokuMatrix(f,c) = 5;
                case 6
                    sudokuMatrix(f,c) = 6;
                case 7
                    sudokuMatrix(f,c) = 7;
                case 8
                    sudokuMatrix(f,c) = 8;
                case 9 
                    sudokuMatrix(f,c) = 9;
            end
        end
    end
    offset_filas = f*alto_casilla;    % Avanzamos el offset de las filas
end

% Ya tenemos totalmente identificada nuestra matriz. Ahora tenemos que
% ponerla de forma que la funci�n sudokuEngine, que ser� la que resuelva el
% sudoku, pueda operar con ella. Para ello tenemos que transformarla a
% tantas filas como n�meros haya, y las dos primeras columnas son las
% coordenadas y la tercera el valor de esa posici�n
clc; 
c = [];
for i=1:9
    for j=1:9
        if (sudokuMatrix(i,j)>0)
            b = [i,j,sudokuMatrix(i,j)];
            c = [b;c];
        end
    end
end
 
% Una vez identificados los n�meros procedemos a dibujar el sudoku original
drawSudoku(c);

% Resolvemos el sudoku usando la toolbox de matlab
type sudokuEngine;
S = sudokuEngine(c);

% Y mostramos el resultado final
drawSudoku(S);
clc;
