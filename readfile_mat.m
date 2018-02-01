function [allNames] = readfile_mat(FolderName)

    allFiles = dir([FolderName '\*.mat']);
    allNames = {allFiles.name};
end


