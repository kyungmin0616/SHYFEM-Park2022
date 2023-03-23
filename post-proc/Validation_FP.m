clc
clear all
% close all


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


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-only-tide.nc'],'NC_NOWRITE');

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
ssh2=field{10}.data-0.0710;
time2=refDate+field{5}.data/(60*60*24);


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-ad.nc'],'NC_NOWRITE');

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
ssh3=field{10}.data+0.15-0.0710;
time3=refDate+field{5}.data/(60*60*24);


%%%%%%%%%% Observation %%%%%%%%%%%
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


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-only-tide.nc'],'NC_NOWRITE');

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
sshd2=field{10}.data-0.0710;
timed2=refDate+field{5}.data/(60*60*24);


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-ad.nc'],'NC_NOWRITE');

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
timed3=refDate+field{5}.data/(60*60*24);
sshd3=field{10}.data-0.2-0.0710;



%%%%%%%%%%%%%%%%%%%%%%%%%

lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;


% lat_s = 32.03;
% lon_s = -80.9;
% lat_s = 32.09;
% lon_s = -81.02;

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

%Interpolation

clear ID IM SIM SID

IM = find(NOAA.mttime(:,1)>=datenum('2016-10-05 00:00:00') & NOAA.mttime(:,1)<=datenum('2016-10-11 00:00:00'));
ID = find(NOAA.drtime(:,1)>=datenum('2019-09-02 00:00:00') & NOAA.drtime(:,1)<=datenum('2019-09-08 00:00:00'));
SIM = find(time1(:,1)>=datenum('2016-10-05 00:00:00') & time1(:,1)<=datenum('2016-10-11 00:00:00'));
SID = find(timed1(:,1)>=datenum('2019-09-02 00:00:00') & timed1(:,1)<=datenum('2019-09-08 00:00:00'));


clear a_x2 a_x S_MT

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(NOAA.mttime(IM,1))-1):length(SIM);
% S_MT.total=interp1(a_x,sshtime1(1,SIM)',a_x2)'-1.0500;%-0.47
% S_MT.tide=interp1(a_x,sshtime2(1,SIM)',a_x2)'-1.0500; %-1.0500
S_MT.total=interp1(a_x,sshtime1(1,SIM)',a_x2)';
S_MT.tide=interp1(a_x,sshtime2(1,SIM)',a_x2)'+0.1;
S_MT.surge=interp1(a_x,sshtime3(1,SIM)',a_x2)';
S_MT.time=NOAA.mttime(IM,1);

clear a_x2 a_x S_DR 
a_x=1:1:length(SID);
a_x2=1:(length(SID)-1)/(length(NOAA.drtime(ID,1))-1):length(SID);
S_DR.total=interp1(a_x,sshtime1_d(1,SID)',a_x2)';
S_DR.tide=interp1(a_x,sshtime2_d(1,SID)',a_x2)'+0.05;
S_DR.surge=interp1(a_x,sshtime3_d(1,SID)',a_x2)';
S_DR.time=NOAA.drtime(ID,1);

clear bias rmse

bias.mttotal=(nanmean(S_MT.total-NOAA.mttotal(IM,1)))/nanmean(abs(NOAA.mttotal(IM,1)));
bias.drtotal=(nanmean(S_DR.total-NOAA.drtotal(ID,1)))/nanmean(abs(NOAA.drtotal(ID,1)));
bias.mttide=(nanmean(S_MT.tide-NOAA.mttide(IM,1)))/nanmean(abs(NOAA.mttide(IM,1)));
bias.drtide=(nanmean(S_DR.tide-NOAA.drtide(ID,1)))/nanmean(abs(NOAA.drtide(ID,1)));

corrcoef(S_MT.total,NOAA.mttotal(IM,1))
corrcoef(S_DR.total,NOAA.drtotal(ID,1))
corrcoef(S_MT.tide,NOAA.mttide(IM,1))
corrcoef(S_DR.tide,NOAA.drtide(ID,1))


rmse.mttotal=sqrt(nanmean((S_MT.total-NOAA.mttotal(IM,1)).^2));
rmse.mttide=sqrt(nanmean((S_MT.tide-NOAA.mttide(IM,1)).^2));
rmse.drtotal=sqrt(nanmean((S_DR.total-NOAA.drtotal(ID,1)).^2));
rmse.drtide=sqrt(nanmean((S_DR.tide-NOAA.drtide(ID,1)).^2));


%% Plots

fw=1;
fh=0.63;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');


% Matthew
clf
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

clf
h1=subplot(2,2,1);
% 
% plot(S_MT.time,S_MT.total,'-r','linewidth', 2);hold on
% plot(NOAA.mttime,NOAA.mttotal,'-b','linewidth',2);hold on
plot(S_MT.time,S_MT.tide,'-r','linewidth', 2);hold on
plot(NOAA.mttime,NOAA.mttide,'-b','linewidth',2);hold on
% text(startDate+0.03,4.6, ['RMSE_{TWL} = ',num2str(rmse.mttotal,'%.2f'),' (m)'],'fontsize',26);
% text(startDate+1.8,4.6, [', RMSE_{ATL} = ',num2str(rmse.mttide,'%.2f'),' (m)'],'fontsize',26);

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);

% legend('TWL_{mdl}','TWL_{NOAA}','ATL_{mdl}','ATL_{NOAA}','Orientation','horizontal')
legend('ATL_{mdl}','ATL_{NOAA}','Orientation','horizontal')

ylabel('Water level (m)')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)

h2=subplot(2,2,3);
% plot(S_MT.time,S_MT.total-NOAA.mttotal(IM),'-r','linewidth', 2);hold on
plot(S_MT.time,S_MT.tide-NOAA.mttide(IM),'-r','linewidth', 2);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-0.5 0.5],'YTick',[-0.5 0 0.5]);
datetick('x','mmm-dd','keepticks')
% legend('Error of TWL','Error of ATL','Orientation','horizontal')
legend('Error of ATL','Orientation','horizontal')

ylabel('Error (m)')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)
xlabel('Date (2016)')

%Puple : 'Color',[0.4940 0.1840 0.5560]
h3=subplot(2,2,2);
plot(S_MT.time,S_MT.total-S_MT.tide,'-r','linewidth', 2);hold on
plot(NOAA.mttime,NOAA.mttotal-NOAA.mttide,'-b','linewidth', 2);hold on
plot(S_MT.time,S_MT.total-NOAA.mttide(IM),'-.r','linewidth', 2);hold on
plot(S_MT.time,S_MT.surge,'-g','linewidth', 2);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1.5 4],'YTick',[-1 0 1 2 3 4]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);

legend('TWL_{mdl}-ATL_{mdl}','TWL_{NOAA}-ATL_{NOAA}','TWL_{mdl}-ATL_{NOAA}','SS_{mdl}','Orientation','horizontal')

ylabel('Water level (m)')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)


