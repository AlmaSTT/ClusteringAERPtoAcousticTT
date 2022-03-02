
 %% Tecnologico de Monterrey - Campus Monterrey
% PROYECTO: Tinnitus-EEG
% Author: Luz Maria Alonso Valerdi
% Title: Analisis of Auditory Event Related Potentials
% Type of file: PASSIVE
% Date: 06 December 2017
% -------------------------------------------------------------------------
% *****Signal Analysis PART I*****:
% -- raw file
% (1) Load GDF-file
% (2) Load channel-location
% (3) Remove baseline
% -- dsp file
% (4) Filtering: 0.1-100Hz
% (5) Notch filtering @ 60Hz
% (6) Renaming repeated events
% (7) Remove discontinuties (MANUALLY)
% (8) Identification of pop-up electrodes
% *****Signal Analysis PART II*****:
% -- ica file 
% (1) High-pass filtering at 1hz
% (2) Run ICA on 1hz-file without pop-up electrodes
% -- dsp2 file (for traditional method)
% (3) Paste ICA on dsp-file
% -- wica file (new method)
% (4) Run wICA on ica-file
%     and construct artifacts = A*wIC
% (5) By using dsp-file, obtain wica = dsp - artifacts
% -- erp file
% (6) Epoch data by using only EVENT NUMBER 2
% (7) Plot ERPs to validate analysis
% -- final steps
% (8) Save as mat-files for further processing
% (9) Plot ERPs and save figures
% (10)If ERPs are not high quality, remove artifacts from dsp2 and create
%     erp2 (new method)
% -------------------------------------------------------------------------
%% *****Signal Analysis PART I*****:
% update depending on the PC in use
% addpath('C:\LMAV\Matlab_GralFunctions')
% addpath('C:\LMAV\Matlab_GralFunctions\FastICA')
path = 'C:\Users\coco1\Documents\Investigación\AERP';
pathc='C:\Users\coco1\Documents\Investigación\AERP';
gr = {'Placebo','Binaural','TRT','EAE','ADT','Control'};
%

