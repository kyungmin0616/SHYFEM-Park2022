clc
clear all
% close all


%%%%%%%%%%% MATTHEW

%%%%%%%%%% Observation %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = str2double(table2array(GA_I(:,5)));
GA_M(:,3) = str2double(table2array(GA_I(:,3)));
GA_M(:,4) = GA_M(:,2)-GA_M(:,3);


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
lon=field{4}.data;
lat=field{2}.data;
time=field{5}.data;
ssh=field{10}.data;
depth=-field{7}.data;

min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;

ssh1=ssh;
time1=time;

clear ssh time

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-6h-tide.nc'],'NC_NOWRITE');

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
time=field{5}.data;
ssh=field{10}.data;

ssh3=ssh;
time3=time;

clear ssh time


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-6h-only-tide.nc'],'NC_NOWRITE');

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

ssh4=ssh;
time4=time;

clear ssh time

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
time=field{5}.data;
ssh=field{10}.data;

ssh5=ssh;
time5=time;

clear ssh time

%%%%%%%%%%%%%%%%%%%%%%%%%%%% DORIAN

%%%%%%%%%% Observation %%%%%%%%%%%
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_D(:,1)=datenum(strcat(date1,{' '},date2));
GA_D(:,2) = str2double(table2array(GA_I(:,5)));
GA_D(:,3) = str2double(table2array(GA_I(:,3)));
GA_D(:,4) = GA_D(:,2)-GA_D(:,3);


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
time=field{5}.data;
ssh=field{10}.data;

sshd1=ssh;
timed1=time;

clear ssh time


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-6h-tide.nc'],'NC_NOWRITE');

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
time=field{5}.data;
ssh=field{10}.data;

sshd3=ssh;
timed3=time;

clear ssh time

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-6h-only-tide.nc'],'NC_NOWRITE');

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

sshd4=ssh;
timed4=time;

clear ssh time


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

sshd5=ssh;
timed5=time;

clear ssh time


%%%%%%%%%%%%%%%%%%%%%%%%%

lat_s = 32.03455;  % Fort Pulaski
lon_s = -80.902494;
% 
% lat_s = 31.4832;   % Sapelo
% lon_s = -81.3192;

% lat_s = 32.0847; % Savannah city
% lon_s = -81.0365;

% lat_s = 32.2018; % Upstream of Savannah river
% lon_s = -81.142;


% lat_s = 31.761316; % Blackbeard Creek 3
% lon_s = -81.271091;
% 
% lat_s = 31.707687; % Blackbeard Creek 2
% lon_s = -81.120906;
% 
% lat_s =  31.672922; % Blackbeard Creek 1
% lon_s = -80.945734;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);



sshtime1=squeeze(ssh1(index_dist,:));
m_sshtime1=mean(sshtime1);
sshtime2=squeeze(ssh2(index_dist,:));
m_sshtime2=mean(sshtime2);
sshtime3=squeeze(ssh3(index_dist,:));
m_sshtime3=mean(sshtime3);
sshtime4=squeeze(ssh4(index_dist,:));
m_sshtime4=mean(sshtime4);
sshtime5=squeeze(ssh5(index_dist,:));
m_sshtime5=mean(sshtime5);


sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);
sshtime2_d=squeeze(sshd2(index_dist,:));
m_sshtime2_d=mean(sshtime2_d);
sshtime3_d=squeeze(sshd3(index_dist,:));
m_sshtime3_d=mean(sshtime3_d);
sshtime4_d=squeeze(sshd4(index_dist,:));
m_sshtime4_d=mean(sshtime4_d);
sshtime5_d=squeeze(sshd5(index_dist,:));
m_sshtime5_d=mean(sshtime5_d);

return

%Plotting

% Tide vs NL
ast=25;

figure(5)
clf
subplot(2,1,1)
plot(sshtime3(1,ast:TP),sshtime1(1,ast:TP)-(sshtime3(1,ast:TP)+sshtime5(1,ast:TP)),'ok','linewidth', 2,'MarkerSize',15); hold on
plot(sshtime3_d(1,ast:TP),sshtime1_d(1,ast:TP)-(sshtime3_d(1,ast:TP)+sshtime5_d(1,ast:TP)),'or','linewidth', 2,'MarkerSize',15); 
box on
grid on
xlim([-1.5 1.5])
ylim([-0.3 0.2])
xlabel('Tide (m)')
ylabel('Interaction (m)')
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
plot(sshtime3(1,ast:TP),sshtime2(1,ast:TP)-(sshtime4(1,ast:TP)+sshtime5(1,ast:TP)),'ok','linewidth', 2,'MarkerSize',15); hold on
plot(sshtime3_d(1,ast:TP),sshtime2_d(1,ast:TP)-(sshtime4_d(1,ast:TP)+sshtime5_d(1,ast:TP)),'or','linewidth', 2,'MarkerSize',15); 
box on
grid on
xlim([-1.5 1.5])
ylim([-0.3 0.2])
xlabel('Tide (m)')
ylabel('Interaction (m)')
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 28)


%%
% Time history of each variable



h=figure('units','normalized','position',[0 0 0.8 0.7]);
set(h, 'Visible', 'off');

os=0;
TP=240;

% Matthew
% startDate = datenum('10-05-2016'); %Entire period
% endDate = datenum('10-11-2016');

startDate = datenum('10-07-2016'); %hurricane event
endDate = datenum('10-09-2016');

refDate = datenum('2016-10-04 00:00:00');

