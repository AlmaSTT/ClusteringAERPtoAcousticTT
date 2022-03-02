function GaERP=ERPga(ERP)
[~,n,fs]=size(ERP);
GaERP=zeros(n,fs);
for i=1:n
    GaERP(i,:)=reshape(mean(ERP(:,i,:),1),1,fs);
end
end