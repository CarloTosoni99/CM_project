function [D,E,b,c] = read_from_file()

myDir = uigetdir;
disp(myDir);
myFiles = dir(fullfile(myDir,'*.csv'));
for k = 1:length(myFiles)
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    
    if baseFileName == 'b.csv'
        disp('b');
        b = readmatrix(fullFileName);
    end
    if baseFileName == 'c.csv'
        disp('c');
        c = readmatrix(fullFileName);
    end

    if baseFileName == 'D.csv'
        disp('D');
        wholeMatrix = readmatrix(fullFileName);
        m = length(wholeMatrix(:,1));
        D = sparse(1:m,1:m,wholeMatrix(:,3),m,m);
    end
    if baseFileName == 'E.csv'
        disp('E');
        wholeMatrix = readmatrix(fullFileName);
        m = length(wholeMatrix(:,1));
        E = sparse(wholeMatrix(:,1),wholeMatrix(:,2),wholeMatrix(:,3),m,m);
    end
end