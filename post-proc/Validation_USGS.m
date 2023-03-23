clc
clear all
% close all


files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Matthew');
files(1:3)=[];
files(end)=[];

files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Dorian');
files2(1:3)=[];



clear WL_MT
for i = 1:length(files)
    
  temp=readtable([files(i).folder '/' files(i).name]);
  
  WL_MT.(sprintf('STA_%d', i))(:,2) = datenum(table2array(temp(:,3)));
  WL_MT.(sprintf('STA_%d', i))(:,3) = table2array(temp(:,5)).*0.3048;
  WL_MT.(sprintf('STA_%d', i))(:,1) = table2array(temp(:,2));

  clear temp
  
end

clear WL_DR
for i = 1:length(files2)
    
  temp=readtable([files2(i).folder '/' files2(i).name]);
  
  WL_DR.(sprintf('STA_%d', i))(:,2) = datenum(table2array(temp(:,3)));
  WL_DR.(sprintf('STA_%d', i))(:,3) = table2array(temp(:,5)).*0.3048;
  WL_DR.(sprintf('STA_%d', i))(:,1) = table2array(temp(:,2));

  clear temp
  
end

%% shyfem
% Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-base-ad.nc'],'NC_NOWRITE');
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-new-grid.nc'],'NC_NOWRITE');

% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);

for ii = 0:(numvars-1)
   % Get information about the variables in the file.
   [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
   field{ii+1}.name = varname;

   % Get variable IDs
   varid = netcdf.inqVarID(ncid,varname);

   % Get the value of all variables
   field{ii+1}.data = netcdf.getVar(ncid,varid);
end

refDate = datenum('2016-10-04 00:00:00');

% parameters for map
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
time1=refDate+field{5}.data/(60*60*24);
ssh1=field{10}.data+0.15-0.0710;


%%%%%%%%%% Observation %%%%%%%%%%%
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.drtime=datenum(strcat(date1,{' '},date2));
NOAA.drtotal = table2array(GA_I(:,5))+1.1230-0.0710;
NOAA.drtide = table2array(GA_I(:,3))+1.1230-0.0710;


% Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-base-ad.nc'],'NC_NOWRITE');
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-new-grid.nc'],'NC_NOWRITE');

% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);

for ii = 0:(numvars-1)
   % Get information about the variables in the file.
   [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
   field{ii+1}.name = varname;

   % Get variable IDs
   varid = netcdf.inqVarID(ncid,varname);

   % Get the value of all variables
   field{ii+1}.data = netcdf.getVar(ncid,varid);
end

refDate = datenum('2019-09-01 00:00:00');

% parameters for map
timed1=refDate+field{5}.data/(60*60*24);
sshd1=field{10}.data-0.2-0.0710;

%% Plots

fw=1;
fh=0.7;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');
offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');

clf

% USGS 0219897993
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
usgs_time=WL_MT.STA_10(:,2)+offdate;
usgs_wl= WL_MT.STA_10(:,3);

h1=subplot(3,2,1);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));

IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(time1(:,1)>=startDate & time1(:,1)<=endDate );

clear a_x2 a_x SHYFEM

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';

rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));
plot(time1,sshtime1,'-r','linewidth', 3);hold on
% plot(usgs_time(IM),SHYFEM,'-r','linewidth', 3);hold on
plot(usgs_time(IM),usgs_wl(IM),'-b', 'LineWidth', 3);
text(startDate+0.03,3.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
ylim([-2 3])

datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',26)

% USGS 0219897993
startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');
usgs_time=WL_DR.STA_10(:,2)+offdate;
usgs_wl= WL_DR.STA_10(:,3);
 
h2=subplot(3,2,2);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));
 
IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(timed1(:,1)>=startDate & timed1(:,1)<=endDate );
 
clear a_x2 a_x SHYFEM
 
a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';
 
rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));

plot(timed1,sshtime1,'-r','linewidth', 3);hold on
% plot(usgs_time(IM),SHYFEM,'-r','linewidth', 3);hold on
plot(usgs_time(IM),usgs_wl(IM),'-b', 'LineWidth', 3);
text(startDate+0.03,3.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);
 
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 3])
 
datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',26)

% USGS 021989715
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
clear sshtime1 usgs_time usgs_wl

usgs_time=WL_MT.STA_5(:,2)+offdate;
usgs_wl= WL_MT.STA_5(:,3);

