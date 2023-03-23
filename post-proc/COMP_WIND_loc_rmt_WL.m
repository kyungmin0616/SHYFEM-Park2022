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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide.nc'],'NC_NOWRITE');

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

ssh1=ssh;
time1=time;

clear ssh time

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-at-dv-local.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-at-dv-remote-wp-0.nc'],'NC_NOWRITE');

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

ssh3=ssh;
time3=time;

clear ssh time
% 
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-at-dv-wo-ssh.nc'],'NC_NOWRITE');
% 
% % Get information about the contents of the file.
% [numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
% 
% for ii = 0:(numvars-1)
%    % Get information about the variables in the file.
%    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
%    field{ii+1}.name = varname;
% 
%    % Get variable IDs
%    varid = netcdf.inqVarID(ncid,varname);
% 
%    % Get the value of all variables
%    field{ii+1}.data = netcdf.getVar(ncid,varid);
% end
% 
% % parameters for map
% time=field{5}.data;
% ssh=field{10}.data;
% 
% ssh4=ssh;
% time4=time;
% 
% clear ssh time
% 
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-hy-dv-v2.nc'],'NC_NOWRITE');
% 
% % Get information about the contents of the file.
% [numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
% 
% for ii = 0:(numvars-1)
%    % Get information about the variables in the file.
%    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
%    field{ii+1}.name = varname;
% 
%    % Get variable IDs
%    varid = netcdf.inqVarID(ncid,varname);
% 
%    % Get the value of all variables
%    field{ii+1}.data = netcdf.getVar(ncid,varid);
% end
% 
% % parameters for map
% time=field{5}.data;
% ssh=field{10}.data;
% 
% ssh5=ssh;
% time5=time;
% 
% clear ssh time


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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide.nc'],'NC_NOWRITE');

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

sshd1=ssh;
timed1=time;

clear ssh time


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-at-dv-local.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-at-dv-remote-wp-0.nc'],'NC_NOWRITE');

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

sshd3=ssh;
timed3=time;

clear ssh time

% 
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-18h-tide.nc'],'NC_NOWRITE');
% 
% % Get information about the contents of the file.
% [numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
% 
% for ii = 0:(numvars-1)
%    % Get information about the variables in the file.
%    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
%    field{ii+1}.name = varname;
% 
%    % Get variable IDs
%    varid = netcdf.inqVarID(ncid,varname);
% 
%    % Get the value of all variables
%    field{ii+1}.data = netcdf.getVar(ncid,varid);
% end
% 
% % parameters for map
% time=field{5}.data;
% ssh=field{10}.data;
% 
% sshd4=ssh;
% timed4=time;
% 
% clear ssh time


% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-zero-dv.nc'],'NC_NOWRITE');
% 
% % Get information about the contents of the file.
% [numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
% 
% for ii = 0:(numvars-1)
%    % Get information about the variables in the file.
%    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
%    field{ii+1}.name = varname;
% 
%    % Get variable IDs
%    varid = netcdf.inqVarID(ncid,varname);
% 
%    % Get the value of all variables
%    field{ii+1}.data = netcdf.getVar(ncid,varid);
% end
% 
% % parameters for map
% time=field{5}.data;
% ssh=field{10}.data;
% 
% sshd5=ssh;
% timed5=time;
% 
% clear ssh time

%%%%%%%%%%%%%%%%%%%%%%%%%

lat_s = 32.03455;
lon_s = -80.902494;

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
% sshtime4=squeeze(ssh4(index_dist,:));
% m_sshtime4=mean(sshtime4);
% sshtime5=squeeze(ssh5(index_dist,:));
% m_sshtime5=mean(sshtime5);


sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);
sshtime2_d=squeeze(sshd2(index_dist,:));
m_sshtime2_d=mean(sshtime2_d);
sshtime3_d=squeeze(sshd3(index_dist,:));
m_sshtime3_d=mean(sshtime3_d);
% sshtime4_d=squeeze(sshd4(index_dist,:));
% m_sshtime4_d=mean(sshtime4_d);
% sshtime5_d=squeeze(sshd5(index_dist,:));
% m_sshtime5_d=mean(sshtime5_d);

% return

%Plotting

figure(1)


h=figure('units','normalized','position',[0 0 0.8 0.7]);
set(h, 'Visible', 'on');

clf

os=0;
skp=20;
TP=240;

% Matthew
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
refDate = datenum('2016-10-04 00:00:00');

subplot(2,1,1)
plot(GA_M(:,1),GA_M(:,4),'-.k','linewidth', 2); hold on
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+time2(1:TP,1)/(60*60*24),sshtime2(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+os,'-b','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(1:TP,1)/(60*60*24),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP))+os,'-m','linewidth', 2,'MarkerSize',15); 
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','mmm-dd','keepticks')
ylim([-1.5 2.5])
legend({'Obs.','MT-BS','MT-LF','MT-RF','Residual'},'FontSize',20)
xlabel('Date (2016)')
ylabel('Storm surge (m)')
title('Hurricane Matthew')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 28)

% Dorian
subplot(2,1,2)
os=0;

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

refDate = datenum('2019-09-01 00:00:00');
plot(GA_D(:,1),GA_D(:,4),'-.k','linewidth', 2); hold on
plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+timed2(1:TP,1)/(60*60*24),sshtime2_d(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(1:TP,1)/(60*60*24),sshtime3_d(1,1:TP)+os,'-b','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)-(sshtime2_d(1,1:TP)+sshtime3_d(1,1:TP))+os,'-m','linewidth', 2,'MarkerSize',15); 
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
yticks([-1 -0.5 0 0.5 1 1.5])
datetick('x','mmm-dd','keepticks')
ylim([-1 1.5])
% legend('Obs.','DR-BS','DR-LF','DR-RF','Residual')
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Dorian')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
set(gcf,'color','w')
set(gca, 'FontSize', 28)
legend({'Obs.','DR-BS','DR-LF','DR-RF','Residual'},'FontSize',20)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_10.png',1));


return

%%
figure(1)


h=figure('units','normalized','position',[0 0 0.8 0.7]);
set(h, 'Visible', 'on');

% clf
os=0;
skp=20;
TP=24*7;
sdt=24*2+1;
ctlt=+2;

startDate = datenum('10-06-2016');
endDate = datenum('10-10-2016');
refDate = datenum('2016-10-04 00:00:00');

subplot(2,1,1)
plot(refDate+time1(sdt:TP,1)/(60*60*24),sshtime1(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+time2(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+sshtime3(1,sdt+ctlt:TP+ctlt),'-.k','linewidth', 2,'MarkerSize',15); 
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','mmm-dd','keeplimits')
ylim([-1 2])
legend({'MT-BS','MT-LF','MT-RF (Shifted)','Reconstruction'},'FontSize',20)
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Matthew')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
startDate = datenum('09-03-2019');
endDate = datenum('09-07-2019');
refDate = datenum('2019-09-01 00:00:00');
ctlt=+14;
os=0;
plot(refDate+timed1(sdt:TP,1)/(60*60*24),sshtime1_d(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+timed2(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3_d(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+sshtime3_d(1,sdt+ctlt:TP+ctlt),'-.k','linewidth', 2,'MarkerSize',15); 
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
set(gca,'YLim',[-1 1],'YTick',[-1:0.5:1])
datetick('x','mmm-dd','keeplimits')
legend({'DR-BS','DR-LF','DR-RF (Shifted)','Reconstruction'},'FontSize',20)
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Dorian')
box on
grid on
set(gcf,'color','w')
set(gcf,'color','w')
set(gca, 'FontSize', 28)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_11.png',1));


%%
clf
os=0;
skp=20;
TP=24*7;
sdt=24*2+1;
ctlt=+2;

startDate = datenum('10-06-2016');
endDate = datenum('10-10-2016');
refDate = datenum('2016-10-04 00:00:00');

subplot(2,1,1)
plot(time1(sdt:TP,1)/(60*60*24),sshtime1(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(time2(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(time3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(time3(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+sshtime3(1,sdt+ctlt:TP+ctlt),'-.k','linewidth', 2,'MarkerSize',15); 
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
% datetick('x','mm-dd','keepticks')
ylim([-1 2])
legend('MT-BS','MT-LAD','MT-RAD (Shifted)','LAD + RAD (Shifted)')
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Dorian')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
startDate = datenum('09-03-2019');
endDate = datenum('09-07-2019');
refDate = datenum('2019-09-01 00:00:00');
ctlt=+14;
os=0;
plot(timed1(sdt:TP,1)/(60*60*24),sshtime1_d(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(timed2(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(timed3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3_d(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(timed3(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+sshtime3_d(1,sdt+ctlt:TP+ctlt),'-.k','linewidth', 2,'MarkerSize',15); 
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
% set(gca,'YLim',[-1 1],'YTick',[-1:0.5:1])
datetick('x','mm-dd','keepticks')
legend('MT-BS','MT-LAD','MT-RAD (Shifted)','LAD + RAD (Shifted)')
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Dorian')
box on
grid on
set(gcf,'color','w')
set(gcf,'color','w')
set(gca, 'FontSize', 28)



