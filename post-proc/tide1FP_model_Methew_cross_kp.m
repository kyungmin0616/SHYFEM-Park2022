clc
clear all
close all


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-ref.nc'],'NC_NOWRITE');
%ncid = netcdf.open(['/Users/ifederico/Desktop/matthew-test_ous0.nc'],'NC_NOWRITE');
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
for ii = 0:(numvars-1)
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
    field{ii+1}.name = varname;
    varid = netcdf.inqVarID(ncid,varname);
    field{ii+1}.data = netcdf.getVar(ncid,varid);
end;
fac = 1.0;
[nn nt]=size(field{10}.data)
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
bathy=field{7}.data;
time=field{5}.data;
min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;
depth=-field{7}.data;
u_vel=field{8}.data;
v_vel=field{9}.data;
ssh=field{10}.data;

lon_x=lon;
lat_y=lat;
ssh_ref=ssh;
time_ref=time;
clearvars -except lon_x lat_y ssh_ref time_ref


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-ref2.nc'],'NC_NOWRITE');
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
for ii = 0:(numvars-1)
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
    field{ii+1}.name = varname;
    varid = netcdf.inqVarID(ncid,varname);
    field{ii+1}.data = netcdf.getVar(ncid,varid);
end;
fac = 1.0;
[nn nt]=size(field{10}.data)
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
bathy=field{7}.data;
time=field{5}.data;
min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;
depth=-field{7}.data;
u_vel=field{8}.data;
v_vel=field{9}.data;
ssh=field{10}.data;

lon_x=lon;
lat_y=lat;
ssh_exp1=ssh;
time_exp1=time;
clearvars -except lon_x lat_y ssh_ref ssh_exp1 time_ref time_exp1


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-NFO.nc'],'NC_NOWRITE');
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
for ii = 0:(numvars-1)
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
    field{ii+1}.name = varname;
    varid = netcdf.inqVarID(ncid,varname);
    field{ii+1}.data = netcdf.getVar(ncid,varid);
end;
fac = 1.0;
[nn nt]=size(field{10}.data)
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
bathy=field{7}.data;
time=field{5}.data;
min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;
depth=-field{7}.data;
u_vel=field{8}.data;
v_vel=field{9}.data;
ssh=field{10}.data;

lon_x=lon;
lat_y=lat;
ssh_exp2=ssh;
time_exp2=time;
clearvars -except lon_x lat_y ssh_ref ssh_exp1 ssh_exp2 time_ref time_exp1 time_exp2


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-NF.nc'],'NC_NOWRITE');
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
for ii = 0:(numvars-1)
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
    field{ii+1}.name = varname;
    varid = netcdf.inqVarID(ncid,varname);
    field{ii+1}.data = netcdf.getVar(ncid,varid);
end;
fac = 1.0;
[nn nt]=size(field{10}.data)
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
bathy=field{7}.data;
time=field{5}.data;
min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;
depth=-field{7}.data;
u_vel=field{8}.data;
v_vel=field{9}.data;
ssh=field{10}.data;

lon_x=lon;
lat_y=lat;
ssh_exp3=ssh;
time_exp3=time;
clearvars -except lon_x lat_y ssh_ref ssh_exp1 ssh_exp2 ssh_exp3 time_ref time_exp1 time_exp2 time_exp3


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/matthew-ATDR.nc'],'NC_NOWRITE');
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
for ii = 0:(numvars-1)
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
    field{ii+1}.name = varname;
    varid = netcdf.inqVarID(ncid,varname);
    field{ii+1}.data = netcdf.getVar(ncid,varid);
end;
fac = 1.0;
[nn nt]=size(field{10}.data)
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
bathy=field{7}.data;
time=field{5}.data;
min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;
depth=-field{7}.data;
u_vel=field{8}.data;
v_vel=field{9}.data;
ssh=field{10}.data;

lon_x=lon;
lat_y=lat;
ssh_exp4=ssh;
time_exp4=time;
clearvars -except lon_x lat_y ssh_ref ssh_exp1 ssh_exp2 ssh_exp3 ssh_exp4 time_ref time_exp1 time_exp2 time_exp3 time_exp4

ncid = netcdf.open(['/Users/ifederico/Desktop/methew_out/cross/matthew-exp5_ous0.nc'],'NC_NOWRITE');
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
for ii = 0:(numvars-1)
    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
    field{ii+1}.name = varname;
    varid = netcdf.inqVarID(ncid,varname);
    field{ii+1}.data = netcdf.getVar(ncid,varid);
