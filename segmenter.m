%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - Laboratoire T�l�coms Signaux Images
%
%	TD4, EXO 3 : Analyse de chiffres manuscrits par la m�thode des cavit�s
%	(G.Burel)
%	
%   function pos = localise(x)
%
%	Cr�ation:      28.10.2003
%	Modification : 17.03.2006
%
%--------------------------------------------------------------------------------------
function [pos,iml] = segmenter(x)

load 'winpos.mat'
affich = 1;             % 1 pour voir la segmentation, 0 sinon

%% Labelliser l'image x
[iml,N] = bwlabel(x);       % N repr�sente le nombre d'�tiquettes
disp(sprintf('     -- > %d objets d�tect�s',N));

% Afficher en couleur pour visualiser les composantes connexes 
if affich
    imaff = label2rgb(iml);
    figure, imshow(imaff); title 'Image des �tiquettes'
end

%% D�terminer les cadres englobants

% Initialiser la matrice des bo�tes englobantes
pos = zeros(N,4);

% D�terminer les cadres englobants
rect = regionprops(iml,'BoundingBox');

% Recopier suivant le format d�sir�
for k=1:N
    tmp = rect(k).BoundingBox;
    pos(k,1) = round(tmp(2));           % x1
    pos(k,2) = round(tmp(1));           % y1
    pos(k,3) = round(tmp(2)+tmp(4));    % x2 = x1 + hauteur
    pos(k,4) = round(tmp(1)+tmp(3));    % y2 = y1 + largeur  
end

%% Affichage des rectangles englobants pour v�rification 
if affich
    for i = 1:N
        for p = 1:3
            imaff(pos(i,1):pos(i,3),pos(i,2),p) = 0;imaff(pos(i,1):pos(i,3),pos(i,2)+1,p) = 0;imaff(pos(i,1):pos(i,3),pos(i,2)-1,p) = 0;
            imaff(pos(i,1):pos(i,3),pos(i,4),p) = 0;imaff(pos(i,1):pos(i,3),pos(i,4)-1,p) = 0;imaff(pos(i,1):pos(i,3),pos(i,4)+1,p) = 0;
            imaff(pos(i,1),pos(i,2):pos(i,4),p) = 0;imaff(pos(i,1)+1,pos(i,2):pos(i,4),p) = 0;imaff(pos(i,1)-1,pos(i,2):pos(i,4),p) = 0;
            imaff(pos(i,3),pos(i,2):pos(i,4),p) = 0;imaff(pos(i,3)-1,pos(i,2):pos(i,4),p) = 0;imaff(pos(i,3)+1,pos(i,2):pos(i,4),p) = 0; 
        end
    end
    imshow(imaff),  title (sprintf('%d Objets - Image des �tiquettes et rectangles englobants',N));
    set(gcf,'Position',winpos);
end



