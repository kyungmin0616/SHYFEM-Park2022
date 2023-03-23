clear
clc

%% CMEMS

clear CMEMS

file='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/SSH_filter/SSH_2016_1YR.nc';
file2='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/SSH_filter/SSH_2019_1YR.nc';

refDate = datenum('1949-12-31 23:30:00');
% refdate = datenum('1950-01-01 00:00:00');

CMEMS.mtssh=squeeze(ncread(file,'zos'));
CMEMS.mttime=refDate+double(ncread(file,'time'))/24;

CMEMS.drssh=squeeze(ncread(file2,'zos'));
CMEMS.drtime=refDate+double(ncread(file2,'time'))/24;

CMEMS.lon=ncread(file,'longitude');
CMEMS.lat=ncread(file,'latitude');
CMEMS.depth=ncread(file,'depth');

[LON, LAT]=meshgrid(CMEMS.lon, CMEMS.lat);
CMEMS.LON=LON';
CMEMS.LAT=LAT';


%% Low pass
lp_mt_day=12;
lp_dr_day=16;


for i=1:length(CMEMS.lon)
    for j=1:length(CMEMS.lat)
        temp = squeeze(CMEMS.mtssh(i,j,:));
        temp(isnan(temp))=0;
        CMEMS.mtssh_lp(i,j,:)=lowpass(temp,1/(24*lp_mt_day));
        clear temp
  
        temp = squeeze(CMEMS.drssh(i,j,:));     
        temp(isnan(temp))=0;
        CMEMS.drssh_lp(i,j,:)=lowpass(temp,1/(24*lp_dr_day));
        clear temp
        
    end
end

CMEMS.drssh_lp(CMEMS.drssh_lp==0)=NaN;
CMEMS.mtssh_lp(CMEMS.mtssh_lp==0)=NaN;
  


%% ECMWF
clear file file2
files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ECMWF/SAV/Matthew');
files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/ECMWF/SAV/Dorian');
files(1:3)=[];
files(end)=[];
files2(1:3)=[];
files2(end)=[];

refDate = datenum('1900-01-01 00:00:00');

LONO = ncread([files(1).folder '/' files(1).name], 'longitude');
LATO = ncread([files(1).folder '/' files(1).name], 'latitude');

[LON,LAT]=meshgrid(LONO,LATO);
ECMWF_MT.LON=LON'; ECMWF_MT.LAT=LAT';
clear LON LAT LONO LATO

LONO = ncread([files2(1).folder '/' files2(1).name], 'longitude');
LATO = ncread([files2(1).folder '/' files2(1).name], 'latitude');

[LON2,LAT2]=meshgrid(LONO,LATO);
ECMWF_DR.LON=LON2'; ECMWF_DR.LAT=LAT2';
clear LON2 LAT2 LONO LATO

% Data loading
% Matthew

k=1;
for i=1:length(files)
    clear temp time tempu tempv
    temp = ncread([files(i).folder '/' files(i).name], 'msl');
    time = double(ncread([files(i).folder '/' files(i).name], 'time'));
    tempu = ncread([files(i).folder '/' files(i).name], 'u10');
    tempv = ncread([files(i).folder '/' files(i).name], 'v10');
    for j=1:4
    ECMWF_MT.u(:,:,k)= tempu(:,:,j);
    ECMWF_MT.v(:,:,k)= tempv(:,:,j);
    ECMWF_MT.p(:,:,k)= temp(:,:,j);
    ECMWF_MT.time(k,1)=refDate+time(j)/24;
    k=k+1;
    end

    
end


k=1;
for i=1:length(files2)
    clear temp time tempu tempv
    temp = ncread([files2(i).folder '/' files2(i).name], 'msl');
    time = double(ncread([files2(i).folder '/' files2(i).name], 'time'));
    tempu = ncread([files2(i).folder '/' files2(i).name], 'u10');
    tempv = ncread([files2(i).folder '/' files2(i).name], 'v10');
    for j=1:4
    ECMWF_DR.u(:,:,k)= tempu(:,:,j);
    ECMWF_DR.v(:,:,k)= tempv(:,:,j);
    ECMWF_DR.p(:,:,k)= temp(:,:,j);
    ECMWF_DR.time(k,1)=refDate+time(j)/24;
    k=k+1;
    end

    
    
end

clear temp time tempu tempv files files2 refDate

%% Matthew




lonmin=-82;
lonmax=-73;
latmin=24;
latmax=36;
gczft=18;

fw=0.51;
fh=1;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

CIDX=find(datenum("2016-10-07 18:00:00")==CMEMS.mttime);
EIDX=find(datenum("2016-10-07 18:00:00")==ECMWF_MT.time);

