clc
clear all
% close all


%%%%%%%%%%% MATTHEW

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-total-ng-otps.nc'],'NC_NOWRITE');

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
lon=double(field{4}.data);
lat=double(field{2}.data);
time1=field{5}.data;
ssh1=field{10}.data+0.15;
u1=squeeze(field{8}.data);
v1=squeeze(field{9}.data);
cur1=sqrt(u1.^2+v1.^2);

min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;

%%%%%%%%%%%%%%%%%%%%%%%%%%%% DORIAN

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-total-ng-otps.nc'],'NC_NOWRITE');

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
timed1=field{5}.data;
sshd1=field{10}.data;
ud1=squeeze(field{8}.data);
vd1=squeeze(field{9}.data);
curd1=sqrt(ud1.^2+vd1.^2);


%%%%%%%%%%%%%%%%%%%%%%%%%

lat_s = 32.03455; % Fort Pulaski
lon_s = -80.902494;
% 
% lat_s = 32.1160833333333;
% lon_s = -81.1283333333333;

% lat_s = 31.5415;   % Sapelo estuary
% lon_s = -81.2192;


dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh1(index_dist,:));
m_sshtime1=mean(sshtime1);

sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);


%% Plotting
fw=0.58;
fh=0.7;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf
os=0;
skp=20;
TP=194;

% Matthew
startDate = datenum('10-05-2016');
endDate = datenum('10-12-2016');
refDate = datenum('2016-10-04 00:00:00');

h1=subplot(2,1,1);
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)+os,'-k','linewidth', 2); hold on
set(gca,'XLim',[startDate endDate])
datetick('x','mmm-dd','keepticks')
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 2.5])
legend({'Total forcing','Local forcing','Remote forcing'},'FontSize',26)
xlabel('Date (2016)')
ylabel('Water level (m)')
title('Hurricane Matthew')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 26)

% Dorian
h2=subplot(2,1,2);
os=0;
startDate = datenum('09-02-2019');
endDate = datenum('09-09-2019');

refDate = datenum('2019-09-01 00:00:00');
plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)+os,'-k','linewidth', 2); hold on
set(gca,'XLim',[startDate endDate])

set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 2.5])
datetick('x','mmm-dd','keepticks')
legend({'Total forcing','Local forcing','Remote forcing'},'FontSize',26)
xlabel('Date (2019)')
ylabel('Water level (m)')
title('Hurricane Dorian')
box on
grid on
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
set(gcf,'color','w')
set(gca, 'FontSize', 26)


sp_width= 0.515/fw;
sp_height= 0.22/fh;

x_gap=0.065;
y_gap=0.2;

x1 = 0.07;
y1 = 0.63;
y2 = y1-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_11.png',1));



%% Shifted

fw=0.58;
fh=0.7;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

% Y = prctile(sshtime1(1,sdt:TP)+os,[90:100],'all','Method','approximate');
% Y2 = prctile(sshtime2(1,sdt:TP)+sshtime3(1,sdt+ctlt:TP+ctlt),[90:100],'all','Method','approximate');

% I=find(sshtime1(1,sdt:TP)>=Y(1))
% I2=find(sshtime2(1,sdt:TP)+sshtime3(1,sdt+ctlt:TP+ctlt)>=Y2(1))

% [M, I] = max(sshtime1_d(1,sdt:TP))
% [M, I2] = max(sshtime2_d(1,sdt:TP)+sshtime3_d(1,sdt+ctlt:TP+ctlt))
% 
% datestr(refDate+timed1(I,1)/(60*60*24))
% datestr(refDate+timed3(I2,1)/(60*60*24))

clf
os=0;
skp=20;
TP=24*7;
sdt=24*2+1;
ctlt=+2;

startDate = datenum('10-06-2016');
endDate = datenum('10-10-2016');
refDate = datenum('2016-10-04 00:00:00');

h1=subplot(2,1,1);
plot(refDate+time1(sdt:TP,1)/(60*60*24),sshtime1(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+time2(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(sdt:TP,1)/(60*60*24),sshtime2(1,sdt:TP)+sshtime3(1,sdt+ctlt:TP+ctlt),'-g','linewidth', 2,'MarkerSize',15); 
% plot(refDate+time3(sdt+I,1)/(60*60*24),sshtime1(1,sdt+I),'-r','linewidth', 5); 
% plot(refDate+time3(sdt+I2,1)/(60*60*24),sshtime2(1,sdt+I2)+sshtime3(1,sdt+ctlt+I2),'-r','linewidth', 5); 

% plot(TT2(I),TTT2(I),'-M','linewidth', 5); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','mmm-dd','keeplimits')
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 2.5])
legend({'MT-BS','MT-LF','MT-RF (Shifted)','Reconstruction'},'FontSize',26)
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Matthew')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 26)


