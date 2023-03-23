clc
clear all
% close all


%%%%%%%%%%% MATTHEW

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


% parameters for map
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
time=field{5}.data;
ssh=field{10}.data;

ssh1=ssh;
time1=time;

clear ssh time

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


% parameters for map
time=field{5}.data;
ssh=field{10}.data;

sshd1=ssh;
timed1=time;

clear ssh time

%%%%%%%%%%%%%%%%%%%%%%%%%

lat_s = 32.03455;
lon_s = -80.902494;


% lat_s = 32.09;
% lon_s = -81.02;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh1(index_dist,:));
m_sshtime1=mean(sshtime1);



sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);



%Plotting

ID = find(GA_D(:,1)>=datenum('2019-09-01 00:00:00') & GA_D(:,1)<=datenum('2019-09-07 23:00:00'));
IM = find(GA_M(:,1)>=datenum('2016-10-04 00:00:00') & GA_M(:,1)<=datenum('2016-10-10 23:00:00'));
NX= [0:(7)/1670:7];


figure(1)

h=figure('units','normalized','position',[0 0 0.8 0.7]);
set(h, 'Visible', 'off');

os=-0.5;
skp=20;
TP=25+24*6;
MIN=-3;
MAX=2;
YT=1;
st=25;

ob_m=sshtime1(1,st:TP)+os;

rms_md_m=sqrt(mean(ob_m.^2));
rms_ob_m=sqrt(mean(GA_M(gi:ge,2).^2));


% Matthew

startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
refDate = datenum('2016-10-04 00:00:00');
gi=find(GA_M(:,1)==startDate);
ge=find(GA_M(:,1)==endDate);

figure
subplot(2,1,1)
plot(refDate+time1(st:TP,1)/(60*60*24),sshtime1(1,st:TP)+os,'-r','linewidth', 2);hold on
plot(GA_M(gi:ge,1),GA_M(gi:ge,2),'-b','linewidth', 2); 
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[MIN MAX],'YTick',[MIN:YT:MAX]);

datetick('x','mmm-dd','keepticks')
legend('Model','Observation')
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

ob_m=sshtime1(1,25:25+24*6)+os;

a_x=1:1:145;
a_x2=1:144/1440:145;
I_ob_m=interp1(a_x,ob_m',a_x2);

rmse_m=sqrt(mean((I_ob_m'-GA_M(gi:ge,2)).^2));


% Dorian
subplot(2,1,2)
os=-0.8;
% MIN=-3;
% MAX=1.5;

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');
refDate = datenum('2019-09-01 00:00:00');
gi=find(GA_D(:,1)==startDate);
ge=find(GA_D(:,1)==endDate);

plot(refDate+timed1(25:25+24*6,1)/(60*60*24),sshtime1_d(1,25:25+24*6)+os,'-r','linewidth', 2);hold on
plot(GA_D(gi:ge,1),GA_D(gi:ge,2),'-b','linewidth', 2); 
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
set(gca,'YLim',[MIN MAX],'YTick',[MIN:YT:MAX]);
datetick('x','mmm-dd','keepticks')
legend('Model','Observation')
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


ob_d=sshtime1_d(1,25:25+24*6)+os;

a_x=1:1:145;
a_x2=1:144/1440:145;
I_ob_d=interp1(a_x,ob_d',a_x2);
clear tet

rmse_d=sqrt(mean((I_ob_d'-GA_D(gi:ge,2)).^2));


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_6.png',1));


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



