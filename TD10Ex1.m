%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - SITe
%
%	TD10, EXO 1 : Calcul de corr�lation
%	
%	Modification : 06-04-2012
%
%--------------------------------------------------------------------------------------
%%
close all
clear all
clc

%% Charger l'image � analyser et labelliser
im = imread('chiffres2.tif', 'tif');
f1 = figure; subplot(2,1,1),imshow(im), title('Image source');
[H,W] = size(im);

%% Charger une image r�f�rence
% ref = imread('8.tif','tif');
% ref = 0.7*imread('8.tif','tif');
% ref = imread('8n.tif','tif');
ref = imread('8b.tif','tif');
[H1,W1] = size(ref);
figure,imshow(ref), title('Image de r�f�rence (8)');

% position du centre de l'image
x0 = round(H1/2);
y0 = round(W1/2);

%% Effectuer la corr�lation sur toute l'image test�e
% et cr�er une image de corr�lation 
rescorr = zeros(H,W);
i0 = round(H1/2);
j0 = round(W1/2);
for i=1:H-H1
   for j=1:W-W1
      c = corr2(ref,-- A REMPLIR );     
      rescorr(-- A REMPLIR,-- A REMPLIR) = c;         
   end;
end;

%% Afficher le r�sultat
figure(f1)
subplot(2,1,2),imshow(rescorr), title('Image de correlation (8)');
impixelinfo
maxi=max(rescorr(:));
mini= min(rescorr(:));
disp('R�sultats de corr�lation');
[indx,indy] = find(rescorr==maxi);
disp(sprintf('Maximum : %2.4f en :',maxi));
for k=1:length(indx), disp(sprintf('         -->  [%d,%d]',indx(k),indy(k)));end
[indx,indy] = find(rescorr==mini);
disp(sprintf('Minimum : %2.4f en :',mini));
for k=1:length(indx), disp(sprintf('         -->  [%d,%d]',indx(k),indy(k)));end

