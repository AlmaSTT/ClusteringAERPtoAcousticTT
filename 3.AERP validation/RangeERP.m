function ERPrange=RangeERP(ERP,ITC,COHS)
%%
%Function that has as input ERP, ITC with size n x m x fs and COEH with a size of n x m, where 'n' corresponds
%to the number of subjects, ’m' to the number of channels and 'fs' to the frequency of
%sampling. Having as an output a matrix with the same dimensions, which
%correct to values that exceed the humbral of the ITC.
%by AlmaSTT
[m,n,fs]=size(ERP);
ERPrange=zeros(m,n,fs);
for i=1:m
     for j=1:n
         for k=1:fs-1
     ITC_value= ITC(i,j,k);                               
     if ITC_value > COHS(i,j)                               
         ERPrange(i,j,k) =(ITC(i,j,k)/COHS)* ERP(i,j,k);           E            
     else                                                 
         ERPrange(i,j,k) =ITC(i,j,k)*ERP(i,j,k) ;                                
     end
         end
     end
end      
end
