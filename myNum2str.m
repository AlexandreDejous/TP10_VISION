function numstr = myNum2str(nb)

if nb< 10
    numstr = ['000000'  num2str(nb)] ;
elseif nb<100
    numstr = ['00000'  num2str(nb)] ;
elseif nb<1000
    numstr = ['0000'  num2str(nb)] ;  
end