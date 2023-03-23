clc
clear all
% close all

offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');

%%%%%%%%%%% SSLS

clear SLS desc list wl SSLS
SLS = importdata('/Users/kpark350/Ga_tech/Projects/DataSet/SSLS/Py/hurricane_dorian.csv');

desc = string(SLS.textdata(2:end,1));
list = unique(desc);
SLS.textdata(1,:)=[];


for i=1:length(list)

    lon_tmp=SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),2);
    lat_tmp=SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),3);
    
    list(i,2) = string(lon_tmp(1,1));
    list(i,3) = string(lat_tmp(1,1));
    
    SSLS.(['sta',num2str(i)])(:,1)=datenum(string(SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),4)),'yyyy-mm-dd HH:MM:SS')+offdate; %NEW VER
    SSLS.(['sta',num2str(i)])(:,2)=SLS.data(strcmp(string(SLS.textdata(:,1)),list(i)),1)*0.3048;
    SSLS.(['sta',num2str(i)])(:,3)=SLS.data(strcmp(string(SLS.textdata(:,1)),list(i)),2)*0.3048;
    clear lon_tmp lat_tmp
    
  
    
end


%%%%%%%%%%% USGS
clear USGS
files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Matthew');
files(1:3)=[];
files(end)=[];

files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Dorian');
files2(1:3)=[];


clear WL_MT
for i = 1:length(files)
    
  temp=readtable([files(i).folder '/' files(i).name]);
  
  USGS.(sprintf('mtSTA_%d', i))(:,2) = datenum(table2array(temp(:,3)))+offdate;
  USGS.(sprintf('mtSTA_%d', i))(:,3) = table2array(temp(:,5)).*0.3048;
  USGS.(sprintf('mtSTA_%d', i))(:,1) = table2array(temp(:,2));

  clear temp
  
end

clear WL_DR
for i = 1:length(files2)
    
  temp=readtable([files2(i).folder '/' files2(i).name]);
  
  USGS.(sprintf('drSTA_%d', i))(:,2) = datenum(table2array(temp(:,3)))+offdate;
  USGS.(sprintf('drSTA_%d', i))(:,3) = table2array(temp(:,5)).*0.3048;
  USGS.(sprintf('drSTA_%d', i))(:,1) = table2array(temp(:,2));

  clear temp
  
end


%%%%%%%%%%% MATTHEW
clear GA_I GA_M
%%%%%%%%%% Observation %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/NAVD/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.mttime=datenum(strcat(date1,{' '},date2));
NOAA.mttotal = table2array(GA_I(:,5))+0.0710-0.0710;
NOAA.mttide = table2array(GA_I(:,3))+0.0710-0.0710;


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-base-ad.nc'],'NC_NOWRITE');

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

%%%%%%%%%% Dorian %%%%%%%%%%%
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.drtime=datenum(strcat(date1,{' '},date2));
NOAA.drtotal = table2array(GA_I(:,5))+1.1230-0.0710;
NOAA.drtide = table2array(GA_I(:,3))+1.1230-0.0710;


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-base-ad.nc'],'NC_NOWRITE');

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

%% Matthew
fw=1;
fh=1;
ftsz=21;
ftszt=16;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

% Matthew

startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

h1=subplot(5,2,1);


lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh1(index_dist,:));

plot(time1,sshtime1,'-k','linewidth', 3);hold on
plot(NOAA.mttime,NOAA.mttotal,'o','Color','r','MarkerFaceColor','r');hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-1.5 0 1.5 3]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
title('NOAA 8670870','FontSize',ftszt)

legend('Mdl.','Obs.','Orientation','horizontal')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', ftsz)


% USGS 0219897993

h2=subplot(5,2,2);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));

plot(time1,sshtime1,'-k','linewidth', 3);hold on
plot(USGS.mtSTA_10(:,2),USGS.mtSTA_10(:,3),'o','Color','g','MarkerFaceColor','g');

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-1.5 0 1.5 3]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)


% USGS 021989715
clear sshtime1 usgs_time usgs_wl

h3=subplot(5,2,3);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));

plot(time1,sshtime1,'-k','linewidth', 3);hold on
plot(USGS.mtSTA_5(:,2),USGS.mtSTA_5(:,3),'o','Color','g','MarkerFaceColor','g');

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-1.5 0 1.5 3]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',ftszt)
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

% USGS 022035975
clear sshtime1 usgs_time usgs_wl

h4=subplot(5,2,4);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:))-0.3;

plot(time1,sshtime1,'-k','linewidth', 3);hold on
plot(USGS.mtSTA_11(:,2),USGS.mtSTA_11(:,3),'o','Color','g','MarkerFaceColor','g');

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-1.5 0 1.5 3]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',ftszt)
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Val_mt.png',1));


%% Dorian

fw=1;
fh=1;
ftsz=21;
ftszt=16;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

h1=subplot(5,2,1);

lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(NOAA.drtime,NOAA.drtotal,'o','Color','r','MarkerFaceColor','r');hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
title('NOAA 8670870','FontSize',ftszt)

legend('Mdl.','Obs.','Orientation','horizontal')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', ftsz)


% USGS 0219897993

h2=subplot(5,2,2);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(USGS.drSTA_10(:,2),USGS.drSTA_10(:,3),'o','Color','g','MarkerFaceColor','g');

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)


% USGS 021989715
clear sshtime1 usgs_time usgs_wl

h3=subplot(5,2,3);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(USGS.drSTA_5(:,2),USGS.drSTA_5(:,3),'o','Color','g','MarkerFaceColor','g');

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

% USGS 022035975
clear sshtime1 usgs_time usgs_wl

h4=subplot(5,2,4);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:))-0.3;

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(USGS.drSTA_11(:,2),USGS.drSTA_11(:,3),'o','Color','g','MarkerFaceColor','g')

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

%%%%%%%%% Station number for SSLS &&&& 1 4 5 11 18 20
% SSLS 1: Bull River (stn:1) 2: Turner Creek (stn:20) 3: Hwy 80 at Grays
% creek (stn:11) 4: Solomon Bridge (stn:18) 5: Diamond Causeway (stn:4) 6: Faye drive
% (stn: 5)

h5=subplot(5,2,5);
stn=1; % 

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h6=subplot(5,2,6);
stn=20;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

h7=subplot(5,2,7);
stn=11;
lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h8=subplot(5,2,8);
stn=18;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h9=subplot(5,2,9);
stn=4;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h10=subplot(5,2,10);
stn=5;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Val_dr.png',1));


%%%%%%%%% Station number for SSLS &&&& 2 5 11 12 14 20
% SSLS 1: Oatland island (stn:14) 2: HWY 80 at Grays (stn:11) 3: Laroche
% (stn:12) 4: Turner creek (stn:20) 5: Coffee bluff (stn: 2) 6: Faye drive
% (stn: 5)
