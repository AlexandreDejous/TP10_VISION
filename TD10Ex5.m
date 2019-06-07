%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - Laboratoire Télécoms Signaux Images
%
%	TD10, EXO 5 : Classification des altérations musicales: approche
%	bayesienne
%
%
%--------------------------------------------------------------------------------------
close all
clear all
warning('OFF', 'all')
clc


%% Définir les bases d'apprentissage et de test
% On prend les 34 premières images de chaque classe en apprentissage
nbLearn     = 34;
nbImages    = 100;         % Par classe
nbTest      = nbImages-nbLearn;
indexLearn  = 1:nbLearn;
indexTest   = nbLearn+1:nbImages;

% Définir les symboles et les chemins
nbClasses   = 3;
Classes = {'BEM','BEC','DIE'};

% Définirn le répertoire de la base de données
pathDir     = 'OMR';

%% Calculer les vecteurs d'attributs sur toute la base
BD = cell(1,nbClasses);
nbFeatures = 7;
BD{1} = zeros(nbFeatures,nbImages);            % Pour les bémols
BD{2} = zeros(nbFeatures,nbImages);            % Pour les bécarres
BD{3} = zeros(nbFeatures,nbImages);            % Pour les dieses

H = 175; W = 101;   % Dimensions des images
for k = 1:nbClasses
    for i = 1:nbImages
        I = im2double(imread([pathDir filesep Classes{k} filesep myNum2str(i) '.png']));
        imshow(I);
        
        % Calculer les moments d'ordre 0 et 1 et le centre de gravité
        m00 = --REMPLIR
        m01 = --REMPLIR
        m10 = --REMPLIR
        x0 = --REMPLIR
        y0 = --REMPLIR
        
        % En déduire les moments centrés
        mu00 = --REMPLIR
        mu11 = --REMPLIR 
        mu20 = --REMPLIR
        mu02 = --REMPLIR
        mu21 = --REMPLIR
        mu12 = --REMPLIR
        mu30 = --REMPLIR
        mu03 = --REMPLIR
        
       % En déduire les moments centrés normés d'ordre 2 et 3      
        n11 = --REMPLIR 
        n20 = --REMPLIR
        n02 = --REMPLIR
        n30 = --REMPLIR
        n03 = --REMPLIR
        n21 = --REMPLIR;
        n12 = --REMPLIR
        
        % Stocker
        BD{k}(:,i) = [n02;n11;n20;n30;n21;n12;n03];
    end
end
save 'BD_OMR' 'BD'

load 'BD_OMR'





%% Apprentissage des probabilités des classes
M       = 3;                % Nombre de classes
classes = [1 2 3];

% % Pour sélectionner une sous-partie des attributs
% for k =1:M
%     BD{k} = BD{k}([1 2],:);
% end

N       = size(BD{1},1);  % Dimension des vecteurs d'attributs

% Afficher les valeurs des attributs
hold off
color = {'r','g','b'};
for n = 1:N
    subplot(1,N,n);hold on
    for k = 1:M
        plot(k*ones(1,nbLearn), BD{k}(n,1:nbLearn),'.');
    end
    ax = axis; ax(1) = 0.5; ax(2) = 3.5; axis(ax);
end

% Apprendre les probabilités des classes : on suppose les classes
% equiprobables- P(k) represente la probabilité de la classe k
P = 1/M*ones(1,M);

% Apprendre les paramètres des densités de probabilité
Vm      = cell(1,M);        % Vecteurs moyenne
C       = cell(1,M);      	% Matrices de covariance
Cinv    = cell(1,M);        % Inverse de la matrice de covariance
D       = zeros(1,M);       % Déterminants de la matrice de covariance

for k = 1:M
    ind     = 1:nbLearn;                                % Indices des prototypes de la classe Ck qui servent à l'apprentissage
    Vm{k}    = mean(BD{k}(:,ind),2);                   % Vecteur moyenne
    C{k}    = zeros(N,N);                             % Matrice de covariance
    for q = 1:length(ind)
        i = ind(q);             % Indice du prototype de la classe k
        C{k} = C{k} + (BD{k}(:,i)-Vm{k})*(BD{k}(:,i)-Vm{k})';
    end
    C{k} = C{k} / length(ind);
    Cinv{k} = inv(C{k});
    D(k) = det(C{k});
end


%% initialiser le taux d'erreurs et la matrice de confusion
nb_erreurs=0;
conf = zeros(3,3);

%% Classification des chiffres de la base de test par la méthode bayesienne
for x = nbLearn+1:nbImages                                % double boucle sur les symboles
    for k_true = 1:M
        % Calculer les probabilités p(x|Ck)
        p = zeros(1,M);

        for k = 1:M    
            p(k) = 1/(2*pi)^(N/2)/sqrt(D(k)) * exp(-(BD{k_true}(:,x)-Vm{k})'/C{k}*(BD{k_true}(:,x)-Vm{k}));
        end
        % En déduire la classe correspondant au max de la probabilité à postériori
        [~,k] = -- REMPLIR
        
    
        % -- A REMPLIR classe correspondante du plus proche voisin
        nb_erreurs = nb_erreurs+(k~=k_true);     % compter le nombre d'erreurs de classification
        conf(--REMPLIR)=conf(--REMPLIR)+1;        % matrice de confusion
        
        if (k~=k_true)
            fprintf('\nERREUR image %d de la classe %s: classé en %s',x,Classes{k_true},Classes{k});
        end
    end
end
fprintf('\n');

%% Afficher les résultats
disp('RESULTATS DE CLASSIFICATION PAR L''APPROCHE BAYESIENNE');
disp (sprintf('\nTaux d''erreurs   = %f %%',100*nb_erreurs/(nbImages-nbLearn)/M));
disp (sprintf('\nTaux de réusssite = %f %%',100*(1-nb_erreurs/(nbImages-nbLearn)/M)));
disp (sprintf('\nMatrice de confusion, en (i,j) le nombre de chiffres i classés en j:\n'))
for i=1:3
    disp (sprintf('        %2d   %2d   %2d',conf(i,1),conf(i,2),conf(i,3)))
end
