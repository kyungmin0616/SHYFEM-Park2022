clc
clear all
% close all


%%%%%%%%%%% MATTHEW
clear GA_I GA_M
%%%%%%%%%% Observation %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = table2array(GA_I(:,5));
GA_M(:,3) = table2array(GA_I(:,3));
GA_M(:,4) = GA_M(:,2)-GA_M(:,3);


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-ng-wo-tide.nc'],'NC_NOWRITE');

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
lon=field{4}.data;
lat=field{2}.data;
time=field{5}.data;
ssh=field{10}.data+0.15;

min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;

ssh1=ssh;
time1=time;

clear ssh time

% Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-at-dv-local.nc'],'NC_NOWRITE');
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-ng-wo-tide-at-dv-local2.nc'],'NC_NOWRITE');

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
time=field{5}.data;
ssh=field{10}.data;

ssh2=ssh;
time2=time;

clear ssh time

% Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-at-dv-remote-wp-0-ad.nc'],'NC_NOWRITE');
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-ng-wo-tide-at-dv-remote.nc'],'NC_NOWRITE');

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
time=field{5}.data;
ssh=field{10}.data+0.15;

ssh3=ssh;
time3=time;

clear ssh time


%%%%%%%%%%%%%%%%%%%%%%%%%%%% DORIAN

%%%%%%%%%% Observation %%%%%%%%%%%
clear GA_I GA_D

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_D(:,1)=datenum(strcat(date1,{' '},date2));
GA_D(:,2) = table2array(GA_I(:,5));
GA_D(:,3) = table2array(GA_I(:,3));
GA_D(:,4) = GA_D(:,2)-GA_D(:,3);


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-ng-wo-tide.nc'],'NC_NOWRITE');

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
time=field{5}.data;
ssh=field{10}.data-0.2;

sshd1=ssh;
timed1=time;

clear ssh time


% Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-at-dv-local.nc'],'NC_NOWRITE');
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-ng-wo-tide-at-dv-local2.nc'],'NC_NOWRITE');

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
time=field{5}.data;
ssh=field{10}.data;

sshd2=ssh;
timed2=time;

clear ssh time

% Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-at-dv-remote-wp-0-ad.nc'],'NC_NOWRITE');
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-ng-wo-tide-at-dv-remote.nc'],'NC_NOWRITE');

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
time=field{5}.data;
ssh=field{10}.data-0.2;

sshd3=ssh;
timed3=time;

clear ssh time

%%%%%%%%%%%%%%%%%%%%%%%%%

lat_s = 32.03455; % Fort Pulaski
lon_s = -80.902494;
% 
% lat_s = 32.1160833333333;
% lon_s = -81.1283333333333;

% lat_s = 31.5415;   % Sapelo estuary
% lon_s = -81.2192;


dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh1(index_dist,:));
m_sshtime1=mean(sshtime1);
sshtime2=squeeze(ssh2(index_dist,:));
m_sshtime2=mean(sshtime2);
sshtime3=squeeze(ssh3(index_dist,:));
m_sshtime3=mean(sshtime3);


sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);
sshtime2_d=squeeze(sshd2(index_dist,:));
m_sshtime2_d=mean(sshtime2_d);
sshtime3_d=squeeze(sshd3(index_dist,:));
m_sshtime3_d=mean(sshtime3_d);


%%


%% Plotting
fw=0.58;
fh=0.7;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf
os=0;
skp=20;
TP=172;

% Matthew
% startDate = datenum('10-05-2016');
% endDate = datenum('10-12-2016');
refDate = datenum('2016-10-04 00:00:00');
24*6
h1=subplot(2,1,1);
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)+os,'-k','linewidth', 2); hold on
% set(gca,'XLim',[startDate endDate])
datetick('x','mmm-dd','keepticks')
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 2.5])
legend({'MT-BS','MT-LF','MT-RF','Residual'},'FontSize',26)
xlabel('Date (2016)')
ylabel('Storm surge (m)')
title('Hurricane Matthew')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)



%% Plotting
fw=0.58;
fh=0.7;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf
os=0;
skp=20;
TP=194;

% Matthew
startDate = datenum('10-05-2016');
endDate = datenum('10-12-2016');
refDate = datenum('2016-10-04 00:00:00');

h1=subplot(2,1,1);
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+time2(1:TP,1)/(60*60*24),sshtime2(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+os,'-b','linewidth', 2,'MarkerSize',15); 
% plot(refDate+time3(1:TP,1)/(60*60*24),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP))+os,'-m','linewidth', 2,'MarkerSize',15); 
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
set(gca,'XLim',[startDate endDate])
datetick('x','mmm-dd','keepticks')
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 2.5])
legend({'MT-BS','MT-LF','MT-RF','Residual'},'FontSize',26)
xlabel('Date (2016)')
ylabel('Storm surge (m)')
title('Hurricane Matthew')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)

% Dorian
h2=subplot(2,1,2);
os=0;
startDate = datenum('09-02-2019');
endDate = datenum('09-09-2019');

