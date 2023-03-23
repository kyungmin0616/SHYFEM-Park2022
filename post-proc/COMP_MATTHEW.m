clc
clear all
close all

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

ssh_ref=ssh;
time_ref=time;
clearvars -except ssh_ref time_ref


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-wo-tide-wo-hydro.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-wo-tide-at-dr.nc'],'NC_NOWRITE');

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
clearvars -except ssh_ref time_ref ssh_atdr time_atdr ssh_nfdr time_nfdr ssh_ws0 time_ws0 lon lat element_index

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-wo-tide-at-0.nc'],'NC_NOWRITE');

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

ssh_ws0=ssh;
time_ws0=time;
clearvars -except ssh_ref time_ref ssh_atdr time_atdr ssh_nfdr time_nfdr ssh_ws0 time_ws0 lon lat element_index


refDate = datenum('2016-10-04 00:00:00');
time_ref=time_ref/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;
time_atdr=time_atdr/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;
time_nfdr=time_nfdr/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;
time_ws0=time_ws0/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;



% 
% 
% %%%%%%%%%% MATTHEW %%%%%%%%%%%
% GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_MATTHEW.csv');
% date1=table2array(GA_I(:,1));
% date2=table2array(GA_I(:,2));
% GA_M(:,1)=datenum(strcat(date1,{' '},date2));
% GA_M(:,2) = str2double(table2array(GA_I(:,5)));
% GA_M(:,3) = str2double(table2array(GA_I(:,3)));
% GA_M(:,4) = GA_M(:,2)-GA_M(:,3);
% mGA_M=mean(GA_M(:,2));




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
sshtime4=squeeze(ssh_ws0(index_dist,:));
m_sshtime4=mean(sshtime4);


% tideFPm=GA_M(:,2)-mean(GA_M(:,2));
% max_tideFPm=max(tideFPm);
% MLLWappo=3.827;
% MLLW=MLLWappo-max_tideFPm;
% 
% i=find(GA_M(:,1)==time_ref(1));
% j=find(GA_M(:,1)==time_ref(end-50));
% % 
% os=0.0;
% % MLLW
% figure(1)
% clf
% plot(time_ref,sshtime1-m_sshtime1+MLLW+os,'r','linewidth', 2); hold on
% plot(time_atdr,sshtime2-m_sshtime2+MLLW+os,'g','linewidth', 2); 
% plot(time_nfdr,sshtime3-m_sshtime3+MLLW+os,'g','linewidth', 2); 
% plot(time_ws0,sshtime4-m_sshtime4,'m','linewidth', 2); 
% plot(GA_M(:,1),GA_M(:,2)-mean(GA_M(:,2))+MLLW,'b','linewidth', 2);
% 
% legend('Ref','w/o tide','Observation')
% % legend('mdl','Obs')
% 
% axis([time_ref(24) time_ref(end-23) -1 4]);
% datetick('x','mm-dd','keeplimits')
% xlabel('October (2016)')
% ylabel('Water level (m)')
% % title("Point "+stn,'FontSize',12)
% set(gca, 'FontSize', 25)
% box on
% grid on
% set(gcf,'color','w')


os=0;
% MLLW
figure(1)
clf
plot(time_ref,sshtime1-m_sshtime1+os,'r','linewidth', 2); hold on
plot(time_atdr,sshtime2-m_sshtime2+os,'g','linewidth', 2); 
plot(time_nfdr,sshtime3-m_sshtime3+os,'b','linewidth', 2); 
plot(time_ws0,sshtime4-m_sshtime4+os,'m','linewidth', 2); 
% plot(GA_M(:,1),GA_M(:,2)-mean(GA_M(:,2)),'b','linewidth', 2);

legend('wo tide','hydro','atdr','at0')
% legend('mdl','Obs')

axis([time_ref(24) time_ref(end-23) -1.2 2.5]);
datetick('x','mm-dd','keeplimits')
xlabel('October (2016)')
ylabel('Water level (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 25)
box on
grid on
set(gcf,'color','w')



for stn=1 : 8

if stn==1
    
    lat_s = 32.09;
    lon_s = -81.07;
    
elseif stn==2
    

    lat_s = 32.09;
    lon_s = -81.03;

elseif stn==3

    lat_s = 32.13;
    lon_s = -81.12;
elseif stn==4
    
    lat_s = 32.13;
    lon_s = -81.14;
    
elseif stn==5
    
    lat_s = 32.24;
    lon_s = -81.16;

elseif stn==6
    
    lat_s = 32.25;
    lon_s = -81.15;
    
elseif stn==7
    
    lat_s = 32.03;
    lon_s = -80.91;

else

    lat_s = 32.03455;
    lon_s = -80.902494;
 
end

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh(index_dist,:));
m_sshtime1=mean(sshtime1);
% m_sshtime1=0;

sshtime2=squeeze(ssh_exp(index_dist,:));
% m_sshtime2=mean(sshtime2);
m_sshtime2=0;

h=figure;
set(h, 'Visible', 'off');
% figure(1)
clf
plot(time_r,sshtime1-m_sshtime1,'r','linewidth', 2); hold on
plot(time_r2,sshtime2-m_sshtime2,'b','linewidth', 2);
legend('Dorian-rd0','Dorian-rd2500')
% axis([time_r(1) time_r(end) min(sshtime1-m_sshtime1) max(sshtime1-m_sshtime1)]);
datetick('x','dd-HH','keepticks')
xlabel('Septemper (2019)')
ylabel('h (m)')
title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 16)


saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/TimeHis/Comp_Point_%d.png',stn));

end



lat_s = 32.03455;
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh(index_dist,:));
m_sshtime1=mean(sshtime1);

figure(1)
clf
% scatter(time_r,sshtime1-m_sshtime1,60,'filled')
plot(time_r,sshtime1,'r','linewidth', 2); hold on
plot(GA_M(:,1),GA_M(:,2)-mean(GA_M(:,2)),'b','linewidth', 2);
legend('Mdl','Obs')
axis([time_r(1) time_r(end) -1.5 2.5]);
datetick('x','mm-dd','keepticks')
% xlabel('Septemper (2019)')
ylabel('h (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 16)

