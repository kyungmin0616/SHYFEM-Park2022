clc
clear all
% close all


%%%%%%%%%%% MATTHEW

%%%%%%%%%% Observation %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = table2array(GA_I(:,5));
GA_M(:,3) = table2array(GA_I(:,3));
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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-only-tide.nc'],'NC_NOWRITE');

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
ssh=field{10}.data;
time=field{5}.data;

ssh2=ssh;
time2=time;

clear ssh time


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
ssh=field{10}.data;
time=field{5}.data;

ssh3=ssh;
time3=time;

clear ssh time


%%%%%%%%%% Observation %%%%%%%%%%%
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_D(:,1)=datenum(strcat(date1,{' '},date2));
GA_D(:,2) = table2array(GA_I(:,5));
GA_D(:,3) = table2array(GA_I(:,3));
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


% parameters for map
time=field{5}.data;
ssh=field{10}.data;

sshd1=ssh;
timed1=time;

clear ssh time


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-only-tide.nc'],'NC_NOWRITE');

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
ssh=field{10}.data;
time=field{5}.data;

sshd2=ssh;
timed2=time;

clear ssh time

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

sshd3=ssh;
timed3=time;

clear ssh time


%%%%%%%%%%%%%%%%%%%%%%%%%

lat_s = 32.03455;
lon_s = -80.902494;


% lat_s = 32.03;
% lon_s = -80.9;
% lat_s = 32.09;
% lon_s = -81.02;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh1(index_dist,:));
m_sshtime1=mean(sshtime1);
sshtime2=squeeze(ssh2(index_dist,:));
m_sshtime2=mean(sshtime2);
sshtime3=squeeze(ssh3(index_dist,:));
m_sshtime3=mean(sshtime3);

sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);
sshtime2_d=squeeze(sshd2(index_dist,:));
m_sshtime2_d=mean(sshtime2_d);
sshtime3_d=squeeze(sshd3(index_dist,:));
m_sshtime3_d=mean(sshtime3_d);

%Plotting

ID = find(GA_D(:,1)>=datenum('2019-09-01 00:00:00') & GA_D(:,1)<=datenum('2019-09-07 23:00:00'));
IM = find(GA_M(:,1)>=datenum('2016-10-04 00:00:00') & GA_M(:,1)<=datenum('2016-10-10 23:00:00'));
NX= [0:(7)/1670:7];


h=figure('units','normalized','position',[0 0 0.8 0.7]);
set(h, 'Visible', 'on');
clf

skp=10;
TP=240;
MIN=-2;
MAX=3;
YT=1;

% Matthew
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
refDate = datenum('2016-10-04 00:00:00');
gi=find(GA_M(:,1)==startDate);
ge=find(GA_M(:,1)==endDate);
f_intp_tide=interp1(a_x,intp_tide',a_x2);

clf
subplot(2,1,1)
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)+0.68,'-r','linewidth', 2);hold on
plot(GA_M(1:skp:end,1),GA_M(1:skp:end,2)+1.168,'or','linewidth', 2,'MarkerSize',15); hold on
plot(refDate+time2(1:TP,1)/(60*60*24),sshtime2(1,1:TP)+0.18,'-b','linewidth', 2);hold on
plot(GA_M(1:skp:end,1),GA_M(1:skp:end,3)+1.168,'ob','linewidth', 2,'MarkerSize',15); 
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[MIN MAX],'YTick',[-2 -1 0 1 2 3]);
datetick('x','mmm-dd','keepticks')
legend('Storm tide-mdl','Storm tide-NOAA','Tide-mdl','Tide-NOAA')

xlabel('Date (2016)')
ylabel('Water level (m)')
title('Hurricane Matthew')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 28)


clear stide tide I_stide I_tide
stide=sshtime1(1,25:25+24*6)+os;
intp_tide=sshtime3(1,25:25+24*6)+os;

% tide=sshtime3(1,25:25+24*6)+os-0.5;

