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



% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-rain.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/dorian-4rd1000.nc'],'NC_NOWRITE');

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


refDate = datenum('2019-09-02 00:00:00');
time_r=time/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;
refDate = datenum('2019-09-02 00:00:00');
time_r2=time_exp/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;


% datestr(time_r)


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
axis([time_r(1) time_r(end) -1.5 1.8]);
datetick('x','mm-dd','keepticks')
% xlabel('Septemper (2019)')
ylabel('h (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 16)




% Map and location of point

min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;

depth=(field{7}.data);


depth1=depth;
depth1(depth1<5)=NaN;


figure(9)
clf
SAB_coast; hold on
trisurf(element_index,lon,lat,-depth)
view(0,90);shading interp;     
colormap(jet);colorbar;axis equal
title('Bathymetry (m) ','FontSize',16);
xlabel('Longitude ','FontSize',22)
ylabel('Latitude ','FontSize',22)
caxis([-25. 5])
axis([min_lon max_lon min_lat max_lat])
hcb=colorbar;
title(hcb,'(m)','fontsize', 14)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 22)
set(graph_handle,'linewidth', 1)   

lat_s = 32.09;
lon_s = -81.07;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.09;
lon_s = -81.07;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.09;
lon_s = -81.07;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.09;
lon_s = -81.07;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);



%% previous points
lat_s = 32.09;
lon_s = -81.07;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.09;
lon_s = -81.03;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.13;
lon_s = -81.12;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.13;
lon_s = -81.14;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.24;
lon_s = -81.16;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.25;
lon_s = -81.15;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.03455;
lon_s = -80.902494;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);

lat_s = 32.03;
lon_s = -80.91;
plot(lon_s,lat_s,'ko','MarkerSize',5,'markerfacecolor','k','LineWidth',2);


