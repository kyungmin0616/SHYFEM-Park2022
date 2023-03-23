clear
clc

% bdn=readtable('boundn_20161005_hm_tides.dat');
% bdn2=readtable('boundn_L1tides20161005.dat');

bdn=readtable('boundn_20190902_hm_tides.dat');
bdn2=readtable('boundn_L1tides20190902.dat');


[length b] = size(bdn);

% Making txt file

fileprova = fopen('boundn_20190902_wo_tides.dat', 'wt');

for i=3:168:length-164
    
    fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 165, 1, 1, 1)
    fprintf(fileprova, '\n')
    fprintf(fileprova, '%s', string(table2array(bdn(i-2,1))))
    fprintf(fileprova, '\n')
    fprintf(fileprova, ' %s', 'water level [m]')
    fprintf(fileprova, '\n')
    for j=0:164
    fprintf(fileprova, '%1.12f ', str2double(table2array(bdn(i+j,1)))-str2double(table2array(bdn2(i+j,1))))
    fprintf(fileprova, '\n')
    end
    
end



% t_bdn2(:,1) = bdn_t(:,1);
% t_bdn2(:,2) = bdn_t(:,2);


% its=4;
h=figure;
set(h, 'Visible', 'on');
plot(bdn_t(:,1),bdn_t(:,2),'r','linewidth', 3); hold on
% plot(t_bdn(:,1),t_bdn(:,2),'linewidth', 3)
plot(t_bdn2(:,1),t_bdn2(:,2),'linewidth', 3)

graph_handle= gca;
set(graph_handle,'fontsize', 22)
set(graph_handle,'linewidth', 1)
datetick('x','mmmddhh','keeplimits')
xlabel('Days','FontSize',22);
ylabel('h (m)','FontSize',22);


% saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/20161007/Image/temp_%d.png',its));

