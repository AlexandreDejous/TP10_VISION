%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - Laboratoire T�l�coms Signaux Images
%
%	TD10, EXO 3 : Classification de la base de test
%	(G.Burel)
%	             Doit etre lanc� apr�s base.m qui produit le fichier
%	             bases.mat
%
%                Utilise la fonction TraceRes.m pour l'affichage graphique
%                des r�sultats de classification
%
%	Modification : 06.04.2012
%
%--------------------------------------------------------------------------------------
close all
clear all
warning('OFF', 'all')
clc
load 'winpos.mat'

%% Charger les bases d'apprentissage et de test
load bases

%% initialiser le taux d'erreurs et la matrice de confusion
nb_erreurs=0;
conf = zeros(3,3);

%% Pr�traiter les images test�es
I3 = pretraiter(imread('3e2.tif'));id3 = figure;imshow(I3);
I4 = pretraiter(imread('4e2.tif'));id4 = figure;imshow(I4);
I5 = pretraiter(imread('5e2.tif'));id5 = figure;imshow(I5);

%% Chargement des images de cavit� - pour affichage
[ci3,map] = imread('cav3e2.tif');ci3a = imread('cav3e1.tif');
ci4 = imread('cav4e2.tif');ci4a = imread('cav4e1.tif');
ci5 = imread('cav5e2.tif');ci5a = imread('cav5e1.tif');

%% Classification des chiffres de la base de test par le ppv
for x = 1:size(TestIn,2)                                % Boucle sur les chiffres test�s
    err_quad = zeros(1,size(LearnIn,2));                % vecteur ligne des erreurs quadratiques (Nb de colonnes = Nb d'ex appris)
    for i=1:size(LearnIn,2)
        for k=1:5
            err_quad(i) = errquad(i) + (LearnIn(k,i)-TestIn(k,x))^2
        end% Boucle sur les exemples d'apprentissage   
        
        % Calculer le vecteur d'erreur par rapport � chaque exemple appris
        %-- A REMPLIR                                    % Calculer l'erreur quadratique correspondante
    end
   
    [err_quad_min,index]=min(err_quad_min);             % rechercher l'index correspondant � l'erreur min
    classe=Learn(Class(index));                                % classe correspondante du plus proche voisin
    nb_erreurs = nb_erreurs+(classe~=TestClass(x));     % compter le nombre d'erreurs de classification
    conf(TestClass(x)-2,classe-2)=conf(TestClass(x)-2,classe-2)+1;  % matrice de confusion
    % Affichage 
    if (classe~=TestClass(x))                           
        disp(sprintf('Chiffre [%3d %3d]: %d classe en %d',TestPos(1,x),TestPos(2,x),TestClass(x),classe))
        [I3,I4,I5]=TraceRes(x,TestClass(x),classe,TestPos,I3,I4,I5);
        [ci3,ci4,ci5]=TraceRes(x,TestClass(x),classe,TestPos,ci3,ci4,ci5);  
    end
end;

%% Afficher les r�sultats de classification
disp('RESULTATS DE CLASSIFICATION PAR LA METHODE PPV');
disp (sprintf('\nTaux d''erreurs   = %f %%',100*nb_erreurs/size(TestIn,2)));
disp (sprintf('\nTaux de reusssite = %f %%',100*(1-nb_erreurs/size(TestIn,2))));
disp (sprintf('\nMatrice de confusion, en (i,j) le nombre de chiffres i classes en j:\n'))
for i=1:3
    disp (sprintf('        %2d   %2d   %2d',conf(i,1),conf(i,2),conf(i,3)))
end
% visualisation des erreurs indiqu�es par des petits carr�s
figure(id3),imshow(I3);set(gcf,'Position',winpos);
figure(id4),imshow(I4);set(gcf,'Position',winpos);
figure(id5),imshow(I5);set(gcf,'Position',winpos);

% Visualisation des images de cavit�
figure,subplot(1,2,1),imshow(ci3a,map),title('Cavit�s image 3e1 (APPR.)');
subplot(1,2,2),imshow(ci3,map),title('Cavit�s image 3e2 (TEST)');set(gcf,'Position',winpos);
figure,subplot(1,2,1),imshow(ci4a,map),title('Cavit�s image 4e1 (APPR.)');
subplot(1,2,2),imshow(ci4,map),title('Cavit�s image 4e2 (TEST)');set(gcf,'Position',winpos);
figure,subplot(1,2,1),imshow(ci5a,map),title('Cavit�s image 5e1 (APPR.)');
subplot(1,2,2),imshow(ci5,map),title('Cavit�s image 5e2 (TEST)');set(gcf,'Position',winpos);

