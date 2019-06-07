function res = tab2num(ligne)
N = length(ligne);
res = 0.0;
for (i=1:N)
   res = res+10^(N-i-2)*ligne(i);
end;
