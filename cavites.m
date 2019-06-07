%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - Laboratoire Télécoms Signaux Images
%
%	TD9, EXO 1 : Analyse de chiffres manuscrits par la méthode des cavités
%	(G.Burel)
%	
%   function [X,map,param] = cavites(img)
% 
%   Input :
%       img :       image source contenant un chiffre
%
%   Return :
%       X,map :     image couleur permettant de visualiser les cavités
%       param :     vecteur ligne contenant les surfaces relatives des
%                   cinq cavités
%
%	Modification : 26.05.2010
%
%--------------------------------------------------------------------------------------
function [X,map,param] = cavites(img)

[nbligs,nbcols] = size(img);

affich = 0;   % pour voir  les résultats intermédiaires, 0 sinon

% Creation des elements structurants

E = [ones(1,nbcols) zeros(1,nbcols-1)];
E = fliplr(E);
W = fliplr(E);
S = [ones(nbligs,1);zeros(nbligs-1,1)];
S = flipud(S);
N = flipud(S);


% Dilatation par des demi-droites
dilE  = imdilate(img,E);
dilW  = imdilate(img,W);
dilN  = imdilate(img,N);
dilS  = imdilate(img,S);

if affich
    figure
    subplot(2,3,1),imshow(img);title('Source');
    subplot(2,3,2),imshow(dilE);title('Dilatation Est');
    subplot(2,3,3),imshow(dilW);title('Dilatation West');
    subplot(2,3,4),imshow(dilN);title('Dilatation Nord');
    subplot(2,3,5),imshow(dilS);title('Dilatation Sud');    
    set(gcf,'Position',[1 31 1024 666]);
end;


% Calcul des cavités
CW = (~dilE) & (dilS) & (dilN) & (~img);
CE = (~dilW) & (dilS) & (dilN) & (~img);
CS = (dilE) & (dilW) & (~dilN) & (~img);
CN = (dilE) & (dilW) & (~dilS) & (~img);
CC = (dilE) & (dilW) & (dilS) & (dilN) & (~img);

if affich
    figure
    subplot(2,3,1),imshow(img);title('Image source ');
    subplot(2,3,2),imshow(CE);title('Cavité Est');
    subplot(2,3,3),imshow(CW);title('Cavité West');
    subplot(2,3,4),imshow(CS);title('Cavité Sud');
    subplot(2,3,5),imshow(CN);title('Cavité Nord');
    subplot(2,3,6),imshow(CC);title('Cavité Centrale');    
    set(gcf,'Position',[1 31 1024 666]);
end


X = ones (size(img));   %noir
X(find(img>0))=2;       %gris
X(find(CE>0))= 3;       % rouge
X(find(CW>0))= 4;       %vert
X(find(CS>0))= 5;       %bleu
X(find(CN>0))= 6;       %jaune
X(find(CC>0))= 7;       %violet

map = [0 0 0 ;0.7 0.7 0.7; 1 0 0;0 1 0;0 0 1;1 1 0;1 0 1];

%% Extraction des paramètres
% param = zeros(5,1);
surfCE = sum(sum(CE));
surfCW = sum(sum(CW));
surfCS = sum(sum(CS));
surfCN = sum(sum(CN));
surfCC = sum(sum(CC));
surf = surfCE+surfCW+surfCS+surfCN+surfCC;
param = [surfCE surfCW surfCS surfCN surfCC]'/surf;

if affich
   disp 'Image des cavités trouvées'                
   figure,imshow(X,map);
   title(sprintf('surfCE =%1.2f surfCW=%1.2f surfCS=%1.2f surfCN= %1.2f surfCC= %1.2f',param(1),param(2),param(3),param(4),param(5)));
   set(gcf,'Position',[1 31 1024 666]);
   pause
   close all
end
