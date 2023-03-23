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

% t_tide(NOAA_DR(:,2));
% lowpass(NOAA_MT(:,2),24)
%% MODEL

%Matthew
refDate = datenum('2016-10-04 00:00:00');

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-only-tide-at1.nc'],'NC_NOWRITE');

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


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-only-tide-8tc.nc'],'NC_NOWRITE');

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
time2=refDate+field{5}.data/(60*60*24);
ssh2=field{10}.data;

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-only-tide-14tc.nc'],'NC_NOWRITE');

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
time3=refDate+field{5}.data/(60*60*24);
ssh3=field{10}.data;



%Dorian
refDated = datenum('2019-09-01 00:00:00');

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
timed=refDated+field{5}.data/(60*60*24);
sshd=field{10}.data;


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-only-tide-8tc.nc'],'NC_NOWRITE');

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
timed2=refDated+field{5}.data/(60*60*24);
sshd2=field{10}.data;

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-only-tide-14tc.nc'],'NC_NOWRITE');

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
timed3=refDated+field{5}.data/(60*60*24);
sshd3=field{10}.data;



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



% sc=0.48;
% Fort Pulaski
% h1=subplot(4,2,1);
lat_s = 32.03455;
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh(index_dist,:));
sshtime2=squeeze(ssh2(index_dist,:));
sshtime3=squeeze(ssh3(index_dist,:));
sshtimed1=squeeze(sshd(index_dist,:));
sshtimed2=squeeze(sshd2(index_dist,:));
sshtimed3=squeeze(sshd3(index_dist,:));

% %rmse
% tg_obs=NOAA_MT;
% tg_mdl=time;
% 
% st_obs=find(tg_obs(:,1)==startDate);
% et_obs=find(tg_obs(:,1)==endDate);
% st_mdl=find(tg_mdl==startDate);
% et_mdl=find(tg_mdl==endDate);
% obs=tg_obs(st_obs:et_obs,2);
% mdl_ori=sshtime1(1,st_mdl:et_mdl)+sc;
% mdl=interp1(tg_mdl(st_mdl:et_mdl),mdl_ori',tg_obs(st_obs:et_obs,1));
% rmse=sqrt(nanmean((mdl-obs).^2));

%plot
figure(1)
clf
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
subplot(2,1,1)
plot(time,sshtime1,'-r','linewidth', 3);hold on
plot(time2,sshtime2,'-g','linewidth', 3);hold on
plot(time3,sshtime3,'-m','linewidth', 3);hold on
plot(NOAA_MT(:,1),NOAA_MT(:,3),'-b', 'LineWidth', 2)
% text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);
xlim([startDate endDate])
% ylim([-1 1])
datetick('x','mmm-dd HH','keepticks')
% set(gca,'XTickLabel',[]);
% legend('SHYFEM','Observation')
legend('BASE','8TC','14TC','OBS')
% set(gca,'XTickLabel',[]);
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('NOAA 8670870','FontSize',16)
ylabel('Water level (m)')
set(gca,'FontSize',18)
set(gcf,'color','w')

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');
subplot(2,1,2)
plot(timed,sshtimed1,'-r','linewidth', 3);hold on
plot(timed2,sshtimed2,'-g','linewidth', 3);hold on
plot(timed3,sshtimed3,'-m','linewidth', 3);hold on
plot(NOAA_DR(:,1),NOAA_DR(:,3),'-b', 'LineWidth', 2)
% text(startDate+0.03,2.5, ['RMSE = ',num2str(rmse,'%.2f')],'fontsize',18);
xlim([startDate endDate])
% ylim([-1 1])
datetick('x','mmm-dd HH','keepticks')
% set(gca,'XTickLabel',[]);
% legend('SHYFEM','Observation')
legend('BASE','8TC','14TC','OBS')

% set(gca,'XTickLabel',[]);
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('NOAA 8670870','FontSize',16)
ylabel('Water level (m)')
set(gca,'FontSize',18)
set(gcf,'color','w')




