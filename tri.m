function [sauve,resultat] = tri(res, nbobjets)

ordre = zeros(nbobjets,4);
tmp = res;
% trier suivant la ligne croissante
for i=1:nbobjets
	[xmini imin] = min(tmp(:,2));
   ordre(i,:)= tmp(imin,:);
   tmp(imin,2)=1000;   
end;
sauve = ordre;

% Decoupage en lignes
tmp = sauve;
ordre = zeros(nbobjets,4);
deb=1;
i = 1;
dec = 20; % decalage minimum entre 2 lignes successives
indligne = 0;
resultat = [];

while deb<nbobjets
	while i<=nbobjets &(tmp(i,2)-tmp(deb,2))<dec 
   	i = i+1;
   end;   
   tmp(deb:i-1,:);
   ligne = [];
   for j=deb:i-1 % tri sur la ligne trouvee
      [ymini jmin] = min(tmp(deb:i-1,3));      
   	ordre(j,:)= tmp(jmin+deb-1,:);
      tmp(jmin+deb-1,3)=1000;
      ligne = [ligne mod(ordre(j,1),10) ];
   end;
   
   indligne=indligne+1;
   resultat(indligne) = tab2num(ligne) ;   
   deb = i;
end;

