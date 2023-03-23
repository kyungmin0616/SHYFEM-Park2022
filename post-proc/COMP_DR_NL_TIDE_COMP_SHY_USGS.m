clc
clear all
close all


%%%%%%%%%% MATTHEW %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = str2double(table2array(GA_I(:,5)));
GA_M(:,3) = str2double(table2array(GA_I(:,3)));
GA_M(:,4) = GA_M(:,2)-GA_M(:,3);



% Netcdf file
ncid = netcdf.open(['dorian-wo-ssh-sp-fz.nc'],'NC_NOWRITE');

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

% Netcdf file
ncid = netcdf.open(['dorian-sp-fz.nc'],'NC_NOWRITE');

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
element_index_exp=field{1}.data(1:3,:)';
lon_exp=field{4}.data;
lat_exp=field{2}.data;
time_exp=field{5}.data;
ssh_exp=field{10}.data;


refDate = datenum('2019-09-01 00:00:00');
time_r=time/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;
refDate = datenum('2019-09-01 00:00:00');
time_r2=time_exp/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;




lat_s = 32.03455;
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh(index_dist,:));
m_sshtime1=mean(sshtime1);

dist = (lat_exp' - lat_s).^2+(lon_exp' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime2=squeeze(ssh_exp(index_dist,:));
m_sshtime2=mean(sshtime2);


figure(1)
clf
% scatter(time_r,sshtime1-m_sshtime1,60,'filled')
plot(time_r,sshtime1,'r','linewidth', 2); hold on
plot(time_r2,sshtime2,'g','linewidth', 2); 
plot(GA_M(:,1),GA_M(:,3)-mean(GA_M(:,3)),'b','linewidth', 2);
legend('wo ssh','w ssh','Obs')
axis([time_r(1) time_r(end) -1.5 1.8]);
datetick('x','mm-dd','keepticks')
% xlabel('Septemper (2019)')
ylabel('h (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 16)



%Plotting

os=0;
figure(1)

subplot(2,2,1)
plot(time_ref/(60*60*24),sshtime1-m_sshtime1+os,'-r','linewidth', 2); hold on
plot(time_atdr/(60*60*24),sshtime2-m_sshtime2+os,'or','linewidth', 2,'MarkerSize',15); 
plot(time_nfdr/(60*60*24),sshtime3-m_sshtime3+os,'^r','linewidth', 2,'MarkerSize',15); 
plot(time_nfdr2/(60*60*24),sshtime4-m_sshtime4+os,'xr','linewidth', 2,'MarkerSize',15); 
% plot(time_nfdr3/(60*60*24),sshtime5-m_sshtime5+os,'om','linewidth', 2); 
% plot(time_nfdr4/(60*60*24),sshtime6-m_sshtime6+os,'om','linewidth', 2); 

% 
% plot(time_ref_d/(60*60*24),sshtime1_d-m_sshtime1_d+os,'-b','linewidth', 2); hold on
% plot(time_atdr_d/(60*60*24),sshtime2_d-m_sshtime2_d+os,'ob','linewidth', 2,'MarkerSize',15); 
% plot(time_nfdr_d/(60*60*24),sshtime3_d-m_sshtime3_d+os,'^b','linewidth', 2,'MarkerSize',15);
% plot(time_nfdr_d2/(60*60*24),sshtime4_d-m_sshtime4_d+os,'xb','linewidth', 2,'MarkerSize',15); 
% % plot(time_nfdr_d3/(60*60*24),sshtime5_d-m_sshtime5_d+os,'-m','linewidth', 2); 

% legend('ref-m','hydro-m','atdr-m','at0-m','at-0/hydro-m','ref-d','hydro-d','atmt-d','at0-d','at0/hydro-d')
% legend('ref-m','hydro-m','atdr-m','at0-m','ref-d','hydro-d','atmt-d','at0-d')
% % legend('Matthew-ref','Matthew-0 atm.','Matthew-w/o hydro.','Dorian-ref','Dorian-0 atm.','Dorian-w/o hydro.')
% % legend('Matthew-ref','Matthew-0 atm.','Matthew-Dorian atm.','Matthew-w/o hydro.','Dorian-ref','Dorian-0 atm.','Dorian-Matthew atm','Dorian-w/o hydro.')
% legend('Matthew-ref','Matthew-Dorian atm.','Matthew-bc-fz','Matthew-sf-fz','Dorian-ref','Dorian-Matthew atm','Dorian-bc-fz','Dorian-sf-fz')
% legend('Matthew-ref','Matthew-Dorian atm.','Matthew-0 hydro','Dorian-ref','Dorian-Matthew atm','Dorian-0 hydro')
% legend('ref-m','atdr-m','at0-m','ref-d','atmt-d','at0-d')

% legend('Matthew-ref','Matthew-6h ST','Matthew-12h ST','Matthew-18h ST','Dorian-ref','Dorian-6h ST','Dorian-12h ST','Dorian-18h ST')
legend('Reference','6h ST','12h ST','18h ST')
% legend('Dorian-ref','Dorian-6h ST','Dorian-12h ST','Dorian-18h ST')

axis([3 5 -1.5 2.5]);
% datetick('x','mm-dd','keeplimits')
xlabel('Days')
ylabel('Water level (m)')
title('Simulation results - Matthew')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 18)
box on
grid on
set(gcf,'color','w')

subplot(2,2,2)

plot(time_ref_d/(60*60*24),sshtime1_d-m_sshtime1_d+os,'-b','linewidth', 2); hold on
plot(time_atdr_d/(60*60*24),sshtime2_d-m_sshtime2_d+os,'ob','linewidth', 2,'MarkerSize',15); 
plot(time_nfdr_d/(60*60*24),sshtime3_d-m_sshtime3_d+os,'^b','linewidth', 2,'MarkerSize',15);
plot(time_nfdr_d2/(60*60*24),sshtime4_d-m_sshtime4_d+os,'xb','linewidth', 2,'MarkerSize',15); 

legend('Reference','6h ST','12h ST','18h ST')

axis([3 5 -1.5 2.5]);
% datetick('x','mm-dd','keeplimits')
xlabel('Days')
ylabel('Water level (m)')
title('Simulation results - Dorian')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 18)
box on
grid on
set(gcf,'color','w')

return


