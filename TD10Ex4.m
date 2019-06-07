%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - Laboratoire T�l�coms Signaux Images
%
%	TD10, EXO 4 : Classification de la base de test
%	             Doit etre lanc� apr�s base.m qui produit le fichier
%	             bases.mat
%
%                Utilise la fonction TraceRes.m pour l'affichage graphique
%                des r�sultats de classification
%
%	Cr�ation : 30-05-2017
%
%--------------------------------------------------------------------------------------
close all
clear all
warning('OFF', 'all')
clc
load 'winpos.mat'

%% Charger les bases d'apprentissage et de test
load bases

%% Apprentissage 
M       = 3;                % Nombre de classes
classes = [3 4 5];
N       = size(LearnIn,1);  % Dimension des vecteurs d'attributs

% Apprendre les probabilt�s des classes : on suppose les classes
% equiprobables- P(k) represente la probabilit� de la classe k
P = 1/M*ones(1,M);

% Apprendre les param�tres des densit�s de probabilit�
Vm      = cell(1,M);        % Vecteurs moyenne
C       = cell(1,M);      	% Matrices de covariance
Cinv    = cell(1,M);        % Inverse de la matrice de covariance
D       = zeros(1,M);       % D�terminants de la matrice de covariance

for k = 1:M %pour chaque classe 
    ind     = find(LearnClass == classes(k));            % Indices des prototypes de la classe Ck
    Vm{k}   = mean(LearnIn(:,ind),2);              % Vecteur moyenne
    C{k}    = zeros(N,N);                 % Matrice de covariance
    for q = 1:length(ind)
        i = ind(q);             % Indice du prototype de la classe k
        C{k} = C{k} + (LearnIn(:,i)-Vm{k})*(LearnIn(:,i)-Vm{k})';
    end
    C{k} = C{k} / length(ind);
    Cinv{k} = inv(C{k});
    D(k)    = det(C{k});
end


%% initialiser le taux d'erreurs et la matrice de confusion
nb_erreurs=0;
conf = zeros(3,3);

%% Pr�traiter les images test�es
I3 = pretraiter(imread('3e2.tif'));id3 = figure;imshow(I3);
I4 = pretraiter(imread('4e2.tif'));id4 = figure;imshow(I4);
I5 = pretraiter(imread('5e2.tif'));id5 = figure;imshow(I5);

%% Chargement des images de cavit� - pour affichage
[ci3,map]   = imread('cav3e2.tif');ci3a = imread('cav3e1.tif');
ci4         = imread('cav4e2.tif');ci4a = imread('cav4e1.tif');
ci5         = imread('cav5e2.tif');ci5a = imread('cav5e1.tif');

%% Classification des chiffres de la base de test par la m�thode bayesienne
for x = 1:size(TestIn,2)                                % Boucle sur les chiffres test�s
    % Calculer les probabilit�s p(x|Ck)
    p = zeros(1,M);
    X = TestIn(:,x);
    for k = 1:M
            p(k) = 1/(2*pi)^(N/2)*sqrt(D(k))*exp(-(X-Vm{k})'*Cinv{k}*(X-Vm{k}))*P(k);
    end
    % En d�duire la classe correspondant au max de la probabilit� � post�riori
    [~,k] = max(p);
    Ck = classes(k);
    
    % -- A REMPLIR classe correspondante du plus proche voisin
    nb_erreurs = nb_erreurs+(Ck~=TestClass(x));     % compter le nombre d'erreurs de classification
    conf(TestClass(x)-2,Ck-2)=conf(TestClass(x)-2,Ck-2)+1;  % matrice de confusion
    % Affichage
    if (Ck~=TestClass(x))                           
        disp(sprintf('Chiffre [%3d %3d]: %d classe en %d',TestPos(1,x),TestPos(2,x),TestClass(x),Ck))
        [I3,I4,I5]=TraceRes(x,TestClass(x),Ck,TestPos,I3,I4,I5);
        [ci3,ci4,ci5]=TraceRes(x,TestClass(x),Ck,TestPos,ci3,ci4,ci5);  
    end
end

%% Afficher les r�sultats
disp('RESULTATS DE CLASSIFICATION PAR L''APPROCHE BAYESIENNE');
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

