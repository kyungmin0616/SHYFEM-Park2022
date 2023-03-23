clear
clc
% 
files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Matthew');
files(1:3)=[];
files(end)=[];

files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Dorian');
files2(1:3)=[];

offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');

clear WL_MT
for i = 1:length(files)
    
  temp=readtable([files(i).folder '/' files(i).name]);
  
  WL_MT.(sprintf('STA_%d', i))(:,1) = datenum(table2array(temp(:,3)))+offdate;
  WL_MT.(sprintf('STA_%d', i))(:,2) = table2array(temp(:,5)).*0.3048;
  WL_MT.(sprintf('STA_%d', i))(:,3) = table2array(temp(:,2));

  clear temp
  
end

clear WL_DR
for i = 1:length(files2)
    
  temp=readtable([files2(i).folder '/' files2(i).name]);
  
  WL_DR.(sprintf('STA_%d', i))(:,1) = datenum(table2array(temp(:,3)))+offdate;
  WL_DR.(sprintf('STA_%d', i))(:,2) = table2array(temp(:,5)).*0.3048;
  WL_DR.(sprintf('STA_%d', i))(:,3) = table2array(temp(:,2));

  clear temp
  
end


%% NOAA
clear NOAA_MT NOAA_DR

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/NAVD/GA_WL_Matthew.csv');

date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA_MT(:,1)=datenum(strcat(date1,{' '},date2));
NOAA_MT(:,2) = table2array(GA_I(:,5));
NOAA_MT(:,3) = table2array(GA_I(:,3));
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/NAVD/GA_WL_Dorian.csv');

date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA_DR(:,1)=datenum(strcat(date1,{' '},date2));
NOAA_DR(:,2) = table2array(GA_I(:,5));
NOAA_DR(:,3) = table2array(GA_I(:,3));
clear GA_I

t_tide(NOAA_DR(:,2));
lowpass(NOAA_MT(:,2),24)




plot(data1)
plot(data2)
%% MODEL

%Matthew
refDate = datenum('2016-10-04 00:00:00');

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-base.nc'],'NC_NOWRITE');

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

% parameters for map
element_index=field{1}.data(1:3,:)';
time=refDate+field{5}.data/(60*60*24);
ssh=field{10}.data;
lon=field{4}.data;
lat=field{2}.data;

%Dorian
refDated = datenum('2019-09-01 00:00:00');

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-base.nc'],'NC_NOWRITE');

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

% parameters for map
timed=refDated+field{5}.data/(60*60*24);
sshd=field{10}.data;


%%
tg_obs=NOAA_MT;
tg_mdl=time;

st_obs=find(tg_obs(:,1)==startDate);
et_obs=find(tg_obs(:,1)==endDate);
st_mdl=find(tg_mdl==startDate);
et_mdl=find(tg_mdl==endDate);

%RMSE

obs=tg_obs(st_obs:et_obs,2);
mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;

leng_mdl=1:1:length(mdl_ori);
leng_mdl_interp=1:length(mdl_ori)/(length(obs)-1):length(mdl_ori);

mdl=interp1(leng_mdl,mdl_ori',leng_mdl_interp);

rmse=sqrt(nanmean((mdl-obs).^2));


plot(mdl)
plot(obs)
%% Comparison

fw=0.97;
fh=0.65;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Matthew

startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

sc=0.48;
% Fort Pulaski
h1=subplot(4,2,1);
lat_s = 32.03455;
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh(index_dist,:));

%rmse
tg_obs=NOAA_MT;
tg_mdl=time;

st_obs=find(tg_obs(:,1)==startDate);
et_obs=find(tg_obs(:,1)==endDate);
st_mdl=find(tg_mdl==startDate);
et_mdl=find(tg_mdl==endDate);
obs=tg_obs(st_obs:et_obs,2);
mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;
mdl=interp1(tg_mdl(st_mdl:et_mdl),mdl_ori',tg_obs(st_obs:et_obs,1));
rmse=sqrt(nanmean((mdl-obs).^2));

%plot
plot(time,sshtime1+sc,'-r','linewidth', 3);hold on
plot(NOAA_MT(:,1),NOAA_MT(:,2),'ob', 'LineWidth', 2)
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);
xlim([startDate endDate])
ylim([-2 3])
datetick('x','mmm-dd HH','keepticks')
set(gca,'XTickLabel',[]);
legend('SHYFEM','Observation')
% set(gca,'XTickLabel',[]);
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('NOAA 8670870','FontSize',16)
ylabel('Water level (m)')
set(gca,'FontSize',18)
set(gcf,'color','w')