refDate = datenum('2019-09-01 00:00:00');
plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime2_d(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(1:TP,1)/(60*60*24),sshtime3_d(1,1:TP)+os,'-b','linewidth', 2,'MarkerSize',15); 
% plot(refDate+time3(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)-(sshtime2_d(1,1:TP)+sshtime3_d(1,1:TP))+os,'-m','linewidth', 2,'MarkerSize',15); 
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/7:endDate])
set(gca,'XLim',[startDate endDate])

set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 2.5])
datetick('x','mmm-dd','keepticks')
legend({'DR-BS','DR-LF','DR-RF','Residual'},'FontSize',26)
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Dorian')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
set(gcf,'color','w')
set(gca, 'FontSize', 26)


sp_width= 0.515/fw;
sp_height= 0.22/fh;

x_gap=0.065;
y_gap=0.2;

x1 = 0.07;
y1 = 0.63;
y2 = y1-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_11.png',1));



%% Shifted

fw=0.58;
fh=0.7;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

% Y = prctile(sshtime1(1,sdt:TP)+os,[90:100],'all','Method','approximate');
% Y2 = prctile(sshtime2(1,sdt:TP)+sshtime3(1,sdt+ctlt:TP+ctlt),[90:100],'all','Method','approximate');

% I=find(sshtime1(1,sdt:TP)>=Y(1))
% I2=find(sshtime2(1,sdt:TP)+sshtime3(1,sdt+ctlt:TP+ctlt)>=Y2(1))

% [M, I] = max(sshtime1_d(1,sdt:TP))
% [M, I2] = max(sshtime2_d(1,sdt:TP)+sshtime3_d(1,sdt+ctlt:TP+ctlt))
% 
% datestr(refDate+timed1(I,1)/(60*60*24))
% datestr(refDate+timed3(I2,1)/(60*60*24))

clf
os=0;
skp=20;
TP=24*7;
sdt=24*2+1;
ctlt=+2;

startDate = datenum('10-06-2016');
endDate = datenum('10-10-2016');
refDate = datenum('2016-10-04 00:00:00');

h1=subplot(2,1,1);
plot(refDate+time1(sdt:TP,1)/(60*60*24),sshtime1(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+time2(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+sshtime3(1,sdt+ctlt:TP+ctlt),'-g','linewidth', 2,'MarkerSize',15); 
% plot(refDate+time3(sdt+I,1)/(60*60*24),sshtime1(1,sdt+I),'-r','linewidth', 5); 
% plot(refDate+time3(sdt+I2,1)/(60*60*24),sshtime2(1,sdt+I2)+sshtime3(1,sdt+ctlt+I2),'-r','linewidth', 5); 

% plot(TT2(I),TTT2(I),'-M','linewidth', 5); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','mmm-dd','keeplimits')
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 2.5])
legend({'MT-BS','MT-LF','MT-RF (Shifted)','Reconstruction'},'FontSize',26)
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Matthew')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 26)


