clc
clear all
close all


%%%%%%%%%% MATTHEW %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = str2double(table2array(GA_I(:,5)));
GA_M(:,3) = str2double(table2array(GA_I(:,3)));
GA_M(:,4) = GA_M(:,2)-GA_M(:,3);

clear GA_I date1 date2

%%%%%%%%%% MATTHEW %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_D(:,1)=datenum(strcat(date1,{' '},date2));
GA_D(:,2) = str2double(table2array(GA_I(:,5)));
GA_D(:,3) = str2double(table2array(GA_I(:,3)));
GA_D(:,4) = GA_D(:,2)-GA_D(:,3);

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-ref.nc'],'NC_NOWRITE');

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
ssh=field{10}.data;

%Matthew
refDate = datenum('2016-10-04 00:00:00');
time_r=time/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-ref.nc'],'NC_NOWRITE');

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
timed=field{5}.data;
sshd=field{10}.data;


%Dorian
refDate2 = datenum('2019-09-01 00:00:00');
time_r2=timed/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate2;




lat_s = 32.03455;
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh(index_dist,:));
m_sshtime1=mean(sshtime1);

sshtime2=squeeze(sshd(index_dist,:));
m_sshtime2=mean(sshtime2);

startDate=time_r(25);
endDate=time_r(end-71);

startDated=time_r2(25);
endDated=time_r2(end-70);


h=figure('units','normalized','position',[0 0 0.7 0.6]);
set(h, 'Visible', 'on');


% subplot(2,1,1)
clf
plot(time_r,sshtime1+0.18,'r','linewidth', 2); hold on
plot(GA_M(:,1),GA_M(:,2)-mean(GA_M(:,2)),'b','linewidth', 2);
plot(GA_M(:,1),GA_M(:,3)-mean(GA_M(:,3)),'g','linewidth', 2);
legend('Model','NOAA observation','NOAA prediction')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/5:endDate])
set(gca,'YLim',[-2.5 2.5],'YTick',[-2.5:1:2.5])
datetick('x','mm-dd','keeplimits')
xlabel('Date (2016)')
ylabel('m')
title('Hurricane Matthew season','FontSize',12)
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'FontSize',22)

subplot(2,1,2)
plot(time_r2,sshtime2,'r','linewidth', 2); hold on
plot(GA_D(:,1),GA_D(:,2)-mean(GA_D(:,2)),'b','linewidth', 2);
legend('Model','Observation')
set(gca,'XLim',[startDated endDated],'XTick',[startDated:(endDated-startDated)/5:endDated])
set(gca,'YLim',[-2.5 2.5],'YTick',[-2.5:1:2.5])
datetick('x','mm-dd','keeplimits')
xlabel('Date (2019)')
ylabel('m')
title('Hurricane Dorian season','FontSize',12)
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'FontSize',22)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/fig_100.png',1));