clear sshtime1 tg_obs tg_mdl st_obs et_obs st_mdl et_mdl obs mdl_ori mdl rmse

% USGS 021989715
sc=0.48;
h3=subplot(4,2,3);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh(index_dist,:));

%rmse
tg_obs=WL_MT.STA_5;
tg_mdl=time;

st_obs=find(tg_obs(:,1)==startDate);
et_obs=find(tg_obs(:,1)==endDate);
st_mdl=find(tg_mdl==startDate);
et_mdl=find(tg_mdl==endDate);
obs=tg_obs(st_obs:et_obs,2);
mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;
mdl=interp1(tg_mdl(st_mdl:et_mdl),mdl_ori',tg_obs(st_obs:et_obs,1));
rmse=sqrt(nanmean((mdl-obs).^2));

%plot
plot(time,sshtime1+sc,'-r','linewidth', 3);hold on
plot(WL_MT.STA_5(:,1),WL_MT.STA_5(:,2),'ob', 'LineWidth', 2);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);
xlim([startDate endDate])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',16)
ylabel('Water level (m)')
set(gca,'FontSize',18)
set(gcf,'color','w')

clear sshtime1 tg_obs tg_mdl st_obs et_obs st_mdl et_mdl obs mdl_ori mdl rmse


% USGS 0219897993
sc=0.48;
h5=subplot(4,2,5);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh(index_dist,:));

%rmse
tg_obs=WL_MT.STA_10;
tg_mdl=time;

st_obs=find(tg_obs(:,1)==startDate);
et_obs=find(tg_obs(:,1)==endDate);
st_mdl=find(tg_mdl==startDate);
et_mdl=find(tg_mdl==endDate);
obs=tg_obs(st_obs:et_obs,2);
mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;
mdl=interp1(tg_mdl(st_mdl:et_mdl),mdl_ori',tg_obs(st_obs:et_obs,1));
rmse=sqrt(nanmean((mdl-obs).^2));

%plot
plot(time,sshtime1+sc,'-r','linewidth', 3);hold on
plot(WL_MT.STA_10(:,1),WL_MT.STA_10(:,2),'ob', 'LineWidth', 2);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);
xlim([startDate endDate])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',16)
ylabel('Water level (m)')
set(gca,'FontSize',18)
set(gcf,'color','w')
clear sshtime1 tg_obs tg_mdl st_obs et_obs st_mdl et_mdl obs mdl_ori mdl rmse

% USGS 022035975
sc=0;
h7=subplot(4,2,7);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh(index_dist,:));

%rmse
tg_obs=WL_MT.STA_11;
tg_mdl=time;

st_obs=find(tg_obs(:,1)==startDate);
et_obs=find(tg_obs(:,1)==endDate);
st_mdl=find(tg_mdl==startDate);
et_mdl=find(tg_mdl==endDate);
obs=tg_obs(st_obs:et_obs,2);
mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;
mdl=interp1(tg_mdl(st_mdl:et_mdl),mdl_ori',tg_obs(st_obs:et_obs,1));
rmse=sqrt(nanmean((mdl-obs).^2));

%plot
plot(time,sshtime1+sc,'-r','linewidth', 3);hold on
plot(WL_MT.STA_11(:,1),WL_MT.STA_11(:,2),'ob', 'LineWidth', 2);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);

xlim([startDate endDate])
ylim([-2 3])
set(gca,'XTickLabel',[]);
datetick('x','mmm-dd','keepticks')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2016)')
set(gca,'FontSize',18)
set(gcf,'color','w')
clear sshtime1 tg_obs tg_mdl st_obs et_obs st_mdl et_mdl obs mdl_ori mdl rmse




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Dorian

startDate = datenum('2019-09-02');
endDate = datenum('2019-09-08');
sc=0.2;
% Fort Pulaski
h2=subplot(4,2,2);
lat_s = 32.03455;
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd(index_dist,:));
%rmse
tg_obs=NOAA_DR;
tg_mdl=timed;