h2=subplot(2,1,2);
ctlt=+14;
startDate = datenum('09-03-2019');
endDate = datenum('09-07-2019');
refDate = datenum('2019-09-01 00:00:00');
os=0;
plot(refDate+timed1(sdt:TP,1)/(60*60*24),sshtime1_d(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+timed2(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3_d(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+sshtime3_d(1,sdt+ctlt:TP+ctlt),'-g','linewidth', 2,'MarkerSize',15); 
% plot(refDate+timed1(sdt+I,1)/(60*60*24),sshtime1_d(1,sdt+I),'-r','linewidth', 5); 
% plot(refDate+timed3(sdt+I2,1)/(60*60*24),sshtime2_d(1,sdt+I2)+sshtime3_d(1,sdt+ctlt+I2),'-r','linewidth', 5); 
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 2.5])
datetick('x','mmm-dd','keeplimits')
legend({'DR-BS','DR-LF','DR-RF (Shifted)','Reconstruction'},'FontSize',26)
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Dorian')
box on
grid on
set(gcf,'color','w')
set(gcf,'color','w')
set(gca, 'FontSize', 26)

sp_width= 0.515/fw;
sp_height= 0.22/fh;

x_gap=0.065;
y_gap=0.2;

x1 = 0.07;
y1 = 0.63;
y2 = y1-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_12.png',1));
%% 2D MAP
fw=0.48;
fh=1;


load /Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/GoogleMap/ggmap_entire.mat

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf
subplot(1,2,1)
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;

trisurf(element_index,lon,lat,max(ssh3(:,24*6:end),[],2))
view(0,90);shading interp;     
colormap(jet);
caxis([0.7 0.80]);
colb=colorbar;
title(colb,'m')
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
title('Matthew');
xlabel('Longitude')
ylabel('Latitude')
set(graph_handle,'fontsize', 28)

subplot(1,2,2)
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;

trisurf(element_index,lon,lat,max(sshd3(:,24*6:end),[],2))
view(0,90);shading interp;     
colormap(jet);
colorbar;axis equal
caxis([0.28 0.35]);
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
title('Dorian');
xlabel('Longitude')
ylabel('Latitude')
set(graph_handle,'fontsize', 28)
set(gcf,'color','w')

  
%% 2D MAP
fw=0.48;
fh=1;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf

clear caxis

stt=25;
edt=24*7;

h1=subplot(3,4,1);
trisurf(element_index,lon,lat,max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title('\color{black}MT-BS');
caxis([0 2.2]);
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
set(gca,'XTickLabel',[]);


h2=subplot(3,4,2);
trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title('\color{black}MT-LF');
caxis([0 2.2]);
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);


h3=subplot(3,4,3);
trisurf(element_index,lon,lat,max(ssh3(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title('\color{black}MT-RF');
caxis([0 2.2]);
hcb=colorbar;
set(hcb,'YTick',[0 0.5 1 1.5 2 2.2])
title(hcb,'m','fontsize', 17)
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);

  
h4=subplot(3,4,4);
trisurf(element_index,lon,lat,((max(ssh2(:,stt:edt),[],2)+max(ssh3(:,stt:edt),[],2))-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
colormap(getpmap(7));
% caxis([-0.05 0.45]);
caxis([0 50]);
hcb=colorbar;
title(hcb,'%','fontsize', 18)
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('\color{black}Change in peak surge','FontSize',16);


h5=subplot(3,4,5);
trisurf(element_index,lon,lat,max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title('\color{black}DR-BS');
caxis([0 1.2]);
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
% set(gca,'XTickLabel',[]);

  
h6=subplot(3,4,6);
trisurf(element_index,lon,lat,max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title('\color{black}DR-LF');
caxis([0 1.2]);
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
% set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);


h7=subplot(3,4,7);
trisurf(element_index,lon,lat,max(sshd3(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title('\color{black}DR-RF');
caxis([0 1.2]);
hcb=colorbar;
title(hcb,'m','fontsize', 17)
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
% set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);


h8=subplot(3,4,8);
trisurf(element_index,lon,lat,((max(sshd2(:,stt:edt),[],2)+max(sshd3(:,stt:edt),[],2))-max(sshd1(:,stt:edt),[],2))./max(sshd1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
colormap(getpmap(7));
% caxis([-0.05 0.3]);
caxis([0 50]);
hcb=colorbar;
title(hcb,'%','fontsize', 17)
axis([-81.42 -80.32 min_lat max_lat]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.3:-80.28)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.4:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
% set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('\color{black}Change in peak surge','FontSize',16);
% 
% clear caxis
% h9=subplot(3,4,9);
% trisurf(element_index,lon,lat,max(ssh1(:,stt:edt),[],2)-max(sshd1(:,stt:edt),[],2))
% view(0,90);shading interp;     
% colormap(getpmap(7));
% title('\color{black}Diff.-BS','FontSize',17);
% caxis([0 1.4]);  
% axis([-81.42 -80.32 min_lat max_lat]);
% box on;
% grid on;
% graph_handle= gca;
% xticks(-81.4:0.3:-80.28)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.4:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
% set(graph_handle,'fontsize', 17)
% 
% h10=subplot(3,4,10);
% clear caxis
% trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2)-max(sshd2(:,stt:edt),[],2))
% view(0,90);shading interp;     
% colormap(getpmap(7));
% title('\color{black}Diff.-LF','FontSize',17);
% caxis([0 1.4]);  
% axis([-81.42 -80.32 min_lat max_lat]);
% box on;
% grid on;
% graph_handle= gca;
% xticks(-81.4:0.3:-80.28)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.4:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
% set(graph_handle,'fontsize', 17)
% set(gca,'YTickLabel',[]);
% 
% clear caxis           
% h11=subplot(3,4,11);
% trisurf(element_index,lon,lat,max(ssh3(:,stt:edt),[],2)-max(sshd3(:,stt:edt),[],2))
% view(0,90);shading interp;     
% colormap(getpmap(7));
% title('\color{black}Diff.-RF');
% caxis([0 1.4]);  
% hcb=colorbar;
% set(hcb,'YTick',0:0.2:1.4)
% title(hcb,'m','fontsize', 17)
% axis([-81.42 -80.32 min_lat max_lat]);
% box on;
% grid on;
% graph_handle= gca;
% xticks(-81.4:0.3:-80.28)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.4:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
% set(graph_handle,'fontsize', 17)
% set(gca,'YTickLabel',[]);


adt=2;
sp_width= 0.18/fw/adt;
sp_height= 0.5/fh/adt;
x_gap=0.03;
y_gap=0.08;

x1 = 0.05;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap;
x4 = x3+sp_width+x_gap+0.03;
x5 = x4+sp_width+x_gap;


y1 = 0.71;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;


set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x4 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h5,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x2 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h7,'Position',[x3 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x4 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h9,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h10,'Position',[x2 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h11,'Position',[x3 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure12_ver2.png',1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



