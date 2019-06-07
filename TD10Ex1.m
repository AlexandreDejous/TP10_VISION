%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - SITe
%
%	TD10, EXO 1 : Calcul de corrélation
%	
%	Modification : 06-04-2012
%
%--------------------------------------------------------------------------------------
%%
close all
clear all
clc

%% Charger l'image à analyser et labelliser
im = imread('chiffres2.tif', 'tif');
f1 = figure; subplot(2,1,1),imshow(im), title('Image source');
[H,W] = size(im);

%% Charger une image référence
% ref = imread('8.tif','tif');
% ref = 0.7*imread('8.tif','tif');
% ref = imread('8n.tif','tif');
ref = imread('8b.tif','tif');
[H1,W1] = size(ref);
figure,imshow(ref), title('Image de référence (8)');

% position du centre de l'image
x0 = round(H1/2);
y0 = round(W1/2);

%% Effectuer la corrélation sur toute l'image testée
% et créer une image de corrélation 
rescorr = zeros(H,W);
i0 = round(H1/2);
j0 = round(W1/2);
for i=1:H-H1
   for j=1:W-W1
      c = corr2(ref,-- A REMPLIR );     
      rescorr(-- A REMPLIR,-- A REMPLIR) = c;         
   end;
end;

%% Afficher le résultat
figure(f1)
subplot(2,1,2),imshow(rescorr), title('Image de correlation (8)');
impixelinfo
maxi=max(rescorr(:));
mini= min(rescorr(:));
disp('Résultats de corrélation');
[indx,indy] = find(rescorr==maxi);
disp(sprintf('Maximum : %2.4f en :',maxi));
for k=1:length(indx), disp(sprintf('         -->  [%d,%d]',indx(k),indy(k)));end
[indx,indy] = find(rescorr==mini);
disp(sprintf('Minimum : %2.4f en :',mini));
for k=1:length(indx), disp(sprintf('         -->  [%d,%d]',indx(k),indy(k)));end

