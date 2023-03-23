clc
clear all
close all


% SSL DATA
load STA.mat


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/20190712/switchv2_ous0.nc'],'NC_NOWRITE');

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

refDate = datenum('2019-07-11 00:00:00');
time_r=time/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;

% datestr(time_r)


for stn=1:length(STA.info(:,1))
  
clear m_sshtime1 sshtime1 lon_s lat_s

lat_s = str2num(STA.info(stn,3));
lon_s = str2num(STA.info(stn,2));

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh(index_dist,:));
m_sshtime1=mean(sshtime1);

h=figure;
set(h, 'Visible', 'off');
% plot(STA.(['WL_STA',num2str(stn)])(:,1),STA.(['WL_STA',num2str(stn)])(:,3),'b','LineWidth', 2); hold on
plot(time_r,sshtime1-m_sshtime1,'r','linewidth', 2); hold on
scatter(STA.(['WL_STA',num2str(stn)])(:,1),STA.(['WL_STA',num2str(stn)])(:,3),100,'b','d','filled');
legend('mod','obs')
% axis([time_r(1) time_r(end) min(STA.(['WL_STA',num2str(stn)])(:,3)) max(STA.(['WL_STA',num2str(stn)])(:,3))]);
axis([time_r(25) time_r(end) min(sshtime1-m_sshtime1) max(sshtime1-m_sshtime1)]);
datetick('x','dd-HH','keepticks')
xlabel('July')
ylabel('h (m)')
set(gca, 'FontSize', 14)
title(ec_sta(stn)+" "+"(Lon="+STA.info(stn,2)+", Lat="+STA.info(stn,3)+")",'FontSize',12)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/Comp_figures/20190705/comp_%d.png',stn));

end