subplot(2,1,1)
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+time2(1:TP,1)/(60*60*24),sshtime2(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+os,'-.k','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sshtime4(1,1:TP)+os,'-.r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sshtime5(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 


% plot(refDate+time4(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+sshtime5(1,1:TP)+os,'-m','linewidth', 2,'MarkerSize',15); 
% plot(refDate+time4(1:TP,1)/(60*60*24),sshtime4(1,1:TP)+sshtime5(1,1:TP)+os,'-m','linewidth', 2,'MarkerSize',15); 


set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','dd HH:MM','keepticks')
ylim([-1.5 2.5])
yticks([-1.5 -1 -0.5 0 0.5 1 1.5 2 2.5])

% legend({'Obs.','MT-BS','MT-LF','MT-RF','Residual'},'FontSize',20)
legend('MT-ST','MT-ST6H','MT-OT','MT-OT6H','MT-OS')

xlabel('Date (2016-10-)')
ylabel('Water level (m)')
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

% startDate = datenum('09-02-2019'); %Entire period
% endDate = datenum('09-08-2019');

startDate = datenum('09-04-2019'); %hurricane event
endDate = datenum('09-06-2019');

refDate = datenum('2019-09-01 00:00:00');

plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+timed2(1:TP,1)/(60*60*24),sshtime2_d(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(1:TP,1)/(60*60*24),sshtime3_d(1,1:TP)+os,'-.k','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed4(1:TP,1)/(60*60*24),sshtime4_d(1,1:TP)+os,'-.r','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed5(1:TP,1)/(60*60*24),sshtime5_d(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 

% plot(refDate+timed5(1:TP,1)/(60*60*24),sshtime3_d(1,1:TP)+sshtime5_d(1,1:TP)+os,'-m','linewidth', 2,'MarkerSize',15); 
% plot(refDate+timed5(1:TP,1)/(60*60*24),sshtime4_d(1,1:TP)+sshtime5_d(1,1:TP)+os,'-m','linewidth', 2,'MarkerSize',15); 


set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
yticks([-1.5 -1 -0.5 0 0.5 1 1.5 2 2.5])
ylim([-1.5 2])
datetick('x','dd HH:MM','keepticks')
legend('DR-ST','DR-ST6H','DR-OT','DR-OT6H','DR-OS')
xlabel('Date (2019-09-)')
ylabel('Water level (m)')
title('Hurricane Dorian')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
set(gcf,'color','w')
set(gca, 'FontSize', 28)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_10.png',1));


return

%% NL profile

[MT ITT] = max(sshtime1(1,1:TP))
[MT2 ITT2] = max(sshtime2(1,1:TP))
[DT DTT] = max(sshtime1_d(1,1:TP))
[DT2 DTT2] = max(sshtime2_d(1,1:TP))



h=figure('units','normalized','position',[0 0 0.8 0.7]);
set(h, 'Visible', 'off');

figure(10)
clf
os=0;
TP=240;

% Matthew
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
refDate = datenum('2016-10-04 00:00:00');

% subplot(2,1,1)
plot(refDate+time(1:TP,1)/(60*60*24),sshtime1(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+time(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+os,'-b','linewidth', 2); hold on
plot(refDate+time(1:TP,1)/(60*60*24),sshtime5(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 
plot(refDate+time(1:TP,1)/(60*60*24),sshtime1(1,1:TP)-(sshtime3(1,1:TP)+sshtime5(1,1:TP)),'-m','linewidth', 2); hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','mmm-dd','keepticks')
% ylim([-2 2.5])
% legend({'Obs.','MT-BS','MT-LF','MT-RF','Residual'},'FontSize',20)
% legend('Total','NL','Total-6h','NL-6h','SS')
legend('Total water level','Tide','Storm surge','Nonlinear')

xlabel('Date (2016)')
ylabel('Water level (m)')
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

% plot(GA_D(:,1),GA_D(:,4)-0.13,'-.k','linewidth', 2); hold on
plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP),'-k','linewidth', 2); hold on
plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)-sshtime3_d(1,1:TP),'-.k','linewidth', 2); hold on

% plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)-sshtime3_d(1,1:TP)-sshtime5_d(1,1:TP),'-.k','linewidth', 2); hold on
% plot(refDate+timed2(1:TP,1)/(60*60*24),sshtime2_d(1,1:TP),'-r','linewidth', 2,'MarkerSize',15); 
% plot(refDate+timed2(1:TP,1)/(60*60*24),sshtime2_d(1,1:TP)-sshtime4_d(1,1:TP)-sshtime5_d(1,1:TP),'-.r','linewidth', 2,'MarkerSize',15); 
% plot(refDate+timed2(1:TP,1)/(60*60*24),sshtime5_d(1,1:TP),'-m','linewidth', 2,'MarkerSize',15); 

% plot(refDate+timed1(DTT,1)/(60*60*24),NL_DR(index_dist,1),'ok','MarkerSize',15)
% plot(refDate+timed1(DTT2,1)/(60*60*24),NL_DR_6H(index_dist,1),'or','MarkerSize',15)

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
% yticks([-1 -0.5 0 0.5 1 1.5])
datetick('x','mmm-dd','keepticks')
% ylim([-2 2])
% legend('Obs.','DR-BS','DR-LF','DR-RF','Residual')
legend('Total','NL','Total-6h','NL-6h','SS')

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
% legend({'Obs.','DR-BS','DR-LF','DR-RF','Residual'},'FontSize',20)




