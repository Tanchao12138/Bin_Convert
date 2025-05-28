close all;                          % close all figures
clear;                              % clear all variables
clc;                                % clear the command terminal

% For data auto convert

fileFolder=fullfile('IMUConvertDir');
dirOutput=dir(fullfile(fileFolder,'*.TXT'));
fileNames={dirOutput.name}';

t=now;
formatOut = 'yymmdd';
timestamp1 = datestr(now,formatOut);

runcycle = size(fileNames,1);

for i = 1:runcycle
    file = char(fileNames(i));
    openfile = ['IMUConvertDir\',file];

	sfile = strrep(file,'data',[timestamp1,'_']);
    savefile = ['IMUConvertDir\ZJUT_',sfile];
	
    run Key_Convert;
    fprintf([file,' converted\n']); 
end

fprintf('All file are converted\n');
