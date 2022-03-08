function [ERP,ERSP,ITC,COHS]=MainITC(EEGfile,afs,tf,ti)
%%
%Function to generate ERP,ERSP,ITC,COHS a subject per EEG channel
% Input:  
% EEGfile   -   m x n x s
%            m  - number of ephocs 
%            n  - EEG channels
%            s  - samples of individual epoch
% afs       -  Hz
%            Individual alpha frecuency 
% ti,tf     -  ms
%           initial and final time of an ephoc
% Output: 
% ERP - n x s
%            n  - EEG channels
%            s - samples of individual epoch
%by AlmaSTT
    EEG=pop_loadset(EEGfile);
    [m,~,~]=size(EEG.data); 
    for j=1:m
    [~,~,~,~,~,a,b,c,d]=erpimage(EEG.data(j,:,:),[],...
        -ti+1:1000/EEG.srate:tf-1,'ERP image',1,1,'srate',EEG.srate,...
        'coher',[afs afs 0.1], 'erp','on');
 
    ERP(pr,j,:)=a;
    ERSP(pr,j,:)=b;
    ITC(pr,j,:)=c;
    COHS(pr,j)=d;
    end
    end
    
