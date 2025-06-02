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
    MPU6500 = 0;
    ICM42688 = 0;
    BMI088 = 0;    
    SR_100 = 0;
    SR_200 = 0;
    SR_400 = 0;

    file = char(fileNames(i));

    IMU_type = "MPU6500";
    whether = any(contains(file, IMU_type));
    if whether == 1
        MPU6500 = 1;
    end

    IMU_type = "ICM42688";
    whether = any(contains(file, IMU_type));
    if whether == 1
        ICM42688 = 1;
    end

    IMU_type = "BMI088";
    whether = any(contains(file, IMU_type));
    if whether == 1
        BMI088 = 1;
    end

    SR = "100Hz";
    whether = any(contains(file, SR));
    if whether == 1
        SR_100 = 1;
    end

    SR = "200Hz";
    whether = any(contains(file, SR));
    if whether == 1
        SR_200 = 1;
    end

    SR = "400Hz";
    whether = any(contains(file, SR));
    if whether == 1
        SR_400 = 1;
    end

    openfile = ['IMUConvertDir\',file];

	sfile = strrep(file,'data',[timestamp1,'_']);
    savefile = ['IMUConvertDir\ZJUT_',sfile];
	
    run Key_Convert;
    fprintf([file,' converted\n']); 
end

fprintf('All file are converted\n');