h1=subplot(3,4,1);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb1=colorbar('northoutside');
title(colb1,'Low-pass filtered SSH (m)', 'FontWeight', 'bold')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
ylabel('Latitude', 'FontWeight', 'bold')
% title('SSH low-pass');
graph_handle= gca;
xticks(lonmin:2:lonmax)
yticks(latmin:2:latmax)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca,'XTickLabel',[]);
set(gca, 'FontSize', gczft)

h2=subplot(3,4,2);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,CIDX)-CMEMS.mtssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb2=colorbar('northoutside');
title(colb2,'High-pass filtered SSH (m)', 'FontWeight', 'bold')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('SSH high-pass');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

skp=8;
h3=subplot(3,4,3);
pcolorjw(ECMWF_MT.LON, ECMWF_MT.LAT, sqrt(ECMWF_MT.u(:,:,EIDX).^2 + ECMWF_MT.v(:,:,EIDX).^2)); hold on
h = quiver(ECMWF_MT.LON(1:skp:end,1:skp:end), ECMWF_MT.LAT(1:skp:end,1:skp:end),ECMWF_MT.u(1:skp:end,1:skp:end,EIDX),ECMWF_MT.v(1:skp:end,1:skp:end,EIDX),1.5,'w','LineWidth',2);
h.Head.LineStyle = 'solid';          
SAB_coast
colormap(gca,getpmap(7));
colb3=colorbar('northoutside');
caxis([0 30])
title(colb3,'Wind speed (m/s)', 'FontWeight', 'bold')
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Wind field');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

h4=subplot(3,4,4);
pcolorjw(ECMWF_MT.LON, ECMWF_MT.LAT, ECMWF_MT.p(:,:,EIDX)/100); hold on
SAB_coast
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Air pressure');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
colb4=colorbar('northoutside');
title(colb4,'Air pressure (mbar)', 'FontWeight', 'bold')
h4_gca=gca;
colm1=colormap(getpmap(7));
colm1(end-1:end,:) = 1;
caxis([950 1010])
colormap(gca,colm1);
set(gca, 'FontSize', gczft)

CIDX=find(datenum("2016-10-08 06:00:00")==CMEMS.mttime);
EIDX=find(datenum("2016-10-08 06:00:00")==ECMWF_MT.time);

h5=subplot(3,4,5);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
ylabel('Latitude', 'FontWeight', 'bold')
% title('SSH low-pass');
graph_handle= gca;
xticks(lonmin:2:lonmax)
set(gca,'XTickLabel',[]);
yticks(latmin:2:latmax)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca, 'FontSize', gczft)

h6=subplot(3,4,6);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,CIDX)-CMEMS.mtssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('SSH high-pass');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

skp=8;
h7=subplot(3,4,7);
pcolorjw(ECMWF_MT.LON, ECMWF_MT.LAT, sqrt(ECMWF_MT.u(:,:,EIDX).^2 + ECMWF_MT.v(:,:,EIDX).^2)); hold on
h = quiver(ECMWF_MT.LON(1:skp:end,1:skp:end), ECMWF_MT.LAT(1:skp:end,1:skp:end),ECMWF_MT.u(1:skp:end,1:skp:end,EIDX),ECMWF_MT.v(1:skp:end,1:skp:end,EIDX),1.5,'w','LineWidth',2);
h.Head.LineStyle = 'solid';          
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m/s')
caxis([0 30])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Wind field');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

h8=subplot(3,4,8);
pcolorjw(ECMWF_MT.LON, ECMWF_MT.LAT, ECMWF_MT.p(:,:,EIDX)/100); hold on
SAB_coast
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Air pressure');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
% colb=colorbar;
% title(colb,'mbar')
caxis([950 1010])
colormap(gca,colm1);
set(gca, 'FontSize', gczft)

CIDX=find(datenum("2016-10-08 18:00:00")==CMEMS.mttime);
EIDX=find(datenum("2016-10-08 18:00:00")==ECMWF_MT.time);

h9=subplot(3,4,9);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
xlabel('Longitude', 'FontWeight', 'bold')
ylabel('Latitude', 'FontWeight', 'bold')
% title('SSH low-pass');
graph_handle= gca;
xticks(lonmin:2:lonmax)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(latmin:2:latmax)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca, 'FontSize', gczft)

h10=subplot(3,4,10);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,CIDX)-CMEMS.mtssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('SSH high-pass');
xlabel('Longitude', 'FontWeight', 'bold')
graph_handle= gca;
xticks(lonmin:2:lonmax)
yticks(latmin:2:latmax)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

