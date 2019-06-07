%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - SITe
%
%	TD10, EXO 2 : Reconnaissance de chiffres par template matching
%	
%	Modification : 06-04-2012
%
%--------------------------------------------------------------------------------------

%%
close all
clear all
clc

%% Charger l'image � analyser et labelliser
im = imread('chiffres.tif', 'tif');
% im = imread('chiffres3.tif', 'tif');
figure, imshow(im), title('Image source');


%% Lire la taille des images de r�f�rence et charger les images
info = imfinfo('0.tif');
Hr = info.Height;
Wr = info.Width;
iref = zeros(Hr,Wr,10);

% Charger les images de r�f�rence
iref(:,:,10)= imread('0.tif', 'tif');
iref(:,:,1) = imread('1.tif', 'tif');
iref(:,:,2) = imread('2.tif', 'tif');
iref(:,:,3) = imread('3.tif', 'tif');
iref(:,:,4) = imread('4.tif', 'tif');
iref(:,:,5) = imread('5.tif', 'tif');
iref(:,:,6) = imread('6.tif', 'tif');
iref(:,:,7) = imread('7.tif', 'tif');
iref(:,:,8) = imread('8.tif', 'tif');
iref(:,:,9) = imread('9.tif', 'tif');

%% labelliser l'image analys�e
[label, nbobjets] = bwlabel(im,8);
imshow(label);
N=64;map = rand(N,3);
map(1,:)=[0.0 0.0 0.0];
figure, imshow(label+1,map), title('Image labellis�e'),colorbar;

%% Template Matching

% Initialiser  
res = zeros(nbobjets,4);    % Matrice qui stocke les r�sultats
id = figure;
delta = 2;

%% Analyser chaque obket
for i=1:nbobjets 
   x = bwlabel((label == i),8);   
   figure(id), subplot(1,3,1),imshow(x), title('Forme trait�e dans l''image source');
   
   % Calculer la position du coin superieur gauche et la taille des objets
   % analys�s
   c = regionprops(x,'BoundingBox');
   y1= round(c.BoundingBox(1)); 
   x1= round(c.BoundingBox(2));
   W = c.BoundingBox(3);
   H = c.BoundingBox(4);
   
   % En deduire la position theorique de superposition des images 
   % en tenant compte de leurs dimension respectives
   % -- voir le sch�ma dans l'�nonc� du TD 
   decL = round((Wr-W)/2);
   decH = round((Hr-H)/2);
   y0 = -- A REMPLIR;
   x0 = -- A REMPLIR;

    % r�aliser la corr�lation sur un petit voisinage autour de (x0,y0)
	% pour toutes les images de r�f�rence.
    % En d�duire la d�cision sur le chiffre trait�,  avec sa position,
	% et son score de corr�lation
   maxcorr = -100;
   maxr = -1;
   for k=x0-delta:x0+delta                              % Boucle sur voisinage
      for l=y0-delta:y0+delta
         test = x(-- A REMPLIR,-- A REMPLIR);           % extraire l'image test�e (meme taille que les images de r�f�rence
         for r=1:10                                     % boucle sur les images de r�f�rence
            correl = corr2(iref(:,:,r),test);           % corr�lation
	         if correl > maxcorr                        % retenir le max
               maxcorr = correl;
               maxr = -- A REMPLIR;
            end;
         end;                  
      end;
   end
   subplot(1,3,2),imshow(x(x0:x0+Hr-1,y0:y0+Wr-1)),title('Image extraite et test�e')
   subplot(1,3,3),imshow(iref(:,:,maxr)),title('R�f�rence corr max')
   res(i,1) = -- A REMPLIR;                  % indice de l'image de reference d�tect�e
   res(i,2) = round(x0+Hr/2);	    % coordonn�e x (ligne) du point central
   res(i,3) = round(y0+Wr/2);	    % coordonn�e y (colonne) du point central
   res(i,4) = -- A REMPLIR;              % score de corr�lation
   disp(sprintf('-> %1d (%3d,%3d) %2.4f',res(i,:)));
end;

%% R�-arranger suivant les coordonn�es spatiales
% Par ordre de x0 croissant et y0 croissant
[sauve,resultat] = tri(res,nbobjets);
disp 'Resultat de la reconnaissance'
num2str(resultat')

