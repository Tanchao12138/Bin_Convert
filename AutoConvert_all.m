close all;                          % close all figures
clear;                              % clear all variables
clc;                                % clear the command terminal

% For data auto convert

% d:\code_fan\matlab_\x-imu\open_source_debug\x-IMU-MATLAB-Library-9.1_debug\Testdatafile\
fileFolder=fullfile('YISConvertDir');
dirOutput=dir(fullfile(fileFolder,'*.TXT'));
fileNames={dirOutput.name}';

t=now;
formatOut = 'yymmdd';
timestamp1 = datestr(now,formatOut);

runcycle = size(fileNames,1);
% fprintf(fileNames(1));
% fan1 = char(fileNames(1));
% fp=fopen(fan1,'rb');

for i = 1:runcycle
    file = char(fileNames(i));
    openfile = ['YISConvertDir\',file];

	sfile = strrep(file,'G00',['G',timestamp1,'_'])	;
    savefile = ['YISConvertDir\YIS3_',sfile];
	
    run YISConvert;
    fprintf([file,' converted\n']); 
end

fprintf('YIS file are converted\n');

fileFolder=fullfile('MTiConvertDir');
dirOutput=dir(fullfile(fileFolder,'*.TXT'));
fileNames={dirOutput.name}';
runcycle = size(fileNames,1);

if 0  % 移花接木，还原成mtb文件，不好，不用了吧。

% fprintf(fileNames(1));
% fan1 = char(fileNames(1));
% fp=fopen(fan1,'rb');

% 移花接木，还原成mtb文件
for i = 1:runcycle

    file = char(fileNames(i));
    openfile = ['MTiConvertDir\',file];
    
	sfile = strrep(file,'G00',['G',timestamp1,'_']);
	sfile = strrep(sfile,'TXT','mtb');
    savefile = ['MTiConvertDir\MTi3_',sfile];
	
	fid0=fopen(savefile,'w');
	fid1=fopen('MT_2018-09-27_005_head.mtb','r');
	fid2=fopen(openfile,'r');
	head = fread(fid1);
	data = fread(fid2);
	fwrite(fid0,head);
	fwrite(fid0,data);
	fclose(fid0);
	fclose(fid1);
	fclose(fid2);
	
    fprintf([file,' resume MTB file OK \n']); 	
end

end

% 这个还是不要了吧，没有姿态不行啊。
for i = 1:runcycle
    file = char(fileNames(i));
    openfile = ['MTiConvertDir\',file];
    
	sfile = strrep(file,'G00',['G',timestamp1,'_']);
	sfile = strrep(sfile,'TXT','txt');
    savefile = ['MTiConvertDir\MTi3_',sfile];

    run MTiConvert;
    fprintf([file,' converted\n']); 
end

fprintf('MTi file are all resumed\n');

fprintf('All file are converted\n');
