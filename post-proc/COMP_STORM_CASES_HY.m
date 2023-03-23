clc
clear all
close all


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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-hy-dv-v2.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-hy-dv-new-rd.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-hy-dv-new-rd-no-rain.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-hy-dv-new-rd.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-hy-dv-v2.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-hy-dv-new-rd.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-hy-dv-v2.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-hy-dv-new-rd.nc'],'NC_NOWRITE');

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

lat_s = 32.03455;
lon_s = -80.902494;

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

ID = find(GA_D(:,1)>=datenum('2019-09-01 00:00:00') & GA_D(:,1)<=datenum('2019-09-07 23:00:00'));
IM = find(GA_M(:,1)>=datenum('2016-10-04 00:00:00') & GA_M(:,1)<=datenum('2016-10-10 23:00:00'));
NX= [0:(7)/1670:7];


figure(1)
clf
os=0;
skp=20;

plot(time4(1:168,1)/(60*60*24),sshtime4(1,1:168)+os,'-.r','linewidth', 2,'MarkerSize',15); hold on
plot(time5(1:168,1)/(60*60*24),sshtime5(1,1:168)+os,'-.b','linewidth', 2,'MarkerSize',15); 

axis([0 7 -1.5 2.5]);
legend('Hy-dv-no-rain','Hy-dv')

ylabel('Water level (m)')
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')



figure(1)
clf
os=0;
skp=20;