h3=subplot(3,2,3);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));

IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(time1(:,1)>=startDate & time1(:,1)<=endDate );

clear a_x2 a_x SHYFEM

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';

rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));

plot(time1,sshtime1,'-r','linewidth', 3);hold on
% plot(usgs_time(IM),SHYFEM,'-r','linewidth', 3);hold on
plot(usgs_time(IM),usgs_wl(IM),'-b', 'LineWidth', 3);
text(startDate+0.03,3.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
ylim([-2 3])

datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',16)
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',26)
set(gcf,'color','w')


% USGS 021989715
startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

clear sshtime1 usgs_time usgs_wl
 
usgs_time=WL_DR.STA_5(:,2)+offdate;
usgs_wl= WL_DR.STA_5(:,3);
 
h4=subplot(3,2,4);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));
 
IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(timed1(:,1)>=startDate & timed1(:,1)<=endDate );
 
clear a_x2 a_x SHYFEM
 
a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';
 
rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));
plot(timed1,sshtime1,'-r','linewidth', 3);hold on
% plot(usgs_time(IM),SHYFEM,'-r','linewidth', 3);hold on
plot(usgs_time(IM),usgs_wl(IM),'-b', 'LineWidth', 3);
text(startDate+0.03,3.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);
 
% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 3])
 
datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',16)
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',26)
set(gcf,'color','w')

% USGS 022035975
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
clear sshtime1 usgs_time usgs_wl

usgs_time=WL_MT.STA_11(:,2)+offdate;
usgs_wl= WL_MT.STA_11(:,3);

h5=subplot(3,2,5);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:))-0.3;

IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(time1(:,1)>=startDate & time1(:,1)<=endDate );

clear a_x2 a_x SHYFEM

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';

rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));
plot(time1,sshtime1,'-r','linewidth', 3);hold on
% plot(usgs_time(IM),SHYFEM,'-r','linewidth', 3);hold on
plot(usgs_time(IM),usgs_wl(IM),'-b', 'LineWidth', 3);
text(startDate+0.03,3.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',16)
ylabel('m')
xlabel('Date (2016)')
set(gca,'FontSize',26)
set(gcf,'color','w')


% USGS 022035975
startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

clear sshtime1 usgs_time usgs_wl
 
usgs_time=WL_DR.STA_11(:,2)+offdate;
usgs_wl= WL_DR.STA_11(:,3);
 
h6=subplot(3,2,6);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:))-0.3;
 
IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(timed1(:,1)>=startDate & timed1(:,1)<=endDate );
 
clear a_x2 a_x SHYFEM
 
a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';
 
rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));
plot(timed1,sshtime1,'-r','linewidth', 3);hold on 
% plot(usgs_time(IM),SHYFEM,'-r','linewidth', 3);hold on
plot(usgs_time(IM),usgs_wl(IM),'-b', 'LineWidth', 3);
text(startDate+0.03,3.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);
 
% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',16)
ylabel('m')
xlabel('Date (2019)')
set(gca,'FontSize',26)
set(gcf,'color','w')


sp_width= 0.43/fw;
% sp_height= 0.15/fh;
sp_height= 0.155/fh;

x_gap=0.07;
y_gap=0.08;

x1 = 0.045;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.04;
x4 = x3+sp_width+x_gap;
% y1 = 0.7;
y1 = 0.72;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h2,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x2 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x2 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure8.png',1));


%% Each hurricane
fw=0.8;
fh=0.7;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');
offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');


% Matthew

startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

clf

% USGS 0219897993
usgs_time=WL_MT.STA_10(:,2)+offdate;
usgs_wl= WL_MT.STA_10(:,3);

h1=subplot(3,1,1);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));

IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(time1(:,1)>=startDate & time1(:,1)<=endDate );

clear a_x2 a_x SHYFEM

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';

rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));

plot(time1,sshtime1,'-r','linewidth', 3);hold on
plot(usgs_time,usgs_wl,'-b', 'LineWidth', 3);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
ylim([-2 3])

datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993')
ylabel('Water level (m)')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',26)


% USGS 021989715
clear sshtime1 usgs_time usgs_wl

usgs_time=WL_MT.STA_5(:,2)+offdate;
usgs_wl= WL_MT.STA_5(:,3);

h2=subplot(3,1,2);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));

IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(time1(:,1)>=startDate & time1(:,1)<=endDate );

clear a_x2 a_x SHYFEM

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';

rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));

plot(time1,sshtime1,'-r','linewidth', 3);hold on
plot(usgs_time,usgs_wl,'-b', 'LineWidth', 3);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
ylim([-2 3])

datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',16)
ylabel('Water level (m)')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',26)
set(gcf,'color','w')

% USGS 022035975
clear sshtime1 usgs_time usgs_wl

usgs_time=WL_MT.STA_11(:,2)+offdate;
usgs_wl= WL_MT.STA_11(:,3);

h3=subplot(3,1,3);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:))-0.3;

IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(time1(:,1)>=startDate & time1(:,1)<=endDate );

clear a_x2 a_x SHYFEM

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';

rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));

plot(time1,sshtime1,'-r','linewidth', 3);hold on
plot(usgs_time,usgs_wl,'-b', 'LineWidth', 3);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2016)')
set(gca,'FontSize',26)
set(gcf,'color','w')


sp_width= 0.74/fw;
% sp_height= 0.15/fh;
sp_height= 0.155/fh;

x_gap=0.065;
y_gap=0.08;

x1 = 0.045;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.04;
x4 = x3+sp_width+x_gap;
% y1 = 0.7;
y1 = 0.72;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure8_a.png',1));


%% Dorian

fw=0.8;
fh=0.7;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');
offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');


startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

clf

% USGS 0219897993
usgs_time=WL_DR.STA_10(:,2)+offdate;
usgs_wl= WL_DR.STA_10(:,3);

h1=subplot(2,1,2);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(timed1(:,1)>=startDate & timed1(:,1)<=endDate );

clear a_x2 a_x SHYFEM

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';

rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));

plot(timed1,sshtime1,'-r','linewidth', 3);hold on
plot(usgs_time,usgs_wl,'ob', 'LineWidth', 3);
% text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);

xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 3])

datetick('x','mmm-dd','keepticks')
% legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
legend('Model','USGS')

grid on
ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
title('USGS 0219897993')
ylabel('Water level (m)')
xlabel('Date (2019)')

% set(gca,'XTickLabel',[]);
set(gca,'FontSize',26)


% USGS 021989715
clear sshtime1 usgs_time usgs_wl

usgs_time=WL_DR.STA_5(:,2)+offdate;
usgs_wl= WL_DR.STA_5(:,3);

h2=subplot(2,1,1);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(timed1(:,1)>=startDate & timed1(:,1)<=endDate );

clear a_x2 a_x SHYFEM

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';

rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));

plot(timed1,sshtime1,'-r','linewidth', 3);hold on
plot(usgs_time,usgs_wl,'ob', 'LineWidth', 3);
% text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);

% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 3])

datetick('x','mmm-dd','keepticks')
% legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
legend('Model','USGS')

grid on
ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2019)')

% set(gca,'XTickLabel',[]);
set(gca,'FontSize',26)
set(gcf,'color','w')

% USGS 022035975
clear sshtime1 usgs_time usgs_wl

usgs_time=WL_DR.STA_11(:,2)+offdate;
usgs_wl= WL_DR.STA_11(:,3);

h3=subplot(3,1,3);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:))-0.3;

IM = find(usgs_time(:,1)>=startDate & usgs_time(:,1)<=endDate);
SIM = find(timed1(:,1)>=startDate & timed1(:,1)<=endDate );

clear a_x2 a_x SHYFEM

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(usgs_wl(IM,1))-1):length(SIM);
SHYFEM=interp1(a_x,sshtime1(1,SIM)',a_x2)';

rmse=sqrt(nanmean((SHYFEM-usgs_wl(IM,1)).^2));

plot(timed1,sshtime1,'-r','linewidth', 3);hold on
plot(usgs_time,usgs_wl,'-b', 'LineWidth', 3);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f'),' (m)'],'fontsize',26);

% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('TWL_{mdl}','TWL_{USGS}','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2019)')
set(gca,'FontSize',26)
set(gcf,'color','w')


sp_width= 0.74/fw;
% sp_height= 0.15/fh;
sp_height= 0.155/fh;

x_gap=0.065;
y_gap=0.08;

x1 = 0.045;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.04;
x4 = x3+sp_width+x_gap;
% y1 = 0.7;
y1 = 0.72;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure8_b.png',1));