skp=8;
h11=subplot(3,4,11);
pcolorjw(ECMWF_MT.LON, ECMWF_MT.LAT, sqrt(ECMWF_MT.u(:,:,EIDX).^2 + ECMWF_MT.v(:,:,EIDX).^2)); hold on
h = quiver(ECMWF_MT.LON(1:skp:end,1:skp:end), ECMWF_MT.LAT(1:skp:end,1:skp:end),ECMWF_MT.u(1:skp:end,1:skp:end,EIDX),ECMWF_MT.v(1:skp:end,1:skp:end,EIDX),1.5,'w','LineWidth',2);
h.Head.LineStyle = 'solid';          
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m/s')
caxis([0 30])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Wind field');
xlabel('Longitude', 'FontWeight', 'bold')
graph_handle= gca;
xticks(lonmin:2:lonmax)
yticks(latmin:2:latmax)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

h12=subplot(3,4,12);
pcolorjw(ECMWF_MT.LON, ECMWF_MT.LAT, ECMWF_MT.p(:,:,EIDX)/100); hold on
SAB_coast
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Air pressure');
xlabel('Longitude', 'FontWeight', 'bold')
graph_handle= gca;
xticks(lonmin:2:lonmax)
yticks(latmin:2:latmax)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');set(gca,'YTickLabel',[]);
% colb=colorbar;
% title(colb,'mbar')
caxis([950 1010])
colormap(gca,colm1);
set(gca, 'FontSize', gczft)



sp_width= 0.1/fw;
sp_height= 0.1*2.5/fh;
x_gap=0.05;
y_gap=0.05;

