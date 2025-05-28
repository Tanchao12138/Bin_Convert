
% file for save results    
fp=fopen(savefile,'w+');

fprintf(fp,'// Start Time: Unknown\n');
fprintf(fp,'// Update Rate: xxx\n');
fprintf(fp,'// ZJUT MPU6500 \n');
fprintf(fp,'// Baudrate 115200 \n');
fprintf(fp,'// Firmware Version: xxx\n');
fprintf(fp,'PacketCounter	Acc_X	Acc_Y	Acc_Z	Gyr_X	Gyr_Y	Gyr_Z\n');
    
fid = fopen(openfile,'rb');
while ~feof(fid)
    Header1 = fread(fid,1,'uint8');
    if Header1 == 250
        Header2 = fread(fid,1,'uint8');
            if Header2 == 255
                pktID = fread(fid,1,'single'); % skip three byte到四元数,默认为小端模式，这时要改成大端模式
                acc = fread(fid,3,'int16');  % read accdata  
                gyro = fread(fid,3,'single');% read gyro data
                fprintf(fp,'%.1f\t%d\t%d\t%d\t%.6f\t%.6f\t%.6f\n',...
                pktID,acc(1),acc(2),acc(3),gyro(1),gyro(2),gyro(3));
            end
     
    end   
end
fclose(fid);
fclose(fp);


