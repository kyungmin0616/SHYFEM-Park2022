clear
clc
% 
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


%% NOAA
clear NOAA_MT NOAA_DR

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_Matthew.csv');

date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA_MT(:,1)=datenum(strcat(date1,{' '},date2));
NOAA_MT(:,2) = table2array(GA_I(:,5));
NOAA_MT(:,3) = table2array(GA_I(:,3));
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_Dorian.csv');

date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA_DR(:,1)=datenum(strcat(date1,{' '},date2));
NOAA_DR(:,2) = table2array(GA_I(:,5));
NOAA_DR(:,3) = table2array(GA_I(:,3));
clear GA_I

%% MODEL

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-ref.nc'],'NC_NOWRITE');
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-ref.nc'],'NC_NOWRITE');

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
time=field{5}.data;
ssh=field{10}.data;
lon=field{4}.data;
lat=field{2}.data;
sshd1=ssh;
timed1=time;
min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;

depth=(field{7}.data);


depth1=depth;
depth1(depth1<5)=NaN;


startDate=-81.5;
endDate=-80.3;
clear ssh time

refDate = datenum('2016-10-04 00:00:00');
% refDate = datenum('2019-09-01 00:00:00');
offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');


stime=refDate+timed1/(60*60*24);
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
gi=find(GA_D(:,1)==startDate);
ge=find(GA_D(:,1)==endDate);
sgi=find(stime==startDate);
sge=find(stime==endDate);

%% Matthew

h=figure('units','normalized','position',[0 0 1 0.6]);
set(h, 'Visible', 'off');

% clf

sc=0.25;
% Fort Pulaski
subplot(2,2,1)
lat_s = 32.03455;
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
plot(GA_D(:,1),GA_D(:,2)+1,'ob', 'LineWidth', 2)

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
ylim([-2 3])

datetick('x','mmm-dd','keepticks')
legend('SHYFEM','NOAA')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('NOAA Fort Pulaski','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2016)')
set(gca,'FontSize',18)
set(gcf,'color','w')

%RMSE


clear stide tide I_stide I_tide a_x2
stide=sshtime1_d(1,sgi:sge)+sc;

a_x=1:1:length(stide);
a_x2=1:length(stide)/(length(GA_D(gi:ge,1))-1):length(stide);
I_stide=interp1(a_x,stide',a_x2);

rmse_stide_t=sqrt(nanmean((I_stide'-GA_D(gi:ge,2)).^2));


% USGS 0219897993
subplot(2,2,2)
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
plot(WL.STA_10(:,2)+offdate,WL.STA_10(:,3),'ob', 'LineWidth', 2);

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
ylim([-2 3])

datetick('x','mmm-dd','keepticks')
legend('SHYFEM','USGS')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2016)')
set(gca,'FontSize',18)
set(gcf,'color','w')

% USGS 021989715
subplot(2,2,3)
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
plot(WL.STA_5(:,2)+offdate,WL.STA_5(:,3),'ob', 'LineWidth', 2);

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
ylim([-2 3])

datetick('x','mmm-dd','keepticks')
legend('SHYFEM','USGS')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2016)')
set(gca,'FontSize',18)
set(gcf,'color','w')

% USGS 02198950
% subplot(2,2,4)
% lat_s = 32.1655555;
% lon_s = -81.1383333;
% dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
% [min_dist,index_dist] = min(dist);
% sshtime1_d=squeeze(sshd1(index_dist,:));
% m_sshtime1_d=mean(sshtime1_d);
% 
% plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
% plot(WL.STA_4(:,2)+offdate,WL.STA_4(:,3),'ob', 'LineWidth', 2);
% 
% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% % xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
% ylim([-2 3])
% datetick('x','mmm-dd','keepticks')
% legend('SHYFEM','USGS')
% grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
% title('USGS 02198950','FontSize',16)
% ylabel('Water level (m)')
% xlabel('Date (2016)')
% set(gca,'FontSize',18)
% set(gcf,'color','w')

% USGS 022035975
subplot(2,2,4)
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

plot(refDate+timed1/(60*60*24),sshtime1_d+sc-0.3,'-r','linewidth', 3);hold on
plot(WL.STA_11(:,2)+offdate,WL.STA_11(:,3),'ob', 'LineWidth', 2);

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('SHYFEM','USGS')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2016)')
set(gca,'FontSize',18)
set(gcf,'color','w')

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Tide_Figures/Figures/Figure2_a.png',1));


%% Dorian

h=figure('units','normalized','position',[0 0 1 0.6]);
set(h, 'Visible', 'off');

sc=0.12;

% Fort Pulaski
subplot(2,2,1)
lat_s = 32.03455;
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
% plot(WL.STA_11(:,2)+offdate,WL.STA_11(:,3),'ob', 'LineWidth', 2)
plot(GA_D(:,1),GA_D(:,2)+1,'ob', 'LineWidth', 2)

% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('SHYFEM','NOAA')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('NOAA Fort Pulaski','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2019)')
set(gca,'FontSize',18)
set(gcf,'color','w')

% USGS 0219897993
subplot(2,2,2)
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
plot(WL.STA_10(:,2)+offdate,WL.STA_10(:,3),'ob', 'LineWidth', 2);

% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('SHYFEM','USGS')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2019)')
set(gca,'FontSize',18)
set(gcf,'color','w')

% USGS 021989715
subplot(2,2,3)
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
plot(WL.STA_5(:,2)+offdate,WL.STA_5(:,3),'ob', 'LineWidth', 2);

% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('SHYFEM','USGS')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2019)')
set(gca,'FontSize',18)
set(gcf,'color','w')

% USGS 02198950
% subplot(2,2,4)
% lat_s = 32.1655555;
% lon_s = -81.1383333;
% dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
% [min_dist,index_dist] = min(dist);
% sshtime1_d=squeeze(sshd1(index_dist,:));
% m_sshtime1_d=mean(sshtime1_d);
% 
% plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
% plot(WL.STA_4(:,2)+offdate,WL.STA_4(:,3),'ob', 'LineWidth', 2);
% 
% % xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
% ylim([-2 3])
% datetick('x','mmm-dd','keepticks')
% legend('SHYFEM','USGS')
% grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
% title('USGS 02198950','FontSize',16)
% ylabel('Water level (m)')
% xlabel('Date (2019)')
% set(gca,'FontSize',18)
% set(gcf,'color','w')

% USGS 022035975
subplot(2,2,4)
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

plot(refDate+timed1/(60*60*24),sshtime1_d+sc-0.3,'-r','linewidth', 3);hold on
plot(WL.STA_11(:,2)+offdate,WL.STA_11(:,3),'ob', 'LineWidth', 2);

% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
ylim([-2 3])
datetick('x','mmm-dd','keepticks')
legend('SHYFEM','USGS')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2019)')
set(gca,'FontSize',18)
set(gcf,'color','w')

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Tide_Figures/Figures/Figure2_b.png',1));

%%


figure(2)
clf
trisurf(element_index,lon,lat,depth);hold on
% plot3(lon_s,lat_s,100,'or','MarkerSize',10,'MarkerFaceColor','r')
% plot3(-81.28972222,31.97777778,100,'or','MarkerSize',10,'MarkerFaceColor','r')

view(0,90); shading interp;     
% colormap(turbo);
% axis equal
title('\color{black}Change in peak level','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
% caxis([-10 2]);
% caxis([-42 10]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,parula)

