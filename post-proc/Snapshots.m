clear
clc

%% CMEMS
clear CMEMS
% file='/Volumes/ExternalHDD/DataSet/CMEMS/Matthew_LG.nc';
% file2='/Volumes/ExternalHDD/DataSet/CMEMS/Dorian_LG.nc';
file='/Volumes/ExternalHDD/DataSet/CMEMS/SSH_filter/SSH_2016_1YR.nc';
file2='/Volumes/ExternalHDD/DataSet/CMEMS/SSH_filter/SSH_2017_2YR.nc';

% refdate = datenum('1950-01-01 00:00:00');
refdate = datenum('1949-12-31 23:30:00');


CMEMS.mtssh=ncread(file,'zos')+0.4337;
CMEMS.mttime=refdate+double(ncread(file,'time'))/24;
% CMEMS.mttmp=ncread(file,'thetao');

CMEMS.drssh=ncread(file2,'zos')+0.4599;
CMEMS.drtime=refdate+double(ncread(file2,'time'))/24;
% CMEMS.drtmp=ncread(file2,'thetao');

lon=ncread(file,'longitude');
lat=ncread(file,'latitude');

[LON, LAT]=meshgrid(lon, lat);
CMEMS.LON=LON';
CMEMS.LAT=LAT';

clear lon lat LON LAT file file2

%% ECMWF
clear ECMWF

files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ECMWF/SAV/Dorian');
files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ECMWF/SAV/Matthew');
files(1:3)=[];
files(end)=[];
files2(1:3)=[];
files2(end)=[];

refDate = datenum('1900-01-01 00:00:00');

LONO = ncread([files2(1).folder '/' files2(1).name], 'longitude');
LATO = ncread([files2(1).folder '/' files2(1).name], 'latitude');

[LON,LAT]=meshgrid(LONO,LATO);
ECMWF.mtLON=LON'; ECMWF.mtLAT=LAT';

LONO = ncread([files(1).folder '/' files(1).name], 'longitude');
LATO = ncread([files(1).folder '/' files(1).name], 'latitude');

[LON2,LAT2]=meshgrid(LONO,LATO);
ECMWF.drLON=LON2'; ECMWF.drLAT=LAT2';

% Data loading
k=1;
for i=1:length(files2)
    
    temp = ncread([files2(i).folder '/' files2(i).name], 'msl');
    time = double(ncread([files2(i).folder '/' files2(i).name], 'time'));
    tempu = ncread([files2(i).folder '/' files2(i).name], 'u10');
    tempv = ncread([files2(i).folder '/' files2(i).name], 'v10');
    for j=1:4
    ECMWF.mtu(:,:,k)= tempu(:,:,j);
    ECMWF.mtv(:,:,k)= tempv(:,:,j);
    ECMWF.mtmsl(:,:,k)= temp(:,:,j);
    ECMWF.mttime(k,1)=refDate+time(j)/24;
    k=k+1;
    end

    
end


k=1;
for i=1:length(files)
    
    temp = ncread([files(i).folder '/' files(i).name], 'msl');
    time = double(ncread([files(i).folder '/' files(i).name], 'time'));
    tempu = ncread([files(i).folder '/' files(i).name], 'u10');
    tempv = ncread([files(i).folder '/' files(i).name], 'v10');
    for j=1:4
    ECMWF.dru(:,:,k)= tempu(:,:,j);
    ECMWF.drv(:,:,k)= tempv(:,:,j);
    ECMWF.drmsl(:,:,k)= temp(:,:,j);
    ECMWF.drtime(k,1)=refDate+time(j)/24;
    k=k+1;
    end

    
    
end

clear LON LAT LON2 LAT2 LONO LATO temp tempu tempv time refdate refDate files files2


%% Low pass
lp_mt_day=72;
lp_dr_day=72;

fti= 1/(60*60*24*9);
fs= 1/(60*60);

clear temp


