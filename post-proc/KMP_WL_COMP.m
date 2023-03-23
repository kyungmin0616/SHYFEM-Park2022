clc
clear all
close all


%% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/20161006/switchv2e_ous0.nc'],'NC_NOWRITE');

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

refDate = datenum('2016-10-05 00:00:00');
datestr(time/3600*(datenum('2019-05-28 01:00:00')-datenum('2019-05-28 00:00:00'))+refDate)
mdlT=time/3600*(datenum('2016-10-04 01:00:00')-datenum('2016-10-04 00:00:00'))+refDate;

% datestr(time_r)

% Target lon and lat

 lat_s = 32.03455;
 lon_s = -80.902494;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

mdlWL=squeeze(ssh(index_dist,:));
m_mdlWL=mean(mdlWL);


% figure; 
% plot(mdlT, mdlWL-m_mdlWL,'-r')
% graph_handle= gca;
% set(graph_handle,'fontsize', 22)
% set(graph_handle,'linewidth', 1)
% xlabel('Days','FontSize',22);
% ylabel('h (m)','FontSize',22);
% datetick('x','mmmdd')



%% Tide gauge
tideFP=readtable('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/CO-OPS_8670870_wl.csv');
date1=table2array(tideFP(:,1));
date2=table2array(tideFP(:,2));

tideT=datenum(strcat(date1,{' '},date2));
tideWL = str2double(table2array(tideFP(:,5)));

mtide=mean(tideWL);

% figure; 
% plot(tideT,tideWL-mtide,'-r')
% graph_handle= gca;
% set(graph_handle,'fontsize', 22)
% set(graph_handle,'linewidth', 1)
% xlabel('Days','FontSize',22);
% ylabel('Water level (m)','FontSize',22);
% set(gca,'FontSize',28)
% datetick('x','mmmdd')



%% Comparison btw obs and mod

xmin = datenum('2016-10-07 00:00:00');
xmax = datenum('2016-10-10 00:00:00');


figure; 
clf
plot(tideT,tideWL-mtide,'-k','linewidth', 2); hold on 
% plot(tideT,tideWL,'-k','linewidth', 2); hold on 

plot(mdlT,mdlWL-m_mdlWL,'-ob','linewidth', 2)
% plot(mdlT,mdlWL,'-or','linewidth', 2)

graph_handle= gca;
set(graph_handle,'fontsize', 22)
set(graph_handle,'linewidth', 1)
legend('obs','mod')
xlim([xmin xmax])
datetick('x','mmmdd','keeplimits')
xlabel('Days','FontSize',22);
ylabel('h (m)','FontSize',22);