a_x=1:1:145;
a_x2=1:144/1440:145;
I_stide=interp1(a_x,stide',a_x2);
f_intp_tide=interp1(a_x,intp_tide',a_x2);

rmse_stide_t=sqrt(nanmean((I_stide'-GA_M(gi:ge,2)).^2));

rmse_stide_t=sqrt(nanmean((I_stide'-GA_M(gi:ge,2)).^2));
% rmse_tide_t=sqrt(nanmean((I_tide'-GA_M(gi:ge,3)).^2));



% Dorian
subplot(2,1,2)
MIN=-2;
MAX=3;
startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');
refDate = datenum('2019-09-01 00:00:00');
gi=find(GA_D(:,1)==startDate);
ge=find(GA_D(:,1)==endDate);

plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)+0.27,'-r','linewidth', 2);hold on
plot(GA_D(1:skp:end,1),GA_D(1:skp:end,2)+1.168,'or','linewidth', 2,'MarkerSize',15); hold on
plot(refDate+timed2(1:TP,1)/(60*60*24),sshtime2_d(1,1:TP),'-b','linewidth', 2);hold on
plot(GA_D(1:skp:end,1),GA_D(1:skp:end,3)+1.168,'ob','linewidth', 2,'MarkerSize',15); 
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
set(gca,'YLim',[MIN MAX],'YTick',[-2 -1 0 1 2 3]);
datetick('x','mmm-dd','keepticks')
legend('Storm tide-mdl','Storm tide-NOAA','Tide-mdl','Tide-NOAA')
xlabel('Date (2019)')
ylabel('Water level (m)')
title('Hurricane Dorian')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
set(gcf,'color','w')
set(gca, 'FontSize', 28)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_6.png',1));


clear stide tide I_stide I_tide

stide=sshtime1_d(1,25:25+24*6)+os;
tide=sshtime2_d(1,25:25+24*6)+os-0.2;
I_stide=interp1(a_x,stide',a_x2);
I_tide=interp1(a_x,tide',a_x2);

rmse_stide_d=sqrt(nanmean((I_stide'-GA_D(gi:ge,2)).^2));
rmse_tide_d=sqrt(nanmean((I_tide'-GA_D(gi:ge,3)).^2));


return

%%
figure(1)
clf
os=0;
skp=20;
TP=24*7;
sdt=24*2+1;
ctlt=+2;


subplot(2,1,1)
plot(time1(sdt:TP,1)/(60*60*24),sshtime1(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(time2(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(time3(sdt:TP,1)/(60*60*24),sshtime3(1,sdt:TP)+os,'-b','linewidth', 2,'MarkerSize',15); 
plot(time3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(time3(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+sshtime3(1,sdt+ctlt:TP+ctlt),'-.k','linewidth', 2,'MarkerSize',15); 

axis([2 6 -1 2]);
% legend('MT-ref','MT-local','MT-remote','residual')
xlabel('Days')
ylabel('Water level (m)')
% title("Point "+stn,'FontSize',12)
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')

subplot(2,1,2)
ctlt=+14;
os=0;
plot(timed1(sdt:TP,1)/(60*60*24),sshtime1_d(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(timed2(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(timed3(sdt:TP,1)/(60*60*24),sshtime3_d(1,sdt:TP)+os,'-b','linewidth', 2,'MarkerSize',15); 
plot(timed3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3_d(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(timed3(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+sshtime3_d(1,sdt+ctlt:TP+ctlt),'-.k','linewidth', 2,'MarkerSize',15); 
% plot(timed3(1:168,1)/(60*60*24),sshtime4_d(1,1:168)+os,'-g','linewidth', 2,'MarkerSize',15); 


axis([2 6 -0.7 1]);
legend('DR-ref','DR-local','DR-remote','residual')
% datetick('x','mm-dd','keeplimits')
xlabel('Days')
ylabel('Water level (m)')
set(gca, 'FontSize', 28)
box on
grid on
set(gcf,'color','w')