end;
fac = 1.0;
[nn nt]=size(field{10}.data)
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
bathy=field{7}.data;
time=field{5}.data;
min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;
depth=-field{7}.data;
u_vel=field{8}.data;
v_vel=field{9}.data;
ssh=field{10}.data;

lon_x=lon;
lat_y=lat;
ssh_exp5=ssh;
time_exp5= time;
clearvars -except lon_x lat_y ssh_ref ssh_exp1 ssh_exp2 ssh_exp3 ssh_exp4 ssh_exp5 time_ref time_exp1 time_exp2 time_exp3 time_exp4 time_exp5


%%%% FP %%%%
lat_s0 = 32.036667;
lon_s0 = -80.901667;

  
startdate ='2016-10-04 00:00:00';  

lat=lat_y;
lon=lon_x;


%%%% FP %%%%
dist0 = (lat' - lat_s0).^2+(lon' - lon_s0).^2;
[min_dist0,index_dist0] = min(dist0);


sshtime_ref=squeeze(ssh_ref(index_dist0,:));
timeh_ref=[1:1:length(sshtime_ref)];
m_sshtime_ref=mean(sshtime_ref);

sshtime_exp1=squeeze(ssh_exp1(index_dist0,:));
timeh_exp1=[1:1:length(sshtime_exp1)];
m_sshtime_exp1=mean(sshtime_exp1);

sshtime_exp2=squeeze(ssh_exp2(index_dist0,:));
timeh_exp2=[1:1:length(sshtime_exp2)];
m_sshtime_exp2=mean(sshtime_exp2);

sshtime_exp3=squeeze(ssh_exp3(index_dist0,:));
timeh_exp3=[1:1:length(sshtime_exp3)];
m_sshtime_exp3=mean(sshtime_exp3);

sshtime_exp4=squeeze(ssh_exp4(index_dist0,:));
timeh_exp4=[1:1:length(sshtime_exp4)];
m_sshtime_exp4=mean(sshtime_exp4);

% sshtime_exp5=squeeze(ssh_exp5(index_dist0,:));
% timeh_exp5=[1:1:length(sshtime_exp5)];
% m_sshtime_exp5=mean(sshtime_exp5);


refdate=datenum(startdate);


timed_ref=(timeh_ref/24);
timed_exp1=(timeh_exp1/24);
timed_exp2=(timeh_exp2/24);
timed_exp3=(timeh_exp3/24);
timed_exp4=(timeh_exp4/24);
% timed_exp5=(timeh_exp5/24);


sshtot_ref=sshtime_ref-m_sshtime_ref;
sshtot_exp1=sshtime_exp1-m_sshtime_exp1;
sshtot_exp2=sshtime_exp2-m_sshtime_exp2;
sshtot_exp3=sshtime_exp3-m_sshtime_exp3;
sshtot_exp4=sshtime_exp4-m_sshtime_exp4;
% sshtot_exp5=sshtime_exp5-m_sshtime_exp5;



timestamp_ref=datestr((refdate+time_ref/(86400/12)),'yyyy-mm-dd HH:MM:SS');
timestamp_exp4=datestr((refdate+time_exp4/(86400/12)),'yyyy-mm-dd HH:MM:SS');


figure('position',[10,10,1800,500]);
% plot(timestamp,ssh,'-rs','LineWidth',2,'MarkerSize',15)
plot(sshtot_ref,'-r.','LineWidth',2,'MarkerSize',25)
buffer = (max(sshtot_ref)-min(sshtot_ref))/4;
axis([1 numel(sshtot_ref) min(sshtot_ref)-buffer max(sshtot_ref)+buffer])
%title('CMEMS - Metthew','FontSize',20);
title('SWITCH - Matthew','FontSize',20);
grid on
xlabel('Times','FontName','Arial', 'FontSize', 20);
ylabel('Sea level (m)','FontName','Arial', 'FontSize', 20);
set(gca,'xtick',1:12:length(sshtot_ref))
set(gca,'xticklabel',[timestamp_ref(1:12:length(sshtot_ref),:)],'XTickLabelRotation',45)
set(gca,'FontSize',15)
set(gcf,'color','w')