x1 = 0.059;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap;
x4 = x3+sp_width+x_gap;
y1 = 0.66;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x4 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h5,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x2 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h7,'Position',[x3 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x4 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h9,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h10,'Position',[x2 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h11,'Position',[x3 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h12,'Position',[x4 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

colb1.Position=[0.059244126659857,0.917909030147395,0.19611848825332,0.017448200654308];

colb1.Ticks=[-0.4 0.2 0.8];
colb2.Ticks=[-0.4 0.2 0.8];
colb4.Ticks=[950 980 1005];

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge:TIde/StomSurge/Figures/MAP_SSH_AP_WIND_MT_12days.png'));

%% Dorian



lonmin=-82;
lonmax=-73;
latmin=24;
latmax=36;
gczft=18;

fw=0.51;
fh=1;

hf=figure('units','normalized','position',[0 0 fw fh]);
set(hf, 'Visible', 'off');


CIDX=find(datenum("2019-09-05 00:00:00")==CMEMS.drtime);
EIDX=find(datenum("2019-09-05 00:00:00")==ECMWF_DR.time);

h1=subplot(3,4,1);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb1=colorbar('northoutside');
title(colb1,'Low-pass filtered SSH (m)', 'FontWeight', 'bold')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
ylabel('Latitude', 'FontWeight', 'bold')
% title('SSH low-pass');
graph_handle= gca;
xticks(lonmin:2:lonmax)
yticks(latmin:2:latmax)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca,'XTickLabel',[]);
set(gca, 'FontSize', gczft)

h2=subplot(3,4,2);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh(:,:,CIDX)-CMEMS.drssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb2=colorbar('northoutside');
title(colb2,'High-pass filtered SSH (m)', 'FontWeight', 'bold')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('SSH high-pass');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

skp=8;
h3=subplot(3,4,3);
pcolorjw(ECMWF_DR.LON, ECMWF_DR.LAT, sqrt(ECMWF_DR.u(:,:,EIDX).^2 + ECMWF_DR.v(:,:,EIDX).^2)); hold on
h = quiver(ECMWF_DR.LON(1:skp:end,1:skp:end), ECMWF_DR.LAT(1:skp:end,1:skp:end),ECMWF_DR.u(1:skp:end,1:skp:end,EIDX),ECMWF_DR.v(1:skp:end,1:skp:end,EIDX),1.5,'w','LineWidth',2);
h.Head.LineStyle = 'solid'; 
SAB_coast
colormap(gca,getpmap(7));
colb3=colorbar('northoutside');
caxis([0 30])
title(colb3,'Wind speed (m/s)', 'FontWeight', 'bold')
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Wind field');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

h4=subplot(3,4,4);
pcolorjw(ECMWF_DR.LON, ECMWF_DR.LAT, ECMWF_DR.p(:,:,EIDX)/100); hold on
SAB_coast
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Air pressure');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
colb4=colorbar('northoutside');
title(colb4,'Air pressure (mbar)', 'FontWeight', 'bold')
h4_gca=gca;
colm1=colormap(getpmap(7));
colm1(end-1:end,:) = 1;
caxis([950 1010])
colormap(gca,colm1);
set(gca, 'FontSize', gczft)

CIDX=find(datenum("2019-09-05 12:00:00")==CMEMS.drtime);
EIDX=find(datenum("2019-09-05 12:00:00")==ECMWF_DR.time);

h5=subplot(3,4,5);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
ylabel('Latitude', 'FontWeight', 'bold')
% title('SSH low-pass');
graph_handle= gca;
xticks(lonmin:2:lonmax)
set(gca,'XTickLabel',[]);
yticks(latmin:2:latmax)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca, 'FontSize', gczft)

h6=subplot(3,4,6);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh(:,:,CIDX)-CMEMS.drssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('SSH high-pass');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

skp=8;
h7=subplot(3,4,7);
pcolorjw(ECMWF_DR.LON, ECMWF_DR.LAT, sqrt(ECMWF_DR.u(:,:,EIDX).^2 + ECMWF_DR.v(:,:,EIDX).^2)); hold on
h = quiver(ECMWF_DR.LON(1:skp:end,1:skp:end), ECMWF_DR.LAT(1:skp:end,1:skp:end),ECMWF_DR.u(1:skp:end,1:skp:end,EIDX),ECMWF_DR.v(1:skp:end,1:skp:end,EIDX),1.5,'w','LineWidth',2);
h.Head.LineStyle = 'solid';          
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m/s')
caxis([0 30])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Wind field');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

h8=subplot(3,4,8);
pcolorjw(ECMWF_DR.LON, ECMWF_DR.LAT, ECMWF_DR.p(:,:,EIDX)/100); hold on
SAB_coast
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Air pressure');
xticks(lonmin:4:lonmax)
yticks(latmin:2:latmax)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
% colb=colorbar;
% title(colb,'mbar')
caxis([950 1010])
colormap(gca,colm1);
set(gca, 'FontSize', gczft)

CIDX=find(datenum("2019-09-06 06:00:00")==CMEMS.drtime);
EIDX=find(datenum("2019-09-06 06:00:00")==ECMWF_DR.time);

h9=subplot(3,4,9);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
xlabel('Longitude', 'FontWeight', 'bold')
ylabel('Latitude', 'FontWeight', 'bold')
% title('SSH low-pass');
graph_handle= gca;
xticks(lonmin:2:lonmax)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(latmin:2:latmax)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(gca, 'FontSize', gczft)

h10=subplot(3,4,10);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.drssh(:,:,CIDX)-CMEMS.drssh_lp(:,:,CIDX)); hold on
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m')
caxis([-0.4 0.8])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('SSH high-pass');
xlabel('Longitude', 'FontWeight', 'bold')
graph_handle= gca;
xticks(lonmin:2:lonmax)
yticks(latmin:2:latmax)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

skp=8;
h11=subplot(3,4,11);
pcolorjw(ECMWF_DR.LON, ECMWF_DR.LAT, sqrt(ECMWF_DR.u(:,:,EIDX).^2 + ECMWF_DR.v(:,:,EIDX).^2)); hold on
h = quiver(ECMWF_DR.LON(1:skp:end,1:skp:end), ECMWF_DR.LAT(1:skp:end,1:skp:end),ECMWF_DR.u(1:skp:end,1:skp:end,EIDX),ECMWF_DR.v(1:skp:end,1:skp:end,EIDX),1.5,'w','LineWidth',2);
h.Head.LineStyle = 'solid';          
SAB_coast
colormap(gca,getpmap(7));
% colb=colorbar;
% title(colb,'m/s')
caxis([0 30])
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Wind field');
xlabel('Longitude', 'FontWeight', 'bold')
graph_handle= gca;
xticks(lonmin:2:lonmax)
yticks(latmin:2:latmax)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');set(gca,'YTickLabel',[]);
set(gca, 'FontSize', gczft)

h12=subplot(3,4,12);
pcolorjw(ECMWF_DR.LON, ECMWF_DR.LAT, ECMWF_DR.p(:,:,EIDX)/100); hold on
SAB_coast
axis([lonmin lonmax latmin latmax]) % axis criterian
% title('Air pressure');
xlabel('Longitude', 'FontWeight', 'bold')
graph_handle= gca;
xticks(lonmin:2:lonmax)
yticks(latmin:2:latmax)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');set(gca,'YTickLabel',[]);
% colb=colorbar;
% title(colb,'mbar')
caxis([950 1010])
colormap(gca,colm1);
set(gca, 'FontSize', gczft)



sp_width= 0.1/fw;
sp_height= 0.1*2.5/fh;
x_gap=0.05;
y_gap=0.05;

x1 = 0.059;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap;
x4 = x3+sp_width+x_gap;
y1 = 0.66;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x4 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h5,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x2 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h7,'Position',[x3 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x4 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h9,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h10,'Position',[x2 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h11,'Position',[x3 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h12,'Position',[x4 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

colb1.Position=[0.059244126659857,0.917909030147395,0.19611848825332,0.017448200654308];

colb1.Ticks=[-0.4 0.2 0.8];
colb2.Ticks=[-0.4 0.2 0.8];
colb4.Ticks=[950 980 1005];

saveas(hf,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge:TIde/StomSurge/Figures/MAP_SSH_AP_WIND_DR_16days.png'));