h2=subplot(2,1,2);
ctlt=+14;
startDate = datenum('09-03-2019');
endDate = datenum('09-07-2019');
refDate = datenum('2019-09-01 00:00:00');
os=0;
plot(refDate+timed1(sdt:TP,1)/(60*60*24),sshtime1_d(1,sdt:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+timed2(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(sdt-ctlt:TP-ctlt,1)/(60*60*24),sshtime3_d(1,sdt:TP)+os,'-.b','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(sdt:TP,1)/(60*60*24),sshtime2_d(1,sdt:TP)+sshtime3_d(1,sdt+ctlt:TP+ctlt),'-g','linewidth', 2,'MarkerSize',15); 
% plot(refDate+timed1(sdt+I,1)/(60*60*24),sshtime1_d(1,sdt+I),'-r','linewidth', 5); 
% plot(refDate+timed3(sdt+I2,1)/(60*60*24),sshtime2_d(1,sdt+I2)+sshtime3_d(1,sdt+ctlt+I2),'-r','linewidth', 5); 
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 2.5])
datetick('x','mmm-dd','keeplimits')
legend({'DR-BS','DR-LF','DR-RF (Shifted)','Reconstruction'},'FontSize',26)
xlabel('Date (2019)')
ylabel('Storm surge (m)')
title('Hurricane Dorian')
box on
grid on
set(gcf,'color','w')
set(gcf,'color','w')
set(gca, 'FontSize', 26)

sp_width= 0.515/fw;
sp_height= 0.22/fh;

x_gap=0.065;
y_gap=0.2;

x1 = 0.07;
y1 = 0.63;
y2 = y1-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_12.png',1));


%% 2D MAP
fw=0.9;
fh=1;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

% Extreme
% stt=25*3+15;
% edt=25*3+15+24;

stt=25*1;
edt=25*1+48;

sz=50;


stt=25*1;
edt=25*1+48;
clf
h1=subplot(2,2,1);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,nanmean((cur1(:,stt:edt)+curd1(:,stt:edt))./2,2))
view(0,90);shading interp;     
colormap(turbo);
hcb=colorbar;
title('Normal-Mean');
title(hcb,'m/s','fontsize', 18)
% title('\color{black}Matthew-total forcing');
caxis([0. 0.6]);
% caxis([0.6 0.75]);
% caxis([0.85 1.2]);
% caxis([0.85 1.2]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')
 
%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
scatter3(ssls(:,1), ssls(:,2),z,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %SSLS
scatter3(-80.991889, 32.020471,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Turner Creek Boat Ramp Sea Level Sensor
scatter3(-81.011631,  32.052507,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Oatland Island Road environmental sensors
scatter3(-81.031204,  32.038669,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Hwy 80 at Grays Creek Sea Level Sensor
scatter3(-81.063662,  32.000149,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %LaRoche Avenue at Nottingham Creek Sea Level Sensor
scatter3(-81.084020,  31.928350,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Faye Drive on Burnside Island Sea Level Sensor
scatter3(-81.153906,  31.935783,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Coffee Bluff Marina environmental sensors
%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%

stt=24*3+15;
edt=24*3+15+24;
h2=subplot(2,2,2);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,nanmean((cur1(:,stt:edt)+curd1(:,stt:edt))./2,2))
view(0,90);shading interp;     
colormap(turbo);
hcb=colorbar;
title(hcb,'m/s','fontsize', 18)
title('Extreme-Mean');
caxis([0. 0.6]);
% caxis([0.3 0.6]);
% caxis([0.35 1.4]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')

%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
scatter3(ssls(:,1), ssls(:,2),z,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %SSLS
scatter3(-80.991889, 32.020471,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Turner Creek Boat Ramp Sea Level Sensor
scatter3(-81.011631,  32.052507,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Oatland Island Road environmental sensors
scatter3(-81.031204,  32.038669,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Hwy 80 at Grays Creek Sea Level Sensor
scatter3(-81.063662,  32.000149,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %LaRoche Avenue at Nottingham Creek Sea Level Sensor
scatter3(-81.084020,  31.928350,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Faye Drive on Burnside Island Sea Level Sensor
scatter3(-81.153906,  31.935783,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Coffee Bluff Marina environmental sensors
%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%


stt=25*1;
edt=25*1+48;
h3=subplot(2,2,3);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,var((cur1(:,stt:edt)+curd1(:,stt:edt))./2,0,2))
view(0,90);shading interp;     
colormap(turbo);
hcb=colorbar;
title('Normal-Variance');
title(hcb,'m^2/s^2','fontsize', 18)
caxis([0. 0.07]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')
 
%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
scatter3(ssls(:,1), ssls(:,2),z,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %SSLS
scatter3(-80.991889, 32.020471,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Turner Creek Boat Ramp Sea Level Sensor
scatter3(-81.011631,  32.052507,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Oatland Island Road environmental sensors
scatter3(-81.031204,  32.038669,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Hwy 80 at Grays Creek Sea Level Sensor
scatter3(-81.063662,  32.000149,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %LaRoche Avenue at Nottingham Creek Sea Level Sensor
scatter3(-81.084020,  31.928350,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Faye Drive on Burnside Island Sea Level Sensor
scatter3(-81.153906,  31.935783,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Coffee Bluff Marina environmental sensors
%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%

stt=24*3+15;
edt=24*3+15+24;
h4=subplot(2,2,4);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,var((cur1(:,stt:edt)+curd1(:,stt:edt))./2,0,2))
view(0,90);shading interp;     
colormap(turbo);
hcb=colorbar;
title(hcb,'m^2/s^2','fontsize', 18)
title('Extreme-Mean');
caxis([0. 0.07]);
% caxis([0.3 0.6]);
% caxis([0.35 1.4]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')

%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
scatter3(ssls(:,1), ssls(:,2),z,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %SSLS
scatter3(-80.991889, 32.020471,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Turner Creek Boat Ramp Sea Level Sensor
scatter3(-81.011631,  32.052507,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Oatland Island Road environmental sensors
scatter3(-81.031204,  32.038669,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Hwy 80 at Grays Creek Sea Level Sensor
scatter3(-81.063662,  32.000149,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %LaRoche Avenue at Nottingham Creek Sea Level Sensor
scatter3(-81.084020,  31.928350,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Faye Drive on Burnside Island Sea Level Sensor
scatter3(-81.153906,  31.935783,100,sz,'filled','o','MarkerFaceColor','m',...
    'MarkerEdgeColor','m'); %Coffee Bluff Marina environmental sensors
%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%

set(gcf,'color','w');

%%
stt=25*3+12;
edt=25*3+12+24;

h3=subplot(2,2,3);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,nanmean(sshd1(:,stt:edt),2))
view(0,90);shading interp;     
colormap(getpmap(7));
hcb=colorbar;
title('Mean');
title(hcb,'m','fontsize', 18)
% title('\color{black}Matthew-total forcing');
% caxis([0.4 0.55]);
% caxis([0.55 0.75]);
caxis([0.3 1]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')

h4=subplot(2,2,4);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,var(sshd1(:,stt:edt),0,2))
view(0,90);shading interp;     
colormap(getpmap(7));
hcb=colorbar;
title(hcb,'m^2','fontsize', 18)
title('Variance');
% caxis([0.5 0.9]);
% caxis([0.85 1.25]);
caxis([0.45 1.15]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')

%%

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

stt=25*3+15;
edt=25*3+15+24;

clf
h1=subplot(2,2,1);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,nanmean(cur1(:,stt:edt),2))
view(0,90);shading interp;     
colormap(getpmap(7));
hcb=colorbar;
title('Mean');
title(hcb,'m','fontsize', 18)
% title('\color{black}Matthew-total forcing');
caxis([0 0.7]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')

h2=subplot(2,2,2);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,var(cur1(:,stt:edt),0,2))
view(0,90);shading interp;     
colormap(getpmap(7));
hcb=colorbar;
title(hcb,'m^2','fontsize', 18)
title('Variance');
caxis([0 0.1]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')

stt=25*3+12;
edt=25*3+12+24;

h3=subplot(2,2,3);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,nanmean(curd1(:,stt:edt),2))
view(0,90);shading interp;     
colormap(getpmap(7));
hcb=colorbar;
title('Mean');
title(hcb,'m','fontsize', 18)
% title('\color{black}Matthew-total forcing');
caxis([0 0.7]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')

h4=subplot(2,2,4);
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle); 
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;
trisurf(element_index,lon,lat,var(curd1(:,stt:edt),0,2))
view(0,90);shading interp;     
colormap(getpmap(7));
hcb=colorbar;
title(hcb,'m^2','fontsize', 18)
title('Variance');
caxis([0 0.06]);
axis([-81.3 -80.65 31.75 32.25]);
box on;
grid on;
graph_handle= gca;
% xticks(-81.3:0.2:-80.65)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.75:0.1:32.25)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 17)
xlabel('Longitude')
ylabel('Latitude')

set(gcf,'color','w');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% geotiff

stt=25*3+15;
edt=25*3+15+24;

value = nanmean(curd1(:,stt:edt),2);
% Create the referencing matrix (R)
R = georasterref('RasterSize',size(value), ...
    'LatitudeLimits',[min(lat) max(lat)],'LongitudeLimits',[min(lon) max(lon)]);

filename = '/Users/kpark350/Downloads/value.tif';
geotiffwrite(filename,value,R)

