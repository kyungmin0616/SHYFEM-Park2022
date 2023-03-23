clear
clc

bdn=readtable('boundn_20161005_hm_tides.dat','Format','auto');
bdn2=readtable('boundn_L1tides20161005.dat','Format','auto');

% bdn=readtable('boundn_20190902_hm_tides.dat','Format','auto');
% bdn2=readtable('boundn_L1tides20190902.dat','Format','auto');


%% SSH only
%MT: 0.4337
%DR: 0.4599

it = 0;

[length b] = size(bdn);

% fileprova = fopen('dorian_surge.dat', 'wt');
% fileprova = fopen('boundn_20161005_wo_tides_adjust.dat', 'wt');
% fileprova = fopen('boundn_20190902_wo_tides_adjust.dat', 'wt');


for i=3:168:length-164-it
    
    fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 165, 1, 1, 1)
    fprintf(fileprova, '\n')
    fprintf(fileprova, '%s', string(table2array(bdn(i-2,1))))
    fprintf(fileprova, '\n')
    fprintf(fileprova, ' %s', 'water level [m]')
    fprintf(fileprova, '\n')
    for j=0:164
    fprintf(fileprova, '%1.12f ', str2double(table2array(bdn(i+j,1)))-str2double(table2array(bdn2(i+j,1)))+0.4599)
    fprintf(fileprova, '\n')
    end
    
    
end


%% Tide + ssh

%MT: 0.4337
%DR: 0.4599

it = 0;

[length b] = size(bdn);

fileprova = fopen('boundn_20161005_hm_tides_adjust.dat', 'wt');
% fileprova = fopen('boundn_20190902_hm_tides_adjust.dat', 'wt');

for i=3:168:length-164-it
    
    fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 165, 1, 1, 1)
    fprintf(fileprova, '\n')
    fprintf(fileprova, '%s', string(table2array(bdn(i-2,1))))
    fprintf(fileprova, '\n')
    fprintf(fileprova, ' %s', 'water level [m]')
    fprintf(fileprova, '\n')
    for j=0:164
    fprintf(fileprova, '%1.12f ', str2double(table2array(bdn(i+j,1)))+0.4337)
    fprintf(fileprova, '\n')
    end
    
    
end
