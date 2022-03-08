function AUCm=ERPauc(ERPga)
%%
%Function to obtain the area under the curve of the Grand-Average ERP per EEG channel
% Input:  
% ERPga   -   ch x s
%            ch  - EEG channels
%            s  - samples of individual epoch
% Output: 
% AUCm - n x 1
%            n  - AUC per channel
%by AlmaSTT
[m,~]=size(ERPga);
AUCm=reshape(abs(trapz(ERPga,2)),1,m)';
end


