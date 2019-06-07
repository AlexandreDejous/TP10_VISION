%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - Laboratoire Télécoms Signaux Images
%
%	TD5, EXO 3 : Constitution de la base d'apprentissage
%                  et de la base de test
%	(G.Burel)
%	
%	Modification : 26.05.2010
%
%--------------------------------------------------------------------------------------
close all
clear all
disp 'Mettre en forme les bases d''apprentissage et de test'
nbclasses = 3;
firstclass = 3;

LearnIn = [];
LearnOut = [];
LearnClass = [];
LearnPos = [];
TestIn = [];
TestOut = [];
TestClass = [];
TestPos = [];

for n=firstclass:firstclass+nbclasses-1
    code = -ones(nbclasses,1);
    code(1+n-firstclass)=1;
    % apprentissage
    nom = sprintf('param%de1',n);
    load(nom)
    nom = sprintf('pos%de1',n);
    load(nom)
    [nbparam,nbex] = size(param);
    LearnIn = [LearnIn param];
    LearnOut = [LearnOut code*ones(1,nbex)];
    LearnClass = [LearnClass n*ones(1,nbex)];
    LearnPos = [LearnPos pos'];
    %test
    nom = sprintf('param%de2',n);
    load(nom)
    nom = sprintf('pos%de2',n);
    load(nom)
    [nbparam,nbex] = size(param);
    TestIn = [TestIn param];
    TestOut = [TestOut code*ones(1,nbex)];
    TestClass = [TestClass n*ones(1,nbex)];
    TestPos = [TestPos pos'];
end;
% Sauvegarde
save bases LearnIn LearnOut LearnClass LearnPos TestIn TestOut TestClass TestPos
disp 'Fin de constitution des bases d''apprentissage et de test'
disp '-->Fichier bases.mat'

    
    