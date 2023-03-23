clc
clear all
close all

%% Matthew

%%%%%%%%%% Observation %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = str2double(table2array(GA_I(:,5)));
GA_M(:,3) = str2double(table2array(GA_I(:,3)));
GA_M(:,4) = GA_M(:,2)-GA_M(:,3);


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-ref.nc'],'NC_NOWRITE');

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

element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
time=field{5}.data;
ssh=field{10}.data;

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-ssh-sp-fz.nc'],'NC_NOWRITE');

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


ssh2=field{10}.data;

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


ssh3=field{10}.data;

% Time
refDate = datenum('2016-10-04 00:00:00');
time_r=time/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;

% Fort Pulaski
lat_s = 32.03455;
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh(index_dist,:));
m_sshtime1=mean(sshtime1);

sshtime2=squeeze(ssh2(index_dist,:));
m_sshtime2=mean(sshtime2);

sshtime3=squeeze(ssh3(index_dist,:));
m_sshtime3=mean(sshtime3);




%% Dorian

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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-ref.nc'],'NC_NOWRITE');

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

element_indexd=field{1}.data(1:3,:)';
lond=field{4}.data;
latd=field{2}.data;
timed=field{5}.data;
sshd=field{10}.data;

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-ssh-sp-fz.nc'],'NC_NOWRITE');

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


sshd2=field{10}.data;

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


sshd3=field{10}.data;


refDate = datenum('2019-09-01 00:00:00');
time_r2=timed/3600*(datenum('2019-07-11 01:00:00')-datenum('2019-07-11 00:00:00'))+refDate;


% Fort Pulaski
lat_s = 32.03455;
lon_s = -80.902494;
dist = (latd' - lat_s).^2+(lond' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtimed1=squeeze(sshd(index_dist,:));
m_sshtimed1=mean(sshtimed1);

sshtimed2=squeeze(sshd2(index_dist,:));
m_sshtimed2=mean(sshtimed2);

sshtimed3=squeeze(sshd3(index_dist,:));
m_sshtimed3=mean(sshtimed3);





%% Plot


%Tide-storm surge interaction
oft=0;

figure(1)
clf
plot(time/(60*60*24)-2,sshtime1-(sshtime2+sshtime3)+oft,'r','linewidth', 2); hold on
plot(timed/(60*60*24)-2,sshtimed1-(sshtimed2+sshtimed3)+oft,'b','linewidth', 2);
legend('Matthew','Dorian')

axis([0 5 -0.3 0.10111]);
xlabel('Days')
ylabel('Nonlinera residual (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 16)


% oft=-0.55;
skp=4;
sz=120;

figure(1)
clf

subplot(2,1,1)
plot(time_r,sshtime1+oft,'r','linewidth', 2); hold on
plot(time_r,sshtime2+oft,'b','linewidth', 2); 
plot(time_r,sshtime3+oft,'g','linewidth', 2); 
plot(time_r,sshtime1-(sshtime2+sshtime3)+oft,'m','linewidth', 2); 
% scatter(GA_M(1:skp:end,1),GA_M(1:skp:end,2),sz,'MarkerEdgeColor','r','linewidth', 3);
% scatter(GA_M(1:skp:end,1),GA_M(1:skp:end,3),sz,'MarkerEdgeColor','b','linewidth', 3);
% 
% legend('Total water level','Tide','Storm surge','Nonlinear','Total water level-obs.','Tide-obs.')
legend('Total water level','Tide','Storm surge','Nonlinear')

% axis([time_r(25) time_r(end-48) -1.5 2]);
axis([time_r(49) time_r(168) -1.5 2])

datetick('x','mm-dd HH:00','keepticks')
xlabel('October (2016)')
ylabel('m')
title('Matthew','FontSize',12)
set(gca, 'FontSize', 16)

% oft=0.2;
skp=5;
sz=120;

subplot(2,1,2)
plot(time_r2,sshtimed1+oft,'r','linewidth', 2); hold on
plot(time_r2,sshtimed2+oft,'b','linewidth', 2); 
plot(time_r2,sshtimed3+oft,'g','linewidth', 2); 
plot(time_r2,sshtimed1-(sshtimed2+sshtimed3)+oft,'m','linewidth', 2); 
% scatter(GA_D(1:skp:end,1),GA_D(1:skp:end,2)-mean(GA_D(:,2)),sz,'MarkerEdgeColor','r','linewidth', 3);
% scatter(GA_D(1:skp:end,1),GA_D(1:skp:end,3)-mean(GA_D(:,3)),sz,'MarkerEdgeColor','b','linewidth', 3);

% legend('Total water level','Tide','Storm surge','Nonlinear','Total water level-obs.','Tide-obs.')
legend('Total water level','Tide','Storm surge','Nonlinear')

% axis([time_r2(25) time_r2(end-48) -2 2.5]);
axis([time_r2(49) time_r2(168) -1.5 2])

datetick('x','mm-dd HH:00','keepticks')
xlabel('Septemper (2019)')
ylabel('m')
title('Dorian','FontSize',12)
set(gca, 'FontSize', 16)
set(gcf,'color','w');



figure(1)
clf
oft=0;
plot(time_r,sshtime1+oft,'r','linewidth', 2); hold on
plot(time_r,sshtime2+oft,'b','linewidth', 2); 
plot(time_r,sshtime3+oft,'g','linewidth', 2); 
plot(time_r,sshtime1-(sshtime2+sshtime3)+oft,'m','linewidth', 2); 
scatter(GA_M(1:skp:end,1),GA_M(1:skp:end,2),sz,'MarkerEdgeColor','r','linewidth', 3);
scatter(GA_M(1:skp:end,1),GA_M(1:skp:end,3),sz,'MarkerEdgeColor','b','linewidth', 3);

legend('Total water level','Tide','Storm surge','Nonlinear','Total water level-obs.','Tide-obs.')
% legend('Total water level','Tide','Storm surge','Nonlinear')

% axis([time_r(25) time_r(end-48) -1.5 2]);
axis([time_r(49) time_r(168) -1.5 2])

datetick('x','mm-dd HH:00','keepticks')
xlabel('October (2016)')
ylabel('m')
title('Matthew','FontSize',12)
set(gca, 'FontSize', 16)

for stn=1 : 10+1


if stn==1
lon_s=	-81.1536111111111;	lat_s=	32.24916667;

elseif stn==2
lon_s=	-81.1513888888889;	lat_s=	32.23555556;

elseif stn==3
lon_s=	81.1180555555555;	lat_s=	32.18555556;

elseif stn==4
lon_s=	81.1176388888889;	lat_s=	32.171;
    
elseif stn==5
lon_s=	81.13;	lat_s=	32.16583333;

elseif stn==6
lon_s=	81.1383333333333;	lat_s=	32.16555556;
    
elseif stn==7
lon_s=	81.1549166666667;	lat_s=	32.16533333;

elseif stn==8
lon_s=	81.1283333333333;	lat_s=	32.11608333;

elseif stn==9
lon_s=	81.0069444444444;	lat_s=	32.10305556;

elseif stn==10
lon_s=	81.0813888888889;	lat_s=	32.08083333;

else
lon_s = -80.902494;      lat_s = 32.03455;  

end

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh(index_dist,:));
sshtime2=squeeze(ssh2(index_dist,:));
sshtime3=squeeze(ssh3(index_dist,:));

sshtimed1=squeeze(sshd(index_dist,:));
sshtimed2=squeeze(sshd2(index_dist,:));
sshtimed3=squeeze(sshd3(index_dist,:));


% m_sshtime1=0;

h=figure;
set(h, 'Visible', 'off');
plot(time/(60*60*24),sshtime1-(sshtime2+sshtime3)+oft,'r','linewidth', 2); hold on
plot(timed/(60*60*24),sshtimed1-(sshtimed2+sshtimed3)+oft,'b','linewidth', 2);
legend('Matthew','Dorian')

xlim([2 6])
xlabel('Days')
ylabel('level (m)')
title("lon: "+lon_s+",  lat:"+lat_s,'FontSize',12)
set(gca, 'FontSize', 16)


saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NLinter/Comp_btw_MT_DR/Comp_obs_Matthew_%d.png',stn));

end




for stn=1 : 10+1

if stn==1
lon_s=	-81.1536111111111;	lat_s=	32.24916667;

elseif stn==2
lon_s=	-81.1513888888889;	lat_s=	32.23555556;

elseif stn==3
lon_s=	81.1180555555555;	lat_s=	32.18555556;

elseif stn==4
lon_s=	81.1176388888889;	lat_s=	32.171;
    
elseif stn==5
lon_s=	81.13;	lat_s=	32.16583333;

elseif stn==6
lon_s=	81.1383333333333;	lat_s=	32.16555556;
    
elseif stn==7
lon_s=	81.1549166666667;	lat_s=	32.16533333;

elseif stn==8
lon_s=	81.1283333333333;	lat_s=	32.11608333;

elseif stn==9
lon_s=	81.0069444444444;	lat_s=	32.10305556;

elseif stn==10
lon_s=	81.0813888888889;	lat_s=	32.08083333;

else
lon_s = -80.902494;      lat_s = 32.03455;  

end

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh(index_dist,:));
sshtime2=squeeze(ssh2(index_dist,:));
sshtime3=squeeze(ssh3(index_dist,:));