plot(NX(1:skp:end),GA_M(IM(1:skp:end),4)-0.25,'-.k','linewidth',2,'MarkerSize',15); hold on
plot(time1(1:168,1)/(60*60*24),sshtime1(1,1:168)+os,'-k','linewidth', 2); 
plot(time2(1:168,1)/(60*60*24),sshtime2(1,1:168)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(time3(1:168,1)/(60*60*24),sshtime3(1,1:168)+os,'-b','linewidth', 2,'MarkerSize',15); 
plot(time4(1:168,1)/(60*60*24),sshtime4(1,1:168)+os,'-.r','linewidth', 2,'MarkerSize',15); 
plot(time5(1:168,1)/(60*60*24),sshtime5(1,1:168)+os,'-.b','linewidth', 2,'MarkerSize',15); 
% plot(time2(1:168,1)/(60*60*24),sshtime1(1,1:168)-(sshtime2(1,1:168)+sshtime3(1,1:168)),'-m','linewidth', 2,'MarkerSize',15); 
% plot(time2(1:168,1)/(60*60*24),sshtime1(1,1:168)-(sshtime4(1,1:168)+sshtime5(1,1:168)),'-.m','linewidth', 2,'MarkerSize',15); 
% 

% plot(NX(1:skp:end),GA_M(IM(1:skp:end),4)-0.4,'-.k','linewidth',2); 
axis([0 7 -1.5 2.5]);
% legend('Observation','Ref.','At-dv','Oc-dv','At-dv-v2','Oc-dv-v2','res','res-v2')
legend('Observation','Ref.','At-dv','Oc-dv','Hy-dv','Hy-dv-no-rain')

ylabel('Water level (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')



figure(1)
clf
os=0;
skp=20;

subplot(2,1,1)
% plot(NX(1:skp:end),GA_M(IM(1:skp:end),4)-0.25,'-.k','linewidth',2,'MarkerSize',15); hold on
plot(time1(1:168,1)/(60*60*24),sshtime1(1,1:168)+os,'-k','linewidth', 2); hold on
plot(time2(1:168,1)/(60*60*24),sshtime2(1,1:168)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(time3(1:168,1)/(60*60*24),sshtime3(1,1:168)+os,'-b','linewidth', 2,'MarkerSize',15); 
% plot(time4(1:168,1)/(60*60*24),sshtime4(1,1:168)+os,'-g','linewidth', 2,'MarkerSize',15); 
% plot(time5(1:168,1)/(60*60*24),sshtime5(1,1:168)+os,'-y','linewidth', 2,'MarkerSize',15); 
% plot(time2(1:168,1)/(60*60*24),sshtime1(1,1:168)-(sshtime2(1,1:168)+sshtime3(1,1:168)+sshtime4(1,1:168)),'-m','linewidth', 2,'MarkerSize',15); 
% plot(time2(1:168,1)/(60*60*24),sshtime1(1,1:168)-(sshtime2(1,1:168)+sshtime3(1,1:168)+sshtime5(1,1:168)),'-.m','linewidth', 2,'MarkerSize',15); 


% plot(NX(1:skp:end),GA_M(IM(1:skp:end),4)-0.4,'-.k','linewidth',2); 
axis([0 7 -1.5 2.5]);
legend('Ref.','Hy','Hy-new-rd')
xlabel('Days')
ylabel('Water level (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')


% plot(time_nfdr2/(60*60*24),sshtime4-m_sshtime4+os,'xr','linewidth', 2,'MarkerSize',15); 
% plot(time_nfdr3/(60*60*24),sshtime5-m_sshtime5+os,'om','linewidth', 2); 
% plot(time_nfdr4/(60*60*24),sshtime6-m_sshtime6+os,'om','linewidth', 2); 
subplot(2,1,2)
os=0;
% plot(NX(1:skp:end),GA_D(ID(1:skp:end),4)-0.4,'-.k','linewidth',2,'MarkerSize',15); hold on
plot(timed1(1:168,1)/(60*60*24),sshtime1_d(1,1:168)+os,'-k','linewidth', 2); hold on
plot(timed2(1:168,1)/(60*60*24),sshtime2_d(1,1:168)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(timed3(1:168,1)/(60*60*24),sshtime3_d(1,1:168)+os,'-b','linewidth', 2,'MarkerSize',15); 
% plot(timed4(1:168,1)/(60*60*24),sshtime4_d(1,1:168)+os,'-g','linewidth', 2,'MarkerSize',15); 
% plot(timed5(1:168,1)/(60*60*24),sshtime5_d(1,1:168)+os,'-y','linewidth', 2,'MarkerSize',15); 
% plot(time2(1:168,1)/(60*60*24),sshtime1_d(1,1:168)-(sshtime2_d(1,1:168)+sshtime3_d(1,1:168)),'-m','linewidth', 2,'MarkerSize',15); 
% 

legend('Ref.','Hy','Hy-new-rd')

axis([0 7 -1.5 2.5]);
% datetick('x','mm-dd','keeplimits')
xlabel('Days')
ylabel('Water level (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')

return

figure(2)

clf
os=0;
skp=20;

plot(time4(1:168,1)/(60*60*24),sshtime4(1,1:168)+os,'-g','linewidth', 2,'MarkerSize',15); hold on
plot(time5(1:168,1)/(60*60*24),sshtime5(1,1:168)+os,'-y','linewidth', 2,'MarkerSize',15); 

plot(timed4(1:168,1)/(60*60*24),sshtime4_d(1,1:168)+os,'-.g','linewidth', 2,'MarkerSize',15); 
plot(timed5(1:168,1)/(60*60*24),sshtime5_d(1,1:168)+os,'-.y','linewidth', 2,'MarkerSize',15); 


legend('MT-hv','MT-zero','DR-hv','DR-zero')

axis([0 7 -1.5 2.5]);
% datetick('x','mm-dd','keeplimits')
xlabel('Days')
ylabel('Water level (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')



figure(1)
clf
subplot(2,1,1)
% plot(time1/(60*60*24),sshtime1-m_sshtime1+os,'-r','linewidth', 2); hold on
% plot(time2/(60*60*24),sshtime2-m_sshtime2+os,'xr','linewidth', 2,'MarkerSize',15); 
% plot(time3/(60*60*24),sshtime3-m_sshtime3+os,'or','linewidth', 2,'MarkerSize',15); 
plot(time1(1:168,1)/(60*60*24),sshtime1(1,1:168)+os,'-k','linewidth', 2); hold on
plot(time2(1:168,1)/(60*60*24),sshtime2(1,1:168)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(time3(1:168,1)/(60*60*24),sshtime3(1,1:168)+os,'-b','linewidth', 2,'MarkerSize',15); 
% plot(time3(1:168,1)/(60*60*24),sshtime1(1,1:168)-(sshtime2(1,1:168)+sshtime3(1,1:168)),'-m','linewidth',2); 
% plot(NX(1:skp:end),GA_M(IM(1:skp:end),4)-0.4,'ok','linewidth',2,'MarkerSize',15); 
% plot(NX(1:skp:end),GA_M(IM(1:skp:end),4)-0.4,'-.k','linewidth',2); 
xlabel('Days')
ylabel('Water level (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')
legend('Ref.','Const. BC','Const. SF','Residual')


% plot(time_nfdr2/(60*60*24),sshtime4-m_sshtime4+os,'xr','linewidth', 2,'MarkerSize',15); 
% plot(time_nfdr3/(60*60*24),sshtime5-m_sshtime5+os,'om','linewidth', 2); 
% plot(time_nfdr4/(60*60*24),sshtime6-m_sshtime6+os,'om','linewidth', 2); 
subplot(2,1,2)
% 
% plot(timed1/(60*60*24),sshtime1_d-m_sshtime1_d+os,'-b','linewidth', 2); 
% plot(timed2/(60*60*24),sshtime2_d-m_sshtime2_d+os,'xb','linewidth', 2,'MarkerSize',15);
% plot(timed3/(60*60*24),sshtime3_d-m_sshtime3_d+os,'ob','linewidth', 2,'MarkerSize',15); 
plot(timed1(1:168,1)/(60*60*24),sshtime1_d(1,1:168)+os,'-k','linewidth', 2); hold on
plot(timed2(1:168,1)/(60*60*24),sshtime2_d(1,1:168)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(timed3(1:168,1)/(60*60*24),sshtime3_d(1,1:168)+os,'-b','linewidth', 2,'MarkerSize',15); 
% plot(timed3(1:168,1)/(60*60*24),sshtime1_d(1,1:168)-(sshtime2_d(1,1:168)+sshtime3_d(1,1:168)),'-m','linewidth',2);
% plot(NX(1:skp:end),GA_D(ID(1:skp:end),4)-0.2,'-.k','linewidth',2); 

% legend('ref-m','hydro-m','atdr-m','at0-m','at-0/hydro-m','ref-d','hydro-d','atmt-d','at0-d','at0/hydro-d')
% legend('ref-m','hydro-m','atdr-m','at0-m','ref-d','hydro-d','atmt-d','at0-d')
% legend('Matthew-ref','Matthew-0 atm.','Matthew-w/o hydro.','Dorian-ref','Dorian-0 atm.','Dorian-w/o hydro.')
% legend('Matthew-ref','Matthew-0 atm.','Matthew-Dorian atm.','Matthew-w/o hydro.','Dorian-ref','Dorian-0 atm.','Dorian-Matthew atm','Dorian-w/o hydro.')
legend('Ref.','Const. BC','Const. SF','Residual')
% legend('Matthew-ref','Matthew-Dorian atm.','Matthew-bc-fz','Matthew-sf-fz','Dorian-ref','Dorian-Matthew atm','Dorian-bc-fz','Dorian-sf-fz')

axis([0 7 -1 2]);
% datetick('x','mm-dd','keeplimits')
xlabel('Days')
ylabel('Water level (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')

return



%%

os=-0.04;
skp=1;

figure(1)
clf

% plot(time1(1:168,1)/(60*60*24),sshtime1(1,1:168)-m_sshtime1+os,'-k','linewidth', 2); hold on
% plot(time2(1:168,1)/(60*60*24),sshtime2(1,1:168)-m_sshtime2,'-r','linewidth', 2,'MarkerSize',15); hold on
% plot(time3(1:168,1)/(60*60*24),sshtime3(1,1:168)-m_sshtime3+os,'-b','linewidth', 2,'MarkerSize',15); hold on
plot(time3(1:168,1)/(60*60*24),sshtime1(1,1:168)-(sshtime2(1,1:168)+sshtime3(1,1:168))-mean(sshtime1(1,1:168)-(sshtime2(1,1:168)+sshtime3(1,1:168))),'-m','linewidth',2); hold on

% plot(timed1(1:168,1)/(60*60*24),sshtime1_d(1,1:168)-m_sshtime1_d+os,'-.k','linewidth', 2); 
% plot(timed2(1:168,1)/(60*60*24),sshtime2_d(1,1:168)-m_sshtime2_d+os,'-.r','linewidth', 2,'MarkerSize',15); 
% plot(timed3(1:168,1)/(60*60*24),sshtime3_d(1,1:168)-m_sshtime3_d+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(timed3(1:168,1)/(60*60*24),sshtime1_d(1,1:168)-(sshtime2_d(1,1:168)+sshtime3_d(1,1:168))-mean(sshtime1_d(1,1:168)-(sshtime2_d(1,1:168)+sshtime3_d(1,1:168))),'-.m','linewidth',2);

legend('Matthew','Dorian')

% axis([0 7 -1 2]);
xlabel('Days')
ylabel('Water level (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')

return
