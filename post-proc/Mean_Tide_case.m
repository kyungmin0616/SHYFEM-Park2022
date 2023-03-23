clear
clc

bdn=readtable('boundn_20161005_hm_tides.dat');
bdn2=readtable('boundn_L1tides20161005.dat');

% bdn=readtable('boundn_20190902_hm_tides.dat');
% bdn2=readtable('boundn_L1tides20190902.dat');

[length b] = size(bdn);

% Making txt file

k=1;
for i=3:168:length-164
    
    for j=0:164
        
    ch(j+1,k)=str2double(table2array(bdn(i+j,1)))-str2double(table2array(bdn2(i+j,1)));

    end
    
    k=k+1;
    
end

m_ssh = mean(ch,2);


fileprova = fopen('boundn_20161005_mean_tides.dat', 'wt');

fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 165, 1, 1, 1)
fprintf(fileprova, '\n')
fprintf(fileprova, '%s', '20161004 000000')
fprintf(fileprova, '\n')
fprintf(fileprova, ' %s', 'water level [m]')
fprintf(fileprova, '\n')
for j=1:165
fprintf(fileprova, '%1.12f ', m_ssh(j,1))
fprintf(fileprova, '\n')
end
fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 165, 1, 1, 1)
fprintf(fileprova, '\n')
fprintf(fileprova, '%s', '20161030 000000')
fprintf(fileprova, '\n')
fprintf(fileprova, ' %s', 'water level [m]')
fprintf(fileprova, '\n')
for j=1:165
fprintf(fileprova, '%1.12f ', m_ssh(j,1))
fprintf(fileprova, '\n')
end    

