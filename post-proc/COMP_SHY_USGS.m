clear
clc

refDate = datenum('2016-10-04 00:00:00');


% Netcdf file
ncid = netcdf.open(['matthew-wo-tide-at-0.nc'],'NC_NOWRITE');

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
ncid = netcdf.open(['matthew-wo-tide-at-0-wo-hydro.nc'],'NC_NOWRITE');

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
time2=field{5}.data;
ssh2=field{10}.data;

time_r=time/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;










for stn=1 : 10+1

if stn==1
    
lon_s=	-81.1536111111111;	lat_s=	32.24916667;

elseif stn==2
    

lon_s=	-81.1513888888889;	lat_s=	32.23555556;

elseif stn==3

lon_s=	81.1549166666667;	lat_s=	32.16533333;

elseif stn==4
    
lon_s=	81.1383333333333;	lat_s=	32.16555556;
    
elseif stn==5
    
lon_s=	81.1283333333333;	lat_s=	32.11608333;

elseif stn==6
    
lon_s=	81.0813888888889;	lat_s=	32.08083333;
    
elseif stn==7
    
lon_s=	81.1180555555555;	lat_s=	32.18555556;

elseif stn==8
    
lon_s=	81.1176388888889;	lat_s=	32.171;

elseif stn==9
    
lon_s=	81.13;	lat_s=	32.16583333;
    
elseif stn==10

lon_s=	81.0069444444444;	lat_s=	32.10305556;

else
    
lat_s = 32.03455;
lon_s = -80.902494;

end

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh(index_dist,:));
m_sshtime1=mean(sshtime1);
sshtime2=squeeze(ssh2(index_dist,:));
m_sshtime2=mean(sshtime2);
% m_sshtime1=0;

h=figure;
set(h, 'Visible', 'off');
% figure(stn)
clf
plot(time_r,sshtime1-m_sshtime1,'r','linewidth', 2); hold on
plot(time_r,sshtime2-m_sshtime2,'b','linewidth', 2); 
legend('w/o tide','w/o tide w/o hydrop')
xlim([time_r(1) time_r(end)])
datetick('x','mm-dd','keepticks')

xlabel('Date (2016)')
ylabel('h (m)')
title("Station "+stn,'FontSize',12)
set(gca, 'FontSize', 16)


saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/test/Comp_obs_Matthew_%d.png',stn));

end
