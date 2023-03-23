clear
clc
% 
% bdn=readtable('dr_wp.dat');
% bdn2=readtable('dr_wp_6h_fw.dat');
bdn=readtable('dr_tc.dat');
clear bdn2
bdn2=readtable('dr_tc_6h_fw.dat');


% bdn=readtable('mt_wp.dat');
% bdn2=readtable('mt_wp_6h_fw.dat');
% bdn=readtable('mt_tc.dat');
% clear bdn2
% bdn2=readtable('mt_tc_6h_fw.dat');


%% for tc

[length b] = size(bdn);


it = 1; % 1=6h


fileprova = fopen('dr_tc_6h_fw.dat', 'wt');
for i=3:187:length-137-141*it
    
    fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 2205, 1, 4, 11)
    fprintf(fileprova, '\n')
    fprintf(fileprova, '%s', string(table2array(bdn(i-2,1)))) %time
    fprintf(fileprova, '\n')
    fprintf(fileprova, '%s', string(table2array(bdn(i-1,1)))) % grid info
    fprintf(fileprova, '\n')
    
    fprintf(fileprova, '%s', string(table2array(bdn(i+187*it,1)))) %variable
    fprintf(fileprova, '\n')
    for j=1:45
    fprintf(fileprova, '%s ', string(table2array(bdn(i+j+187*it,1))))
    fprintf(fileprova, '\n')
    end
    
    fprintf(fileprova, '%s', string(table2array(bdn(i+j+1+187*it,1)))) %variable
    fprintf(fileprova, '\n')
    for k=47:91
    fprintf(fileprova, '%s ', string(table2array(bdn(i+k+187*it,1))))
    fprintf(fileprova, '\n')
    end
    
    fprintf(fileprova, '%s', string(table2array(bdn(i+k+1+187*it,1)))) %variable
    fprintf(fileprova, '\n')
    for w=93:137
    fprintf(fileprova, '%s ', string(table2array(bdn(i+w+187*it,1))))
    fprintf(fileprova, '\n')
    end
    
    fprintf(fileprova, '%s', string(table2array(bdn(i+w+1+187*it,1)))) %variable
    fprintf(fileprova, '\n')
    for q=139:183
    fprintf(fileprova, '%s ', string(table2array(bdn(i+q+187*it,1))))
    fprintf(fileprova, '\n')
    end
    
end


%% for wp

[length b] = size(bdn);


it = 1; % 1=6h


fileprova = fopen('mt_wp_6h_fw.dat', 'wt');
for i=3:141:length-137-141*it
    
    fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 2205, 1, 3, 11)
    fprintf(fileprova, '\n')
    fprintf(fileprova, '%s', string(table2array(bdn(i-2,1)))) %time
    fprintf(fileprova, '\n')
    fprintf(fileprova, '%s', string(table2array(bdn(i-1,1)))) % grid info
    fprintf(fileprova, '\n')
    
    fprintf(fileprova, '%s', string(table2array(bdn(i+141*it,1)))) %variable
    fprintf(fileprova, '\n')
    for j=1:45
    fprintf(fileprova, '%s ', string(table2array(bdn(i+j+141*it,1))))
    fprintf(fileprova, '\n')
    end
    
    fprintf(fileprova, '%s', string(table2array(bdn(i+j+1+141*it,1)))) %variable
    fprintf(fileprova, '\n')
    for k=47:91
    fprintf(fileprova, '%s ', string(table2array(bdn(i+k+141*it,1))))
    fprintf(fileprova, '\n')
    end
    
    fprintf(fileprova, '%s', string(table2array(bdn(i+k+1+141*it,1)))) %variable
    fprintf(fileprova, '\n')
    for w=93:137
    fprintf(fileprova, '%s ', string(table2array(bdn(i+w+141*it,1))))
    fprintf(fileprova, '\n')
    end
    
end



