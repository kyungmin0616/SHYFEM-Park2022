clc
% clear all
close all
clearvars -except ch x


%%%%%%%%%%% MATTHEW

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-ref.nc'],'NC_NOWRITE');

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

ssh_ref=ssh;
time_ref=time;
clearvars -except ssh_ref time_ref


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-6h-tide.nc'],'NC_NOWRITE');

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

ssh_atdr=ssh;
time_atdr=time;
clearvars -except ssh_ref time_ref ssh_atdr time_atdr


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-12h-tide.nc'],'NC_NOWRITE');

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

ssh_nfdr=ssh;
time_nfdr=time;
% clearvars -except ssh_ref time_ref ssh_atdr time_atdr ssh_nfdr time_nfdr ssh_ws0 time_ws0 lon lat element_index
clear time ssh


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-18h-tide.nc'],'NC_NOWRITE');

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

ssh_nfdr2=ssh;
time_nfdr2=time;

clear time ssh



% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-wo-tide-wo-hydro.nc'],'NC_NOWRITE');
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
% element_index=field{1}.data(1:3,:)';
% lon=field{4}.data;
% lat=field{2}.data;
% time=field{5}.data;
% ssh=field{10}.data;
% 
% ssh_nfdr3=ssh;
% time_nfdr3=time;

% 
% 
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/switchv1e_ous0.nc'],'NC_NOWRITE');
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
% element_index=field{1}.data(1:3,:)';
% lon=field{4}.data;
% lat=field{2}.data;
% time=field{5}.data;
% ssh=field{10}.data;
% 
% ssh_nfdr4=ssh;
% time_nfdr4=time;




%%%%%%%%%%% DORIAN

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/dorian-ref.nc'],'NC_NOWRITE');

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

ssh_ref_d=ssh;
time_ref_d=time;


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/dorian-6h-tide.nc'],'NC_NOWRITE');

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

ssh_atdr_d=ssh;
time_atdr_d=time;


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/dorian-12h-tide.nc'],'NC_NOWRITE');

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

ssh_nfdr_d=ssh;
time_nfdr_d=time;


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/dorian-18h-tide.nc'],'NC_NOWRITE');

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

ssh_nfdr_d2=ssh;
time_nfdr_d2=time;

clear time ssh

% 
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/dorian-wo-tide-at-0-wo-hydro.nc'],'NC_NOWRITE');
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
% element_index=field{1}.data(1:3,:)';
% lon=field{4}.data;
% lat=field{2}.data;
% time=field{5}.data;
% ssh=field{10}.data;
% 
% ssh_nfdr_d3=ssh;
% time_nfdr_d3=time;
% 

%%%%%%%%%%%%%%%%%%%%%%%%%

lat_s = 32.03455;
lon_s = -80.902494;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh_ref(index_dist,:));
m_sshtime1=mean(sshtime1);
sshtime2=squeeze(ssh_atdr(index_dist,:));
m_sshtime2=mean(sshtime2);
sshtime3=squeeze(ssh_nfdr(index_dist,:));
m_sshtime3=mean(sshtime3);
sshtime4=squeeze(ssh_nfdr2(index_dist,:));
m_sshtime4=mean(sshtime4);
% sshtime5=squeeze(ssh_nfdr3(index_dist,:));
% m_sshtime5=mean(sshtime5);
% sshtime6=squeeze(ssh_nfdr4(index_dist,:));
% m_sshtime6=mean(sshtime6);

sshtime1_d=squeeze(ssh_ref_d(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);
sshtime2_d=squeeze(ssh_atdr_d(index_dist,:));
m_sshtime2_d=mean(sshtime2_d);
sshtime3_d=squeeze(ssh_nfdr_d(index_dist,:));
m_sshtime3_d=mean(sshtime3_d);
sshtime4_d=squeeze(ssh_nfdr_d2(index_dist,:));
m_sshtime4_d=mean(sshtime4_d);
% sshtime5_d=squeeze(ssh_nfdr_d3(index_dist,:));
% m_sshtime5_d=mean(sshtime5_d);

return

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

