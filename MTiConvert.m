
% file for save results    
fp=fopen(savefile,'w+');

fprintf(fp,'// Start Time: Unknown\n');
fprintf(fp,'// Update Rate: 100.0Hz\n');
fprintf(fp,'// XSENS MTi-3 \n');
fprintf(fp,'// Baudrate 115200 \n');
fprintf(fp,'// Firmware Version: xxx\n');
fprintf(fp,'PacketCounter	Acc_X	Acc_Y	Acc_Z	Gyr_X	Gyr_Y	Gyr_Z	Mag_X	Mag_Y	Mag_Z	Quat_q0	Quat_q1	Quat_q2	Quat_q3\n');
    
fid = fopen(openfile,'rb');
% fid = fopen('ConvertDir\ELG00050_small.TXT','rb');
while ~feof(fid)
    Header1 = fread(fid,1,'uint8');
    if Header1 == 250
        Header2 = fread(fid,1,'uint8');
        Header3 = fread(fid,1,'uint8');
        if ~isempty(Header3)  % ELG00079_org.TXT bug fix
            if Header2 == 255 && Header3 == 54 % This is the start of a frame, data length 0x49
                fseek(fid,4,'cof'); %skip two byte
                pktID = fread(fid,1,'uint16',3,'b'); % skip three byte到四元数,默认为小端模式，这时要改成大端模式
                quaternion = fread(fid,4,'single','b'); % read quaternion data
                fseek(fid,3,'cof');
                acc = fread(fid,3,'single','b');  % read accdata  
                fseek(fid,3,'cof'); % skip 3 data, cof，表示当前位置
                gyro = fread(fid,3,'single','b');% read gyro data
                fseek(fid,3,'cof'); % 
                mag = fread(fid,3,'single','b');% read mag data

                if feof(fid) % isempty(mag(3)) % 改改 feof(fid) %若文件结束，则不打印这一帧数据了。
                    break;
                end

                fprintf(fp,'%d\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\n',...
                pktID,acc(1),acc(2),acc(3),gyro(1),gyro(2),gyro(3),mag(1),mag(2),mag(3),quaternion(1),quaternion(2),quaternion(3),quaternion(4));
            else
                fseek(fid,-2,'cof'); %还得退二格，不然会错过数据的,LOG00027.TXT bug fix
            end
        end
    end   
end
fclose(fid);
fclose(fp);

% // Start Time: Unknown
% // Update Rate: 100.0Hz
% // Filter Profile: human (46.1)
% // Option Flags: AHS Disabled ICC Disabled 
% // Firmware Version: 4.3.1
% PacketCounter	Acc_X	Acc_Y	Acc_Z	Gyr_X	Gyr_Y	Gyr_Z	Mag_X	Mag_Y	Mag_Z	Quat_q0	Quat_q1	Quat_q2	Quat_q3'

% FA FF 
% 36 
% 49 总长度
% 10 20 packet counter
% 02 
% 02 6F 
% 20 10 四元数
% 10 
% 3A E7 D4 E7 q1
% 3F 5D 46 FC q2
% 3F 00 BB 7D q3
% BA BC 96 49 q4
% 40 20 加速度
% 0C 
% BC C4 A2 DB ax
% 3D 35 B0 11 ay
% C1 1C F4 6C az

% 80 20 角速度
% 0C 
% 35 7A 00 02 gx
% 38 7C 58 01 gy
% BA AD BB 00 gz

% C0 20 磁场强度
% 0C 
% 3F 16 B5 D4 magx
% BE 9E 6B A0 magy
% 3F 25 8B C8 magz

% E0 10 状态byte
% 01 
% 03 状态byte
% D8 校验和

