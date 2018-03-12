function [allNames] = readfile_txt(FolderName)

    allFiles = dir([FolderName '\*.txt']);
    allNames = {allFiles.name};
end


