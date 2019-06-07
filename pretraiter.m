%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - Laboratoire Télécoms Signaux Images
%
%	TD9, EXO 1 : Analyse de chiffres manuscrits par la méthode des cavités
%	(G.Burel)
%	
%   function x= pretraiter(x)
%
%	Modification : 04.04.2012
%
%--------------------------------------------------------------------------------------

% Prétraiter l'image

function z = pretraiter(x0)

%% Prendre le négatif de l'image
x = ~x0;

%% Combler les trous
x = bwfill( x,'holes');

%% supprimer les petits points par une ouverture par reconstruction

SE = [0 1 0; 1 1 1; 0 1 0];
N = 3;
y = x;
for i = 1:N
    y = imerode(y,SE);      % eroder les petits objets
end

change = 1;
old_y = y;
while change 
    y = imdilate(y,SE)&x;
    change = sum(sum(old_y ~= y));
    old_y = y;
end


%% Reconnecter les chiffres par une fermeture 
SE = strel('disk',5);
z = imclose(y,SE);
