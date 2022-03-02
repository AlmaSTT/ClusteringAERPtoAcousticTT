%Enlistar documentos de una carpeta en especifico --> actual_folder, de un cierto tipo --> '*.mat'
function out = Get_List(path,type)
    list_dir=dir(fullfile(path,type));
    list_dir={list_dir.name}';
    out=list_dir;
end