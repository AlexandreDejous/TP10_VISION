%--------------------------------------------------------------------------------------
%
%	Florence ROSSANT
%	ISEP - Laboratoire Télécoms Signaux Images
%
%	TD5, EXO 1 : Classification de la base de test : affichage dess erreurs
%	             sur les images
%	
%	Création:      28.10.2003
%	Modification : 28.10.2003
%
%--------------------------------------------------------------------------------------
function [I3,I4,I5]=TraceRes(x,classe,resultat,TestPos,I3,I4,I5)

if (classe==3)
    [H,W] = size(I3);
    for k=1:resultat
        for i=TestPos(1,x)+8*k:TestPos(1,x)+4+8*k
            for j=TestPos(2,x)-8:TestPos(2,x)-4
                if i>0 && i<=H && j>0 && j<=W
                    I3(i,j)=1;
                end
            end
        end
    end
end
if (classe==4)
    for k=1:resultat
        for i=TestPos(1,x)+8*k:TestPos(1,x)+4+8*k
            for j=TestPos(2,x)-8:TestPos(2,x)-4
                I4(i,j)=1;
            end
        end
    end
end
if (classe==5)
   for k=1:resultat
      for i=TestPos(1,x)+8*k:TestPos(1,x)+4+8*k
         for j=TestPos(2,x)-8:TestPos(2,x)-4
            I5(i,j)=1;
         end
      end
   end
end