sshtimed1=squeeze(sshd(index_dist,:));
sshtimed2=squeeze(sshd2(index_dist,:));
sshtimed3=squeeze(sshd3(index_dist,:));


% m_sshtime1=0;

h=figure;
set(h, 'Visible', 'off');

subplot(2,1,1)
plot(time_r,sshtime1+oft,'r','linewidth', 2); hold on
plot(time_r,sshtime2+oft,'b','linewidth', 2); 
plot(time_r,sshtime3+oft,'g','linewidth', 2); 
plot(time_r,sshtime1-(sshtime2+sshtime3)+oft,'m','linewidth', 2); 
legend('Total water level','Tide','Storm surge','Nonlinear')
xlim([time_r(25) time_r(end-48)])
datetick('x','mm-dd','keepticks')
xlabel('Matthew')
ylabel('h (m)')
title("lon: "+lon_s+",  lat:"+lat_s,'FontSize',12)
set(gca, 'FontSize', 12)

subplot(2,1,2)
plot(time_r2,sshtimed1+oft,'r','linewidth', 2); hold on
plot(time_r2,sshtimed2+oft,'b','linewidth', 2); 
plot(time_r2,sshtimed3+oft,'g','linewidth', 2); 
plot(time_r2,sshtimed1-(sshtimed2+sshtimed3)+oft,'m','linewidth', 2); 
legend('Total water level','Tide','Storm surge','Nonlinear')
xlim([time_r2(25) time_r2(end-48)])
datetick('x','mm-dd','keepticks')
xlabel('Dorian')
ylabel('h (m)')
title("lon: "+lon_s+",  lat:"+lat_s,'FontSize',12)
set(gca, 'FontSize', 12)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NLinter/Comp_MT_DR_%d.png',stn));

end



