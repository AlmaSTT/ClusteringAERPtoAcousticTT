
function ERPrange=RangeERP(ERP,ITC,COHS)
%Alma Socorro Torres Torres
%Función que tiene como entrada ERP, ITC con tamaño n x m x fs y COEH con un tamaño de n x m, donde 'n' corresponde
%al número de sujetos, 'm' al número de canales y 'fs' a la frecuencia de
%muestreo. Teniendo como salida una matriz con las mismas dimensiones, que
%correspinden a los valores que sobrepasan el humbral del ITC.
[m,n,fs]=size(ERP);
%ERPrange=zeros(m,n,fs);
for i=1:m
     for j=1:n
         for k=1:fs-1
     ITC_value= ITC(i,j,k);                               %Obteniendo los valores de ITC1 para PACIENTE m Y CANAL n
     if ITC_value > COHS(i,j)                               %Si los valores en ITC1 > cohe1...
         ERPrange(i,j,k) =(ITC(i,j,k)/COHS)* ERP(i,j,k);                        %guardar ese valor en un vector ITC1 nuevo... 
     else                                                 %de lo contrario...
         ERPrange(i,j,k) =ITC(i,j,k)*ERP(i,j,k) ;                                 %agregar un NaN al nuevo vector ITC1.
     end
         end
     end
end
   %ERPrange=ERPrange(:,:,1:round(0.650*fs));       
end