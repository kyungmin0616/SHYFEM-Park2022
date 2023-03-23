clear
clc

bdn=readtable('uv3d_L1.dat');
bdn=load('uv3d_L1.dat');
bdn=importdata('uv3d_L1.dat');


[filename directory_name] = uigetfile('*.dat', 'Select a file');
fullname = fullfile(directory_name, filename);
data = load(fullname);

5-169
171+164=335
date=table2array(bdn(1,1));

dt_n=datenum(strcat(date), 'yyyymmdd HHMMSS');

% datestr(tideT)


j=0;

for i=40:168:20327
    j=j+1;
    
    date=table2array(bdn(i-39,1));
    

    bdn_t(j,1)=datenum(strcat(date), 'yyyymmdd HHMMSS');
    bdn_t(j,2)= str2double(table2array(bdn(i,1)));
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

