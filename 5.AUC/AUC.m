aucs1=reshape(abs(trapz(GA1,2)),1,16)';
aucs4=reshape(abs(trapz(GA4,2)),1,16)';
AUCd=abs(aucs1-aucs4)/10;
[AUCm,AUCch]=max(AUCd');
AUCm=AUCm';
AUCch=AUCch';