tideFP=load('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/FP_methew_20161005_20161013_6min.dat');
timeht=1:length(tideFP);
timedt=(timeht/24)+1;
mtideFP=mean(tideFP);
timestampobs = datestr(refdate + (0:120:length(tideFP))/24/10,'yyyy-mm-dd HH:MM:SS');
tideFPm=tideFP -mtideFP;
max_tideFPm=max(tideFPm);
MLLWappo=3.827;
MLLW=MLLWappo-max_tideFPm



figure('position',[10,10,1800,500]);
hold on

obj=fill([60 96 96 60],[-1 -1 4 4],'y');
set(obj,'EdgeColor','none')
alpha(obj,.5)
h_ref=plot(0:numel(sshtot_ref)-1,sshtot_ref+MLLW,'-.b','LineWidth',2,'MarkerSize',30);
%axis([0 numel(sshtot1) min(sshtot1)-buffer max(sshtot1)+buffer])
axis([0 numel(sshtot_ref)-1-24 -1 4])
%title('SWITCH - Dorian','FontSize',20);
xlabel('Date and time','FontName','Arial', 'FontSize', 20);
ylabel('Height in meters (MLLW)','FontName','Arial', 'FontSize', 10);
set(gca,'xtick',0:12:length(sshtot_ref))
set(gca,'xticklabel',timestamp_ref,'XTickLabelRotation',45)
box on
grid on
set(gca,'FontSize',18)
set(gcf,'color','w')

h_exp1=plot(0:numel(sshtot_exp1)-1,sshtot_exp1+MLLW,'or','LineWidth',2,'MarkerSize',10);
h_exp2=plot(0:numel(sshtot_exp2)-1,sshtot_exp2+MLLW,'-k','LineWidth',2,'MarkerSize',30);
h_exp3=plot(0:numel(sshtot_exp3)-1,sshtot_exp3+MLLW,'-.m','LineWidth',2,'MarkerSize',30);
% h_exp5=plot(0:numel(sshtot_exp5)-1,sshtot_exp5+MLLW,'-.c','LineWidth',2,'MarkerSize',30);

h_obs=plot((0:.1:(numel(tideFPm)-1)/10),tideFPm+MLLW,'.-g', 'Linewidth',2);

% legend([h_ref,h_exp1,h_exp2,h_exp3,h_exp5,h_obs],'ref','exp1','exp2','exp3','exp4','Obs','location','best')
legend([h_ref,h_exp1,h_exp2,h_exp3,h_obs],'ref','exp1','exp2','exp3','exp4','Obs','location','best')

text(65,4.2,'Matthew on Georgia coast','fontsize',15)

%%%%%%%%%
%%%%%%%%%
%%%%%%%%%





figure('position',[10,10,1800,500]);
hold on
obj=fill([60 96 96 60],[-1 -1 4 4],'y');
set(obj,'EdgeColor','none')
alpha(obj,.5)
h_ref=plot(0:numel(sshtot_ref)-1,sshtot_ref+MLLW,'-.b','LineWidth',2,'MarkerSize',30);
axis([0 numel(sshtot_ref)-1-24 -1 4])
xlabel('Date and time','FontName','Arial', 'FontSize', 20);
ylabel('Height in meters (MLLW)','FontName','Arial', 'FontSize', 10);
set(gca,'xtick',0:12:length(sshtot_ref))
set(gca,'xticklabel',timestamp_ref,'XTickLabelRotation',45)
box on
grid on
set(gca,'FontSize',18)
set(gcf,'color','w')
h_exp3=plot(0:numel(sshtot_exp3)-1,sshtot_exp3+MLLW,'-.m','LineWidth',2,'MarkerSize',30);
%h_exp4=plot(0:numel(sshtot_exp4)-1,sshtot_exp4+MLLW,'-y.','LineWidth',3,'MarkerSize',30);
h_exp5=plot(0:numel(sshtot_exp5)-1,sshtot_exp5+MLLW,'-.c','LineWidth',2,'MarkerSize',30);

h_obs=plot((0:.1:(numel(tideFPm)-1)/10),tideFPm+MLLW,'.-g', 'Linewidth',2);

legend([h_ref,h_exp3,h_exp5,h_obs],'ref','exp3','exp4','Obs','location','best')

%legend([h_ref,h_exp1,h_exp2,h_exp3,h_exp4,h_exp5,h_obs],'ref','exp1','exp2','exp3','exp4','exp5','Obs','location','best')

%text(65,4.2,'Metthew impacts Georgia','fontsize',15)
text(65,4.2,'Matthew on Georgia coast','fontsize',15)

%%%%%%%%%
%%%%%%%%%
%%%%%%%%%
return



