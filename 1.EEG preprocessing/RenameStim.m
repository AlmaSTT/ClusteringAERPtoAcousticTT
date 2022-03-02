function [EEGout] = RenameStim(EEGin, new_events)

% --- Variable Declaration ---
EEGout = EEGin;
events = EEGin.event;

% --- Renaming events ---
for e = 1:length(new_events):length(events)
    new = new_events;
    for i = 0:length(new_events)-1
        events(e+i).type = new(1); 
        new(1) = [];
    end   
end
EEGout.event = events;

end