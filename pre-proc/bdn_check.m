clear
clc

bdn=readtable('boundn_L1hycom_cubic.dat');
bdn2=readtable('boundn_L1hycom.dat');

date=table2array(bdn(1,1));
dt_n=datenum(strcat(date), 'yyyymmdd HHMMSS');

datestr(dt_n)


j=0;

for i=40:168:20327
    
    j=j+1;
    
    date=table2array(bdn(i-9,1));
    

    bdn_t(j,1)=datenum(strcat(date), 'yyyymmdd HHMMSS');
    bdn_t(j,2)= str2double(table2array(bdn(i,1)));
    bdn_t(j,3)= str2double(table2array(bdn2(i,1)));

end

% ac=bdn_t(:,1);
% bc=bdn_t(:,2);

clf
% its=2;
h=figure;
set(h, 'Visible', 'on');
plot(bdn_t(:,1),bdn_t(:,2),'linewidth', 3); hold on
plot(bdn_t(:,1),bdn_t(:,3),'linewidth', 3);
graph_handle= gca;
set(graph_handle,'fontsize', 22)
set(graph_handle,'linewidth', 1)
datetick('x','mmmdd')
xlabel('Days','FontSize',22);
ylabel('h (m)','FontSize',22);
% saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/HYCOM/BC/temp_%d.png',its));