st_obs=find(tg_obs(:,1)==startDate);
et_obs=find(tg_obs(:,1)==endDate);
st_mdl=find(tg_mdl==startDate);
et_mdl=find(tg_mdl==endDate);
obs=tg_obs(st_obs:et_obs,2);
mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;
mdl=interp1(tg_mdl(st_mdl:et_mdl),mdl_ori',tg_obs(st_obs:et_obs,1));
rmse=sqrt(nanmean((mdl-obs).^2));

%plot
plot(timed,sshtime1+sc,'-r','linewidth', 3);hold on
plot(NOAA_DR(:,1),NOAA_DR(:,2),'ob', 'LineWidth', 2)
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);
xlim([startDate endDate])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('SHYFEM','Observation')
set(gca,'XTickLabel',[]);
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('NOAA 8670870','FontSize',16)
ylabel('Water level (m)')
set(gca,'FontSize',18)
set(gcf,'color','w')
clear sshtime1 tg_obs tg_mdl st_obs et_obs st_mdl et_mdl obs mdl_ori mdl rmse


% USGS 021989715
sc=0.3;
h4=subplot(4,2,4);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd(index_dist,:));
%rmse
tg_obs=WL_DR.STA_5;
tg_mdl=timed;

st_obs=find(tg_obs(:,1)==startDate);
et_obs=find(tg_obs(:,1)==endDate);
st_mdl=find(tg_mdl==startDate);
et_mdl=find(tg_mdl==endDate);
obs=tg_obs(st_obs:et_obs,2);
mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;
mdl=interp1(tg_mdl(st_mdl:et_mdl),mdl_ori',tg_obs(st_obs:et_obs,1));
rmse=sqrt(nanmean((mdl-obs).^2));

%plot
plot(timed,sshtime1+sc,'-r','linewidth', 3);hold on
plot(WL_DR.STA_5(:,1),WL_DR.STA_5(:,2),'ob', 'LineWidth', 2);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);
xlim([startDate endDate])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',16)
ylabel('Water level (m)')
set(gca,'FontSize',18)
set(gcf,'color','w')
clear sshtime1 tg_obs tg_mdl st_obs et_obs st_mdl et_mdl obs mdl_ori mdl rmse

% USGS 0219897993
sc=0.2;
h6=subplot(4,2,6);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd(index_dist,:));
%rmse
tg_obs=WL_DR.STA_10;
tg_mdl=timed;

st_obs=find(tg_obs(:,1)==startDate);
et_obs=find(tg_obs(:,1)==endDate);
st_mdl=find(tg_mdl==startDate);
et_mdl=find(tg_mdl==endDate);
obs=tg_obs(st_obs:et_obs,2);
mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;
mdl=interp1(tg_mdl(st_mdl:et_mdl),mdl_ori',tg_obs(st_obs:et_obs,1));
rmse=sqrt(nanmean((mdl-obs).^2));

%plot
plot(timed,sshtime1+sc,'-r','linewidth', 3);hold on
plot(WL_DR.STA_10(:,1),WL_DR.STA_10(:,2),'ob', 'LineWidth', 2);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);
xlim([startDate endDate])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',16)
ylabel('Water level (m)')
set(gca,'FontSize',18)
set(gcf,'color','w')
clear sshtime1 tg_obs tg_mdl st_obs et_obs st_mdl et_mdl obs mdl_ori mdl rmse

% USGS 022035975
sc=-0.17;
h8=subplot(4,2,8);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd(index_dist,:));
%rmse
tg_obs=WL_DR.STA_11;
tg_mdl=timed;

st_obs=find(tg_obs(:,1)==startDate);
et_obs=find(tg_obs(:,1)==endDate);
st_mdl=find(tg_mdl==startDate);
et_mdl=find(tg_mdl==endDate);
obs=tg_obs(st_obs:et_obs,2);
mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;
mdl=interp1(tg_mdl(st_mdl:et_mdl),mdl_ori',tg_obs(st_obs:et_obs,1));
rmse=sqrt(nanmean((mdl-obs).^2));

%plot
plot(timed,sshtime1+sc,'-r','linewidth', 3);hold on
plot(WL_DR.STA_11(:,1),WL_DR.STA_11(:,2),'ob', 'LineWidth', 2);
text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);
xlim([startDate endDate])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',16)
ylabel('Water level (m)')
set(gca,'FontSize',18)
set(gcf,'color','w')
xlabel('Date (2019)')
clear sshtime1 tg_obs tg_mdl st_obs et_obs st_mdl et_mdl obs mdl_ori mdl rmse


sp_width= 0.419/fw;
sp_height= 0.11/fh;
x_gap=0.09;
y_gap=0.07;
x1 = 0.03;
y1 = 0.79;
x2 = x1+sp_width+x_gap;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;
y4 = y3-sp_height-y_gap;

x_os=0;
y_os=0;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h3,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h5,'Position',[x1+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x2+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h7,'Position',[x1+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x2+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.



saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Figures_StormTide/Figures/S_Figure1.png',1));