h4=subplot(2,2,4);

plot(S_MT.time,S_MT.total-(S_MT.surge+S_MT.tide),'-r','linewidth', 2);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-0.25 0.25],'YTick',[-0.25 0 0.25]);
datetick('x','mmm-dd','keepticks')
legend('TSI_{mdl}')

ylabel('TSI (m)')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)
xlabel('Date (2016)')

sp_width= 0.42/fw;
% sp_height= 0.15/fh;
sp_height= 0.23/fh;

x_gap=0.08;
y_gap=0.08;

x1 = 0.048;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.04;
x4 = x3+sp_width+x_gap;
% y1 = 0.7;
y1 = 0.565;

y2 = y1-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x2 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure7.png',1));


%% Dorian

fw=1;
fh=0.63;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

clf
h1=subplot(2,2,1);

plot(S_DR.time,S_DR.total,'-r','linewidth', 2);hold on
plot(NOAA.drtime,NOAA.drtotal,'-b','linewidth',2);hold on
plot(S_DR.time,S_DR.tide,'-.r','linewidth', 2);
plot(NOAA.drtime,NOAA.drtide,'-.b','linewidth',2);
text(startDate+0.03,3.5, ['RMSE_{TWL} = ',num2str(rmse.drtotal,'%.2f'),' (m)'],'fontsize',26);
text(startDate+1.8,3.5, [', RMSE_{ATL} = ',num2str(rmse.drtide,'%.2f'),' (m)'],'fontsize',26);

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1.5 3],'YTick',[-1 0 1 2 3]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);

legend('TWL_{mdl}','TWL_{NOAA}','ATL_{mdl}','ATL_{NOAA}','Orientation','horizontal')
ylabel('Water level (m)')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)

h2=subplot(2,2,3);
plot(S_DR.time,S_DR.total-NOAA.drtotal(ID),'-r','linewidth', 2);hold on
plot(S_DR.time,S_DR.tide-NOAA.drtide(ID),'-b','linewidth', 2);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1.5 3],'YTick',[-1 0 1 2 3 4]);
datetick('x','mmm-dd','keepticks')

legend('Error of TWL','Error of ATL','Orientation','horizontal')
ylabel('Error (m)')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)
xlabel('Date (2019)')

%Puple : 'Color',[0.4940 0.1840 0.5560]
h3=subplot(2,2,2);
plot(S_DR.time,S_DR.total-S_DR.tide,'-r','linewidth', 2);hold on
plot(NOAA.drtime,NOAA.drtotal-NOAA.drtide,'-b','linewidth', 2);hold on
plot(S_DR.time,S_DR.total-NOAA.drtide(ID),'-.r','linewidth', 2);hold on
plot(S_DR.time,S_DR.surge,'-g','linewidth', 2);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1.5 3],'YTick',[-1 0 1 2 3 4]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);

legend('TWL_{mdl}-ATL_{mdl}','TWL_{NOAA}-ATL_{NOAA}','TWL_{mdl}-ATL_{NOAA}','SS_{mdl}','Orientation','horizontal')

ylabel('Water level (m)')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)


h4=subplot(2,2,4);

plot(S_DR.time,S_DR.total-(S_DR.surge+S_DR.tide),'-r','linewidth', 2);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1.5 3],'YTick',[-1 0 1 2 3 4]);
datetick('x','mmm-dd','keepticks')
legend('TSI_{mdl}')

ylabel('TSI (m)')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)
xlabel('Date (2019)')

sp_width= 0.43/fw;
% sp_height= 0.15/fh;
sp_height= 0.23/fh;

x_gap=0.08;
y_gap=0.08;

x1 = 0.035;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.04;
x4 = x3+sp_width+x_gap;
% y1 = 0.7;
y1 = 0.565;

y2 = y1-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x2 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure8.png',1));


%%


