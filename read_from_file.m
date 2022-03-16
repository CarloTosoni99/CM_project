function [D,E,b,c] = read_from_file()

myDir = uigetdir;
%disp(myDir);
myFiles = dir(fullfile(myDir,'*.csv'));
filesCell = struct2cell(myFiles);
reverseOrder = sortrows(filesCell(1,:));
k=4;

while k ~=0 
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    if baseFileName == 'b.csv'
        b = readmatrix(fullFileName);
        columnsE = size(b,1);
        k = k-1;
    end
    if baseFileName == 'c.csv'
        c = readmatrix(fullFileName);
        rowsE = size(c,1);
        k = k-1;
    end
    if baseFileName == 'D.csv'
        wholeMatrix = readmatrix(fullFileName);
        m = length(wholeMatrix(:,1));
        D = sparse(1:m,1:m,wholeMatrix(:,3),m,m);
        k = k-1;
    end
    if baseFileName == 'E.csv'
        wholeMatrix = readmatrix(fullFileName);
        m = length(wholeMatrix(:,1));
        E = sparse(wholeMatrix(:,1),wholeMatrix(:,2),wholeMatrix(:,3),rowsE,columnsE);
        k = k-1;
    end
end