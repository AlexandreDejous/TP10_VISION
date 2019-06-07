%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - Laboratoire Télécoms Signaux Images
%
%	TD10, EXO 1 : Analyse de chiffres manuscrits par la méthode des cavités
%                Programme principal d'extraction des positions et des paramètres
%                Sauvegarde dans pos.mat et param.mat
%               
%                Utilise les fichiers cavites.m et localise.m
%
%                Lancer ensuite base.m pour constituer les bases
%                d'apprentissage et de test
%	(G.Burel)
%	
%	Modification : 26.05.2010
%
%--------------------------------------------------------------------------------------
close all
clear all
warning('OFF', 'all')
clc

affich =1;
disp 'Extraire surfaces relatives des cavités et les stocker dans des fichiers mat'    
for n = 3:5
    for e=1:2
        ref = sprintf('%de%d',n,e);
        nom = sprintf('%s.tif',ref);
        disp(nom)
        I = imread(nom);
        I = double(I);
        
        % Pretraiter
        I = pretraiter(I);
        
        % Segmenter
        [pos,iml] = segmenter(I);
        nom = sprintf('pos%s',ref);
        save(nom,'pos');
        
        % Recherche des cavites
        figure;
        X = ones(size(I));
        for nc = 1:size(pos,1)
            img = I(pos(nc,1):pos(nc,3),pos(nc,2):pos(nc,4));
            [Ximg,map,par] = cavites(img); 
            X(pos(nc,1):pos(nc,3),pos(nc,2):pos(nc,4))=Ximg;            
            param(:,nc)=par;
            close all
        end;
        figure,imshow(X,map)
        title('E:rouge W:vert S:bleu N:jaune C:violet');
        nom = sprintf('cav%s.tif',ref);
        imwrite(X,map,nom,'tif');
        nom = sprintf('param%s',ref);
        save(nom,'param');
        clear param
%        pause
    end;
end;

    