for g =1:length(gr)
    pathg=[pathc '\' gr{g} ];
    for ss = 1:4
        paths=[pathg '\S' num2str(ss) ];
        Ld=Get_List(paths,'*.gdf');
        for p = 1:length(Ld)
            G = num2str(g); P =replace(Ld{p},'passivo.gdf',''); SS = num2str(ss);
            disp([G P SS])
            filepath = [paths '\' Ld{p}];
            mkdir(paths,['\' replace(Ld{p},'passivo.gdf','') SS])
            outpath = [paths '\' replace(Ld{p},'passivo.gdf','') SS '\'];
            if exist(filepath, 'file')  
                % (1)gdf-file/(2)channel-location/(3)baseline
                EEGr = pop_biosig(filepath);
                EEGr.chanlocs = readlocs([path '\16ch_tinnitus.txt'], 'filetype', 'besa');
                EEGr.data = rmbase(EEGr.data);
                EEGr.setname = ['G' G '.' P '_pasivo' SS 'raw'];
                EEGf = pop_saveset(EEGr, 'filename', ['pasivo' SS 'raw'], 'filepath', outpath); 
                % Filtering: 
                % (4) 0.1-100Hz 
%                 EEGf = EEGr;                     
%                 d = designfilt('bandpassiir','FilterOrder',8, ...
%                 'HalfPowerFrequency1',0.1,'HalfPowerFrequency2',100, ...
%                 'DesignMethod','butter','SampleRate',EEGf.srate);                
%                 EEGf.data = single(filtfilt(d, double(EEGf.data')))';           
%                 % and (5) notch@60Hz
%                 d = designfilt('bandstopiir','FilterOrder',2, ...
%                'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
%                'DesignMethod','butter','SampleRate',EEGf.srate);
%                 EEGf.data = single(filtfilt(d, double(EEGf.data')))'; 
                % and (5) remove 60Hz PREP
               % EEGf= cleanLineNoise(EEGf);
                % (6)Rename events
                EEGf = RenameStim(EEGf, [1,2,3]);
                EEGf.setname = ['G' G '.' replace(Ld{p},'passivo.gdf','') '_pasivo' SS 'dsp'];
                EEGf =clean_artifacts(EEGf);
                EEGf = pop_saveset(EEGf, 'filename', ['pasivo' SS 'dsp'], 'filepath', outpath); 
                % (7)Remove discontinuities manually
                % (8)Identify pop-up electrodes       
                %    -Go to Edit>>About this dataset
                %    -Insert in the third line the numbers of channels
                %     identified as pop-ups seperated by commas
                %     (e.g. 1,2,3)
%             end
%         end
%     end
% end
% 
% %% *****Signal Analysis PART II*****:
% % % update depending on the PC in use
% % addpath('C:\LMAV\Matlab_GralFunctions')
% % addpath('C:\LMAV\Matlab_GralFunctions\FastICA')
% % path = 'C:\LMAV\TiNNiTuS\EEGLAB\'; 
% timelimits = [-0.2 0.8];
% pathc='C:\Users\coco1\Documents\Investigación\AERP';
% gr = {'Placebo','Binaural','TRT','EAE','ADT','Control'};
% %=Get_List(pathd,'*.gdf');
% 
% for g =2:3
%     Gl=[1,5,6];
%     pathg=[pathc '\' gr{Gl(g)} ];
%     for ss = 1:4
%         paths=[pathg '\S' num2str(ss)];
%         Ld=Get_List(paths,'*.gdf');
%         for p = 1:length(Ld)
%             G = num2str(Gl(g)); P = replace(Ld{p},'passivo.gdf',''); SS = num2str(ss);
%             disp([G P SS])
%             filepath = [paths '\' Ld{p}];
%             outpath = [paths '\' replace(Ld{p},'passivo.gdf','') SS '\'];
%             filename = ['pasivo' SS 'dsp.set'];
%            % if exist([outpath filename], 'file')  
%                 % (0)dsp-file & pop-up electrodes
%                 popups = [];
%                 EEGf = pop_loadset('filename', filename, 'filepath', outpath);
                timelimits = [-0.2 0.8];
                if size(EEGf.comments,1) == 3
                    popups = str2double(EEGf.comments(3,:));
                end    
                % (1)High-pass filtering @ 1hz
                EEGica = EEGf;
                d = designfilt('highpassiir','FilterOrder',8, ...
               'HalfPowerFrequency',1, ...
               'DesignMethod','butter','SampleRate',EEGf.srate);
                EEGf.data = single(filtfilt(d, double(EEGf.data')))';                 
                % (2)Run ICA withou pop-up electrodes if the case
                channs = 1:EEGica.nbchan;
%                 channs(popups) = [];
                EEGica = pop_runica(EEGica,'extended', 1,'chanind',channs);
                EEGica.setname = ['G' G '.' P '_pasivo' SS 'ica'];
                EEGica = pop_saveset(EEGica, 'filename', ['pasivo' SS 'ica'], 'filepath', outpath); 
                % (3)Import weights in dsp2-file
                EEGf.icawinv = EEGica.icawinv;
                EEGf.icasphere = EEGica.icasphere;
                EEGf.icaweights = EEGica.icaweights;
                EEGf.icachansind = EEGica.icachansind;
                EEGf.setname = ['G' G '.' P '_pasivo' SS 'dsp2'];
                EEGf = pop_saveset(EEGf, 'filename', ['pasivo' SS 'dsp2'], 'filepath', outpath); 
                % (4)Run wICA on dsp2-file @0.1Hz                
                [wIC,A,W,IC] = wICA(EEGf.data(channs,:), [], 1, 0, EEGf.srate);
                artifacts = A*wIC; 
                % (5)Remove artifacts from dsp2 @0.1Hz
                EEGwica = EEGf;
                EEGwica.data(channs,:) = EEGf.data(channs,:)-artifacts;
                EEGwica.setname = ['G' G '.' P '_pasivo' SS 'wica'];
                EEGwica = pop_saveset(EEGwica, 'filename', ['pasivo' SS 'wica'], 'filepath', outpath);
                % (6)Epoch using event "2"-->onset            
                EEGerp = pop_epoch(EEGwica, {'2'}, timelimits);
                EEGerp.data = rmbase(EEGerp.data, size(EEGerp.data,2), 1:round(abs(timelimits(1))*EEGerp.srate));
                EEGerp.setname = ['G' G '.' P '_onset' SS];
                EEGerp = pop_saveset(EEGerp, 'filename', ['onset' SS], 'filepath', outpath);
                    % (7)Plot ERPs and save
                erp = mean(EEGerp.data,3);                
                erp = erp(channs,:);
                 figure
                plotdata(erp,0,...
                    [timelimits(1)*1000 timelimits(2)*1000 double(min(min(erp))) double(max(max(erp)))],...
                    'Event-Related Potentials',EEGerp.chanlocs(channs));
               grid on
               saveas(gcf, [outpath 'erpA' P SS '.fig']) 
               saveas(gcf, [outpath 'erpA' P SS '.png']) 
                figure
                timtopo(erp,EEGerp.chanlocs(channs),...
                    [timelimits(1)*1000 timelimits(2)*1000 double(min(min(erp))) double(max(max(erp)))],...
                    [100 200 300 400],'Event-Related Potentials');
               grid on
              saveas(gcf, [outpath 'erpB' P SS '.fig'])  
              saveas(gcf, [outpath 'erpB' P SS '.png']) 
                % (8) save mat-files in continous mode and epochs 
                continous = EEGf.data; epochs = EEGerp.data; 
                save([outpath 'G' G '.' replace(Ld{p},'passivo.gdf','') SS 'cont.mat'],'continous');
                save([outpath 'G' G '.' replace(Ld{p},'passivo.gdf','') SS 'epoch.mat'],'epochs'); 
                close all
            end
        end
    end
end
%%