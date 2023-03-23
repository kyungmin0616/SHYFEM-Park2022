clear
clc

bdn=readtable('boundn_L1hycom.dat');
bdn2=readtable('td10_boundn_L1.dat');
bdn3=readtable('fn2_boundn_L1.dat');
   
    
    
j=1;

for i=3:168:20163
    
 bdn_t(j:j+164,1)= str2double(table2array(bdn(i:i+164,1)))+str2double(table2array(bdn2(i:i+164,1)));
 
 j = j+165;
end


start = datenum(2016, 10, 05, 0, 0, 0);
offset = datenum(0, 0, 0, 1, 0, 0);
time_vec = start + (0:120)*offset;

bc_time = datestr(time_vec, 'yyyymmdd HHMMSS');

datestr(time_vec)



% Making txt file

fileprova = fopen('fn2_boundn_L1.dat', 'wt');


    k = 1;
    
    for i=1:121
    fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 165, 1, 1, 1);
    fprintf(fileprova, '\n');
    fprintf(fileprova, '%s', bc_time(i,:));
    fprintf(fileprova, '\n');
    fprintf(fileprova, ' %s', 'water level [m]');
    fprintf(fileprova, '\n');
    
    for j=k:k+164
    fprintf(fileprova, '%1.12f',  bdn_t(j,1));
    fprintf(fileprova, '\n');
    end
    
    k=k+165;
    
    end

