path = 'C:\Users\coco1\Documents\Investigación\AERP';
pathc='C:\Users\coco1\Documents\Investigación\AERP';
gr = {'Placebo','Binaural','TRT','EAE','ADT','Control'};
t=-199:1000/256:799;
AERPa=[];
for g =2:5
    pathg=[pathc '\' gr{g} ];
    figure(g)
    for ss = 1:4
        paths=[pathg '\S' num2str(ss) ];
        nameAERP=[paths '\AERP.' gr{g} '.S' num2str(ss) '.mat'];
        AERP=importdata(nameAERP);
        AERPauc=trapz(abs(AERP'));
        AERPa(g-1,ss,:)=AERPauc;
    end
end