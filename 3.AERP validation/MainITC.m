%%% Main ITC
%Alma Socorro Torres Torres
%Carpetas
pathc = 'C:\Users\coco1\Documents\Investigación\AERP';
%Grupo por carpeta
gr = {'Music','BBT','TRT','TEAE','ADT','Control'};
fs=importdata('fs.mat');
ch=load('ch16.mat');
fs(fs==0)=10;
fs=cat(2,fs,10*ones(6,1));
for g =6:length(gr)
    pathg=[pathc '\' gr{g} ];
    for ss = 1:4
        paths=[pathg '\S' num2str(ss) ];
        Ld=Get_List(paths,'*.gdf');
         ERP=NaN(length(Ld),16,256);
         ERSP=NaN(length(Ld),16,256);
         ITC=NaN(length(Ld),16,256);
         COHS=NaN(length(Ld),16);
        for p = 1:length(Ld)
           G = num2str(g); P =replace(Ld{p},'.passivo.gdf',''); 
           SS = num2str(ss);
           pr=str2double(replace(P,'P',''));
           file=[paths '\' P,'.'...
             SS '\onset' SS,'.set'];
%Inicializar datos
     % h=gobjects(16,1);
%Cargar archivos de ERP
    EEG=pop_loadset(file);
    EEG=pop_resample(EEG,256);
         [m,n,l]=size(EEG.data); 
    for j=1:m
    Title=strcat(gr{g}, ' S', SS,' ',P,{' '},'Canal',{' '},EEG.chanlocs(j).labels);
    h(j)=figure;
    [~,~,~,~,~,a,b,c,d]=erpimage(EEG.data(j,:,:),[],...
        -199:1000/EEG.srate:799,Title,1,1,'srate',EEG.srate,...
        'coher',[fs(g,pr) fs(g,pr) 0.1], 'erp','on');
   com=strcmp(ch.ch_16,EEG.chanlocs(j).labels);
    chf=find(com);
%          if(EEG.srate==512)
%              i=1:m;
%         a=resample(double(a),1,2);
%         b=resample(double(b),1,2);
%         c=resample(double(c),1,2);
%          end
  
    ERP(pr,chf,:)=a;
    ERSP(pr,chf,:)=b;
    ITC(pr,chf,:)=c;
    COHS(pr,chf)=d;
    end
   % filename=strcat('FIG.',P,'.',gr{g},'.S',SS,'.fig');
   % savefig(h,filename)
    close all
        end

    %guerdar archivos por sesión
    save([paths,'\ERP.',gr{g},'.S',SS,'.mat'],'ERP');
    save([paths,'\ERSP.',gr{g},'.S',SS,'.mat'],'ERSP');
    save([paths,'\ITC.',gr{g},'.S',SS,'.mat'],'ITC');
    save([paths,'\COHS.',gr{g},'.S',SS,'.mat'],'COHS');
    end
end

