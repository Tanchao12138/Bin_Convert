
% file for save results    
fp=fopen(savefile,'w+');

fprintf(fp,'// Start Time: Unknown\n');

if SR_100 == 1
    fprintf(fp,'// Sampling Rate: 100Hz\n');
elseif SR_200 == 1
    fprintf(fp,'// Sampling Rate: 200Hz\n');
elseif SR_400 == 1
    fprintf(fp,'// Sampling Rate: 400Hz\n');
end

if MPU6500 == 1
    fprintf(fp,'// MPU6500 \n');
elseif ICM42688 == 1
    fprintf(fp,'// ICM42688 \n');
elseif BMI088 == 1
    fprintf(fp,'// BMI088 \n');
end

fprintf(fp,'Timestamp	Acc_X	Acc_Y	Acc_Z	Gyr_X	Gyr_Y	Gyr_Z\n');
    
fid = fopen(openfile,'rb');
while ~feof(fid)
    Header1 = fread(fid,1,'uint8');
    if Header1 == 250
        Header2 = fread(fid,1,'uint8');
            if Header2 == 255
                pktID = fread(fid,1,'single'); 
                acc = fread(fid,3,'single');  % read acc data  
                gyro = fread(fid,3,'single');% read gyro data
                fprintf(fp,'%.1f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\n',...
                pktID,acc(1),acc(2),acc(3),gyro(1),gyro(2),gyro(3));
            end
     
    end   
end
fclose(fid);
fclose(fp);