for i=1:length(CMEMS.LON)
    for j=1:length(CMEMS.LAT)
        temp = squeeze(CMEMS.mtssh(i,j,1,:));
        temp(isnan(temp))=0;
        CMEMS.mtssh_lp216(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
  
        temp = squeeze(CMEMS.drssh(i,j,1,:));     
        temp(isnan(temp))=0;
        CMEMS.drssh_lp216(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
        
    end
end


fti= 1 / (60*60*24*15);
fs= 1/(60*60);

clear temp


for i=1:length(CMEMS.LON)
    for j=1:length(CMEMS.LAT)
        temp = squeeze(CMEMS.mtssh(i,j,1,:));
        temp(isnan(temp))=0;
        CMEMS.mtssh_lp360(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
  
        temp = squeeze(CMEMS.drssh(i,j,1,:));     
        temp(isnan(temp))=0;
        CMEMS.drssh_lp360(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
        
    end
end



fti= 1 / (60*60*24*12);
fs= 1/(60*60);

clear temp


for i=1:length(CMEMS.LON)
    for j=1:length(CMEMS.LAT)
        temp = squeeze(CMEMS.mtssh(i,j,1,:));
        temp(isnan(temp))=0;
        CMEMS.mtssh_lp288(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
  
        temp = squeeze(CMEMS.drssh(i,j,1,:));     
        temp(isnan(temp))=0;
        CMEMS.drssh_lp288(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
        
    end
end

save('CMEMS_LP3.mat', 'CMEMS', '-v7.3')

CMEMS.mtssh_lp96(CMEMS.mtssh_lp96==0)=NaN;
CMEMS.drssh_lp96(CMEMS.drssh_lp96==0)=NaN;
  
CMEMS.mtssh_lp120(CMEMS.mtssh_lp120==0)=NaN;
CMEMS.drssh_lp120(CMEMS.drssh_lp120==0)=NaN;
  
CMEMS.mtssh_lp144(CMEMS.mtssh_lp144==0)=NaN;
CMEMS.drssh_lp144(CMEMS.drssh_lp144==0)=NaN;
  

CMEMS.mtssh_lp72(CMEMS.mtssh_lp72==0)=NaN;
CMEMS.drssh_lp72(CMEMS.drssh_lp72==0)=NaN;
  

CMEMS.mtssh_lp48(CMEMS.mtssh_lp48==0)=NaN;
CMEMS.drssh_lp48(CMEMS.drssh_lp48==0)=NaN;


CMEMS.mtssh_lp24(CMEMS.mtssh_lp24==0)=NaN;
CMEMS.drssh_lp24(CMEMS.drssh_lp24==0)=NaN;

CMEMS.mtssh_lp216(CMEMS.mtssh_lp216==0)=NaN;
CMEMS.drssh_lp216(CMEMS.drssh_lp216==0)=NaN;

CMEMS.mtssh_lp288(CMEMS.mtssh_lp288==0)=NaN;
CMEMS.drssh_lp288(CMEMS.drssh_lp288==0)=NaN;

CMEMS.mtssh_lp360(CMEMS.mtssh_lp360==0)=NaN;
CMEMS.drssh_lp360(CMEMS.drssh_lp360==0)=NaN;

%% 2D Map

%Matthew



clw=-0.5;
chi=1.5;

clw_p=980;
chi_p=1020;

clw_w=0;
chi_w=30;

skp=5;
ftz=26;

%%%%%%%%%%%%%%%% SSH


fw=1;
fh=1;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf
%CMEMS
h1=subplot(1,3,1);
I=find(CMEMS.mttime==datenum('2016-09-26 00:00:00'));
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
xlabel('Longitude')
ylabel('Latitude')
set(gca, 'FontSize', ftz)
caxis([clw chi])

h2=subplot(1,3,2);
I=find(CMEMS.mttime==datenum('2016-10-08 00:00:00'));
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
xlabel('Longitude')
ylabel('Latitude')
set(gca, 'FontSize', ftz)
caxis([clw chi])

h3=subplot(1,3,3);
I=find(CMEMS.mttime==datenum('2016-10-14 00:00:00'));
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
xlabel('Longitude')
ylabel('Latitude')
set(gca, 'FontSize', ftz)
caxis([clw chi])
set(gcf,'color','w')



%%%%%%%%%%%%%%%% Temperature


clw=20;
chi=32.5;

clw_p=980;
chi_p=1020;

clw_w=0;
chi_w=30;

skp=5;
ftz=26;

fw=1;
fh=1;
% 
% h=figure('units','normalized','position',[0 0 fw fh]);
% set(h, 'Visible', 'on');

clf
%CMEMS
h1=subplot(1,3,1);
I=find(CMEMS.mttime==datenum('2016-09-26 00:00:00'));
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mttmp(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'deg')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
title([datestr(CMEMS.mttime(I), 'yyyy-mm-dd')],'FontSize',ftz);
xlabel('Longitude')
ylabel('Latitude')
set(gca, 'FontSize', ftz)
caxis([clw chi])

h2=subplot(1,3,2);
I=find(CMEMS.mttime==datenum('2016-10-08 00:00:00'));
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mttmp(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
title([datestr(CMEMS.mttime(I), 'yyyy-mm-dd')],'FontSize',ftz);
xlabel('Longitude')
ylabel('Latitude')
set(gca, 'FontSize', ftz)
caxis([clw chi])

h3=subplot(1,3,3);
I=find(CMEMS.mttime==datenum('2016-10-14 00:00:00'));
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mttmp(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'deg')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
title([datestr(CMEMS.mttime(I), 'yyyy-mm-dd')],'FontSize',ftz);
xlabel('Longitude')
ylabel('Latitude')
set(gca, 'FontSize', ftz)
caxis([clw chi])
set(gcf,'color','w')



%% ECMWF
I=find(ECMWF.mttime==datenum('2016-10-08 00:00:00'));

clw_w=0;
chi_w=30;

skp=1;
ftz=26;

figure(1)
clf
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, sqrt(ECMWF.mtu(:,:,I).^2 + ECMWF.mtv(:,:,I).^2)); hold on
h = quiver(ECMWF.mtLON(1:skp:end,1:skp:end), ECMWF.mtLAT(1:skp:end,1:skp:end),ECMWF.mtu(1:skp:end,1:skp:end,I),ECMWF.mtv(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
caxis([clw_w chi_w])
title(colb,'m/s')
axis([-82.5 -78 29 33]) % axis criterian
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
title('');
xlabel('Longitude')
ylabel('Latitude')
set(gca, 'FontSize', ftz)
set(gcf,'color','w')
%%

%CMEMS
I=find(CMEMS.mttime==datenum('2016-10-08 06:00:00'));

h6=subplot(3,5,6);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,1,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca,'XTickLabel',[]);
title('SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h7=subplot(3,5,7);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh_lp288(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('LPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h8=subplot(3,5,8);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,1,I)-CMEMS.mtssh_lp288(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('HPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

%ECMWF
I=find(ECMWF.mttime==datenum('2016-10-08 06:00:00'));

h9=subplot(3,5,9);
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, ECMWF.mtmsl(:,:,I)/100); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'mb')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('AP');
caxis([clw_p chi_p])
set(gca, 'FontSize', ftz)

h10=subplot(3,5,10);
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, sqrt(ECMWF.mtu(:,:,I).^2 + ECMWF.mtv(:,:,I).^2)); hold on
h = quiver(ECMWF.mtLON(1:skp:end,1:skp:end), ECMWF.mtLAT(1:skp:end,1:skp:end),ECMWF.mtu(1:skp:end,1:skp:end,I),ECMWF.mtv(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
caxis([clw_w chi_w])
title(colb,'m/s')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('WSV');
set(gca, 'FontSize', ftz)


%CMEMS
I=find(CMEMS.mttime==datenum('2016-10-07 18:00:00'));

h11=subplot(3,5,11);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,1,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
title('SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h12=subplot(3,5,12);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh_lp288(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
set(gca,'YTickLabel',[]);
title('LPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h13=subplot(3,5,13);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,1,I)-CMEMS.mtssh_lp288(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
set(gca,'YTickLabel',[]);
title('HPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

%ECMWF
I=find(ECMWF.mttime==datenum('2016-10-07 18:00:00'));

h14=subplot(3,5,14);
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, ECMWF.mtmsl(:,:,I)/100); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'mb')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
set(gca,'YTickLabel',[]);
title('AP');
caxis([clw_p chi_p])
set(gca, 'FontSize', ftz)

h15=subplot(3,5,15);
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, sqrt(ECMWF.mtu(:,:,I).^2 + ECMWF.mtv(:,:,I).^2)); hold on
h = quiver(ECMWF.mtLON(1:skp:end,1:skp:end), ECMWF.mtLAT(1:skp:end,1:skp:end),ECMWF.mtu(1:skp:end,1:skp:end,I),ECMWF.mtv(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
caxis([clw_w chi_w])
title(colb,'m/s')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
set(gca,'YTickLabel',[]);
title('WSV');
set(gca, 'FontSize', ftz)





sp_width= 0.145;
sp_height= 0.25;
x_gap=0.03;
y_gap=0.08;

x1 = 0.025;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap;
x4 = x3+sp_width+x_gap+0.035;
x5 = x4+sp_width+x_gap+0.05;


y1 = 0.71;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;


set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x4 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x5 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h6,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h7,'Position',[x2 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x3 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h9,'Position',[x4 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h10,'Position',[x5 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h11,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h12,'Position',[x2 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h13,'Position',[x3 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h14,'Position',[x4 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h15,'Position',[x5 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_filter.png',1));




%% Dorian


clw=-0.5;
chi=1.5;

clw_p=980;
chi_p=1020;

clw_w=0;
chi_w=30;

skp=5;
ftz=26;

%%%%%%%%%%%%%%%%

fw=1;
fh=1;
% 
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

%CMEMS
I=find(CMEMS.drtime==datenum('2019-09-06 06:00:00'));

h1=subplot(3,5,1);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh(:,:,1,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca,'XTickLabel',[]);
title('SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h2=subplot(3,5,2);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh_lp72(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('LPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h3=subplot(3,5,3);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh(:,:,1,I)-CMEMS.drssh_lp72(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('HPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

%ECMWF
I=find(ECMWF.drtime==datenum('2019-09-06 06:00:00'));

h4=subplot(3,5,4);
pcolorjw(ECMWF.drLON, ECMWF.drLAT, ECMWF.drmsl(:,:,I)/100); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'mb')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('AP');
caxis([clw_p chi_p])
set(gca, 'FontSize', ftz)

h5=subplot(3,5,5);
pcolorjw(ECMWF.drLON, ECMWF.drLAT, sqrt(ECMWF.dru(:,:,I).^2 + ECMWF.drv(:,:,I).^2)); hold on
h = quiver(ECMWF.drLON(1:skp:end,1:skp:end), ECMWF.drLAT(1:skp:end,1:skp:end),ECMWF.dru(1:skp:end,1:skp:end,I),ECMWF.drv(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
caxis([clw_w chi_w])
title(colb,'m/s')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('WSV');
set(gca, 'FontSize', ftz)



%CMEMS
I=find(CMEMS.drtime==datenum('2019-09-05 12:00:00'));

h6=subplot(3,5,6);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh(:,:,1,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca,'XTickLabel',[]);
title('SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h7=subplot(3,5,7);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh_lp72(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('LPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h8=subplot(3,5,8);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh(:,:,1,I)-CMEMS.drssh_lp72(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('HPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

%ECMWF
I=find(ECMWF.drtime==datenum('2019-09-05 12:00:00'));

h9=subplot(3,5,9);
pcolorjw(ECMWF.drLON, ECMWF.drLAT, ECMWF.drmsl(:,:,I)/100); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'mb')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('AP');
caxis([clw_p chi_p])
set(gca, 'FontSize', ftz)

h10=subplot(3,5,10);
pcolorjw(ECMWF.drLON, ECMWF.drLAT, sqrt(ECMWF.dru(:,:,I).^2 + ECMWF.drv(:,:,I).^2)); hold on
h = quiver(ECMWF.drLON(1:skp:end,1:skp:end), ECMWF.drLAT(1:skp:end,1:skp:end),ECMWF.dru(1:skp:end,1:skp:end,I),ECMWF.drv(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
caxis([clw_w chi_w])
title(colb,'m/s')
axis([-82 -73 24 36]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('WSV');
set(gca, 'FontSize', ftz)


%CMEMS
I=find(CMEMS.drtime==datenum('2019-09-05 00:00:00'));

h11=subplot(3,5,11);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh(:,:,1,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
yticks(24:4:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
title('SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h12=subplot(3,5,12);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh_lp72(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
set(gca,'YTickLabel',[]);
title('LPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h13=subplot(3,5,13);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh(:,:,1,I)-CMEMS.drssh_lp72(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
set(gca,'YTickLabel',[]);
title('HPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

%ECMWF
I=find(ECMWF.drtime==datenum('2019-09-05 00:00:00'));

h14=subplot(3,5,14);
pcolorjw(ECMWF.drLON, ECMWF.drLAT, ECMWF.drmsl(:,:,I)/100); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'mb')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
set(gca,'YTickLabel',[]);
title('AP');
caxis([clw_p chi_p])
set(gca, 'FontSize', ftz)

h15=subplot(3,5,15);
pcolorjw(ECMWF.drLON, ECMWF.drLAT, sqrt(ECMWF.dru(:,:,I).^2 + ECMWF.drv(:,:,I).^2)); hold on
h = quiver(ECMWF.drLON(1:skp:end,1:skp:end), ECMWF.drLAT(1:skp:end,1:skp:end),ECMWF.dru(1:skp:end,1:skp:end,I),ECMWF.drv(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
caxis([clw_w chi_w])
title(colb,'m/s')
axis([-82 -73 24 36]) % axis criterian
graph_handle= gca;
xticks(-82:4:-73)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
set(gca,'YTickLabel',[]);
title('WSV');
set(gca, 'FontSize', ftz)





sp_width= 0.145;
sp_height= 0.25;
x_gap=0.03;
y_gap=0.08;

x1 = 0.025;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap;
x4 = x3+sp_width+x_gap+0.035;
x5 = x4+sp_width+x_gap+0.05;


y1 = 0.71;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;


set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x4 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x5 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h6,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h7,'Position',[x2 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x3 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h9,'Position',[x4 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h10,'Position',[x5 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h11,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h12,'Position',[x2 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h13,'Position',[x3 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h14,'Position',[x4 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h15,'Position',[x5 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_filter2_1.png',1));

