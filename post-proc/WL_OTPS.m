clear
clc
% 
files = dir('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Figures_StormTide/OTPS');
files(1:2)=[];


clear DR
for i = 1:6
    
  temp=load([files(i).folder '/' files(i).name]);
  
  DR.(sprintf('point_%d', i))(:,1) = temp.SerialDay; 
  DR.(sprintf('point_%d', i))(:,2) = temp.TimeSeries;
  DR.(sprintf('point_%d', i))(:,3) = temp.lon;
  DR.(sprintf('point_%d', i))(:,4) = temp.lat;


  clear temp
  
end



clear MT
for i = 7:12
    
  temp=load([files(i).folder '/' files(i).name]);
  
  MT.(sprintf('point_%d', i-6))(:,1) = temp.SerialDay; 
  MT.(sprintf('point_%d', i-6))(:,2) = temp.TimeSeries;
  MT.(sprintf('point_%d', i-6))(:,3) = temp.lon;
  MT.(sprintf('point_%d', i-6))(:,4) = temp.lat;

  clear temp
  
end



%% SHYFEM
clear sshd1 time timed1 lon lat element_index
% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-only-tide.nc'],'NC_NOWRITE');
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-only-tide.nc'],'NC_NOWRITE');

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
time=field{5}.data;
ssh=field{10}.data;
lon=field{4}.data;
lat=field{2}.data;
sshd1=ssh;
timed1=time;
min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;

depth=(field{7}.data);


depth1=depth;
depth1(depth1<5)=NaN;


startDate=-81.5;
endDate=-80.3;
clear ssh time

refDate = datenum('2016-10-04 00:00:00');
% refDate = datenum('2019-09-01 00:00:00');
% offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');
% 

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
sshd2=field{10}.data;
timed2=field{5}.data;


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-only-tide-at2.nc'],'NC_NOWRITE');

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
sshd3=field{10}.data;
timed3=field{5}.data;


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-only-tide-at3.nc'],'NC_NOWRITE');

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
sshd4=field{10}.data;
timed4=field{5}.data;


%% Matthew

h=figure('units','normalized','position',[0 0 1 0.9]);
set(h, 'Visible', 'on');

clf

sc=0;

 
for i=1:6
    
subplot(3,2,i)
lat_s = MT.(sprintf('point_%d', i))(1,4);
lon_s = MT.(sprintf('point_%d', i))(1,3)-360;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
sshtime2_d=squeeze(sshd2(index_dist,:));
sshtime3_d=squeeze(sshd3(index_dist,:));
sshtime4_d=squeeze(sshd4(index_dist,:));

plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
plot(MT.(sprintf('point_%d', i))(:,1),MT.(sprintf('point_%d', i))(:,2),'ob', 'LineWidth', 2)
plot(refDate+timed2/(60*60*24),sshtime2_d+sc,'linewidth', 3);hold on
plot(refDate+timed3/(60*60*24),sshtime3_d+sc,'linewidth', 3);hold on
plot(refDate+timed4/(60*60*24),sshtime4_d+sc,'linewidth', 3);hold on

xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
% xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-10 00:00:00')])
% ylim([-2 2])

datetick('x','mmm-dd','keepticks')
legend('SHYFEM','OTPS','at1','at2','at3')
% legend
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(sprintf('Point %d', i),'FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2016)')
set(gca,'FontSize',18)
set(gcf,'color','w')

end


saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Tide_Figures/Figures/Figure2_c.png',1));

%% Dorian

h=figure('units','normalized','position',[0 0 1 0.9]);
set(h, 'Visible', 'on');

clf

sc=0;

 
for i=1:6
    
subplot(3,2,i)
lat_s = MT.(sprintf('point_%d', i))(1,4);
lon_s = MT.(sprintf('point_%d', i))(1,3)-360;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);

plot(refDate+timed1/(60*60*24),sshtime1_d+sc,'-r','linewidth', 3);hold on
plot(DR.(sprintf('point_%d', i))(:,1),DR.(sprintf('point_%d', i))(:,2),'ob', 'LineWidth', 2)

% xlim([datenum('2016-10-05 00:00:00') datenum('2016-10-11 00:00:00')])
xlim([datenum('2019-09-02 00:00:00') datenum('2019-09-08 00:00:00')])
ylim([-2 2])

datetick('x','mmm-dd','keepticks')
legend('SHYFEM','OTPS')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(sprintf('Point %d', i),'FontSize',16)
ylabel('Water level (m)')
xlabel('Date (2019)')
set(gca,'FontSize',18)
set(gcf,'color','w')

end


saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Tide_Figures/Figures/Figure2_d.png',1));
