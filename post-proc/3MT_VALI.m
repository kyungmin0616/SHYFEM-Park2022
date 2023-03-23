clc
clear all
% close all


%%%%%%%%%%% MATTHEW
clear GA_I GA_M
%%%%%%%%%% Observation %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/NAVD/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = table2array(GA_I(:,5));
GA_M(:,3) = table2array(GA_I(:,3));


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-total-ng-otps.nc'],'NC_NOWRITE');

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
ssh1=field{10}.data;

%%%%%%%%%% Observation %%%%%%%%%%%
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_D(:,1)=datenum(strcat(date1,{' '},date2));
GA_D(:,2) = table2array(GA_I(:,5))+1.1230;
GA_D(:,3) = table2array(GA_I(:,3))+1.1230;


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
sshd1=field{10}.data;



%%%%%%%%%%%%%%%%%%%%%%%%%

lat_s = 32.03455;
lon_s = -80.902494;


% lat_s = 32.03;
% lon_s = -80.9;
% lat_s = 32.09;
% lon_s = -81.02;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh1(index_dist,:));
m_sshtime1=mean(sshtime1);

sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

%Interpolation

clear ID IM SIM SID
% ID = find(GA_D(:,1)>=datenum('2019-09-01 00:00:00') & GA_D(:,1)<=datenum('2019-09-20 23:00:00'));
% IM = find(GA_M(:,1)>=datenum('2016-10-04 00:00:00') & GA_M(:,1)<=datenum('2016-10-30 23:00:00'));
% SIM = find(time1(:,1)>=datenum('2016-10-04 00:00:00') & time1(:,1)<=datenum('2016-10-13 23:00:00'));
% SID = find(timed1(:,1)>=datenum('2019-09-01 00:00:00') & timed1(:,1)<=datenum('2019-09-10 23:00:00'));

ID = find(GA_D(:,1)>=datenum('2019-09-02 00:00:00') & GA_D(:,1)<=datenum('2019-09-08 00:00:00'));
IM = find(GA_M(:,1)>=datenum('2016-10-05 00:00:00') & GA_M(:,1)<=datenum('2016-10-11 00:00:00'));
SIM = find(time1(:,1)>=datenum('2016-10-05 00:00:00') & time1(:,1)<=datenum('2016-10-11 00:00:00'));
SID = find(timed1(:,1)>=datenum('2019-09-02 00:00:00') & timed1(:,1)<=datenum('2019-09-08 00:00:00'));


clear a_x2 a_x S_MT

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(GA_M(IM,1))-1):length(SIM);
% S_MT.total=interp1(a_x,sshtime1(1,SIM)',a_x2)'-1.0500;%-0.47
% S_MT.tide=interp1(a_x,sshtime2(1,SIM)',a_x2)'-1.0500; %-1.0500
S_MT.total=interp1(a_x,sshtime1(1,SIM)',a_x2)'+0.15;
S_MT.time=GA_M(IM,1);

clear a_x2 a_x S_DR
a_x=1:1:length(SID);
a_x2=1:(length(SID)-1)/(length(GA_D(ID,1))-1):length(SID);
S_DR.total=interp1(a_x,sshtime1_d(1,SID)',a_x2)'-0.2;
S_DR.time=GA_D(ID,1);

NOAA.mttotal=GA_M(IM,2);
NOAA.mttime=GA_M(IM,1);
NOAA.mttide=GA_M(IM,3);

NOAA.drtotal=GA_D(ID,2);
NOAA.drtime=GA_D(ID,1);
NOAA.drtide=GA_D(ID,3);

rmse.mt=sqrt(nanmean((S_MT.total-NOAA.mttotal).^2));
rmse.dr=sqrt(nanmean((S_DR.total-NOAA.drtotal).^2));
bias.mt=nanmean(S_MT.total-NOAA.mttotal)
bias.dr=nanmean(S_DR.total-NOAA.drtotal)

bias.percmt=(sum(S_MT.total)-sum(NOAA.mttotal))/sum(abs(NOAA.mttotal))*100
bias.percdr=(sum(S_DR.total)-sum(NOAA.drtotal))/sum(abs(NOAA.drtotal))*100
bias.percnoaamt=(sum(NOAA.mttide)-sum(NOAA.mttotal))/sum(abs(NOAA.mttotal))*100
bias.percnoaadr=(sum(NOAA.drtide)-sum(NOAA.drtotal))/sum(abs(NOAA.drtotal))*100


ARE_mt=nanmean(abs((S_MT.total-NOAA.mttotal)./NOAA.mttotal))
ARE_mt=nanmean(abs((NOAA.mttide-NOAA.mttotal)./NOAA.mttotal))




mean(abs((NOAA.mttide-NOAA.mttotal)./NOAA.mttotal))

ARE_DR=sqrt(nanmean((S_MT.total-GA_M(IM,2)).^2));


rmse_dr.total=sqrt(nanmean((S_DR.total-0.4700-GA_D(ID,2)).^2));
rmse_dr.tide=sqrt(nanmean((S_DR.tide-1.05-GA_D(ID,3)).^2));


%%

h=figure('units','normalized','position',[0 0 1 0.7]);
set(h, 'Visible', 'on');



clf

figure(1)
clf
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
plot(time1,sshtime1-0.0710,'-r','linewidth', 4);hold on
plot(GA_M(:,1),GA_M(:,2),'-b','linewidth',4);hold on
plot(GA_M(:,1),GA_M(:,3),'-g','linewidth',4);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 3]);
datetick('x','mmm-dd','keepticks')
% legend('Total water level-Model','Total water level-Observation','Tide-Model','Tide-Observation')
% legend('TWL_{mdl}','TWL_{NOAA}','Tide_{mdl}','Tide_{NOAA}')
ylabel('')
set(gca,'XTickLabel',[]);

set(gca,'YTickLabel',[]);

% xlabel('Matthew (2016)','FontWeight','bold')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.4;
set(gcf,'color','k')
set(gca, 'FontSize', 36)
set(gca,'Color','k')
set(gca, 'YColor', 'w');
set(gca, 'XColor', 'w');
set(gca,'linewidth',4)

h2=subplot(2,1,2);
startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');
plot(S_DR.time,S_DR.total,'-r','linewidth', 4);hold on
plot(NOAA.drtime,NOAA.drtotal,'-b','linewidth',4);hold on
plot(NOAA.drtime,NOAA.drtide,'-g','linewidth',4);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 3]);
datetick('x','mmm-dd','keepticks')
% legend('Total water level-Model','Total water level-Observation','Tide-Model','Tide-Observation')
% legend('TWL_{mdl}','TWL_{NOAA}','Tide_{mdl}','Tide_{NOAA}')
ylabel('Water (m)')
% xlabel('Dorian (2019)','FontWeight','bold')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.4;
set(gca,'Color','k')
set(gcf,'color','k')
set(gca, 'FontSize', 36)
set(h2, 'YColor', 'w');
set(h2, 'XColor', 'w');
set(gca,'linewidth',4)



