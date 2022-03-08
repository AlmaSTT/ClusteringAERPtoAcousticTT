%%Feature extraction per therapy
%by AlmaSTT
%1) Calculate the AUC per therapy and initial and final sesion
aucs1=ERPauc(ERPga1);
aucs4=ERPauc(ERPga4);
%2) Obtain the diference betwen initial - final sesion
AUCd=abs(aucs1-aucs4);
%3) Feature extraction of maximum value of AUC difference among channels 
% and the corresponding channel 
[AUCm,AUCch]=max(AUCd');
AUCm=AUCm';
AUCch=AUCch';
