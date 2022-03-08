function GaERP=ERPga(ERP)
%%
%Function to generate Grand-Average ERPs of a group of subjects per EEG channel
% Input:  
% ERP   -   m x n x s
%            m  - number of ephocs to be averanged betwen subjects and channels
%            n  - EEG channels
%            s  - samples of individual epoch
% Output: 
% GaERP - n x s
%            n  - EEG channels
%            s - samples of individual epoch
%by AlmaSTT
[~,n,s]=size(ERP);
GaERP=zeros(n,s);
for i=1:n
    GaERP(i,:)=reshape(mean(ERP(:,i,:),1),1,s);
end
end
