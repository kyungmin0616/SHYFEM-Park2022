clear
clc

%% CMEMS
clear CMEMS
file='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/SSH_filter/SSH_2016_1YR.nc';
file2='/Users/kpark350/Ga_tech/Projects/DataSet/CMEMS/SSH_filter/SSH_2019_1YR.nc';

% refdate = datenum('1950-01-01 00:00:00');
refdate = datenum('1949-12-31 23:30:00');


CMEMS.mtssh=ncread(file,'zos')+0.4337;
CMEMS.mttime=refdate+double(ncread(file,'time'))/24;

CMEMS.drssh=ncread(file2,'zos')+0.4599;
CMEMS.drtime=refdate+double(ncread(file2,'time'))/24;

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


% ECMWF

fti= 1/(60*60*24*13);
fs= 1/(60*60*6);

clear temp


for i=1:length(ECMWF.mtLON(:,1))
    for j=1:length(ECMWF.mtLAT(1,:))
        temp = squeeze(ECMWF.mtu(i,j,:));
        temp(isnan(temp))=0;
        ECMWF.mtu_lp(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
  
        temp = squeeze(ECMWF.mtv(i,j,:));
        temp(isnan(temp))=0;
        ECMWF.mtv_lp(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
        
    end
end

fti= 1/(60*60*24*13);
fs= 1/(60*60*6);

clear temp


for i=1:length(ECMWF.drLON(:,1))
    for j=1:length(ECMWF.drLAT(1,:))
        temp = squeeze(ECMWF.dru(i,j,:));
        temp(isnan(temp))=0;
        ECMWF.dru_lp(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
  
        temp = squeeze(ECMWF.drv(i,j,:));
        temp(isnan(temp))=0;
        ECMWF.drv_lp(i,j,:)=lowpass(temp,fti,fs,'Steepness',0.999999999);
        clear temp
        
    end
end

save('ECMWF.mat', 'ECMWF', '-v7.3')

ECMWF.mtv_hp = ECMWF.mtv(:,:,1:76)-ECMWF.mtv_lp(:,:,1:76);
ECMWF.mtu_hp = ECMWF.mtu(:,:,1:76)-ECMWF.mtu_lp(:,:,1:76);


ECMWF.dru_lp(ECMWF.dru_lp==0)=NaN;
ECMWF.drv_lp(ECMWF.drv_lp==0)=NaN;

ECMWF.dru_lp(ECMWF.dru_lp==0)=NaN;
ECMWF.drv_lp(ECMWF.drv_lp==0)=NaN;
  

%%

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

skp=3;
ftz=26;

%%%%%%%%%%%%%%%%

fw=1;
fh=1;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

minlo=-81.8;
maxlo=-77.2;
minla=27.5;
maxla=33.5;

tg_time='2016-10-08 06:00:00';

clf
%CMEMS
I=find(CMEMS.mttime==datenum(tg_time));

h1=subplot(1,3,1);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,I)-CMEMS.mtssh_lp(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m')
% axis([-82 -73 24 36]) % axis criterian
axis([minlo maxlo minla maxla]) % axis criterian

graph_handle= gca;
% yticks(27:3:33)
% ytickformat('%.f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
% xticks(-81:1:-77)
% xtickformat('%.f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
title('HPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h2=subplot(1,3,2);
pcolorjw(CMEMS.LON, CMEMS.LAT, sqrt(CMEMS.mtu(:,:,I).^2 + CMEMS.mtv(:,:,I).^2)); hold on
h = quiver(CMEMS.LON(1:skp:end,1:skp:end), CMEMS.LAT(1:skp:end,1:skp:end),CMEMS.mtu(1:skp:end,1:skp:end,I),CMEMS.mtv(1:skp:end,1:skp:end,I),5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m/s')
% axis([-82 -73 24 36]) % axis criterian
axis([minlo maxlo minla maxla]) % axis criterian
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
title('Current');
set(gca, 'FontSize', ftz)
% caxis([clw chi])

I=find(ECMWF.mttime==datenum(tg_time));
h5=subplot(1,3,3);
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, sqrt(ECMWF.mtu(:,:,I).^2 + ECMWF.mtv(:,:,I).^2)); hold on
h = quiver(ECMWF.mtLON(1:skp:end,1:skp:end), ECMWF.mtLAT(1:skp:end,1:skp:end),ECMWF.mtu(1:skp:end,1:skp:end,I),ECMWF.mtv(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
% caxis([clw_w chi_w])
title(colb,'m/s')
axis([minlo maxlo minla maxla]) % axis criterian
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
title('WSV');
set(gca, 'FontSize', ftz)




%%
%%%%%%%%%%%%%%%%

clw=-0.5;
chi=1.5;

clw_p=980;
chi_p=1020;

clw_w=0;
chi_w=30;

skp=3;
ftz=26;
fw=1;
fh=1;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

minlo=-81.8;
maxlo=-77.2;
minla=27.5;
maxla=33.5;


clf
%CMEMS

% for i = 1: 100
% h=figure('units','normalized','position',[0 0 fw fh]);
% set(h, 'Visible', 'off');
% 
% tg_time=tg_time+datenum(hours(6));

% tg_time=datenum('2016-10-07 24:00:00');
tg_time=datenum('2016-10-08 18:00:00');

I=find(CMEMS.mttime==datenum(tg_time));

h1=subplot(1,3,1);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,I)-CMEMS.mtssh_lp(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m')
% axis([-82 -73 24 36]) % axis criterian
axis([minlo maxlo minla maxla]) % axis criterian

graph_handle= gca;
% yticks(27:3:33)
% ytickformat('%.f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
% xticks(-81:1:-77)
% xtickformat('%.f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
title('HPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h2=subplot(1,3,2);
pcolorjw(CMEMS.LON, CMEMS.LAT, sqrt(CMEMS.mtu(:,:,I).^2 + CMEMS.mtv(:,:,I).^2)); hold on
h = quiver(CMEMS.LON(1:skp:end,1:skp:end), CMEMS.LAT(1:skp:end,1:skp:end),CMEMS.mtu(1:skp:end,1:skp:end,I),CMEMS.mtv(1:skp:end,1:skp:end,I),5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m/s')
% axis([-82 -73 24 36]) % axis criterian
axis([minlo maxlo minla maxla]) % axis criterian
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
title('Current');
set(gca, 'FontSize', ftz)
% caxis([clw chi])

I=find(ECMWF.mttime==datenum(tg_time));
h5=subplot(1,3,3);
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, sqrt(ECMWF.mtu_hp(:,:,I).^2 + ECMWF.mtv_hp(:,:,I).^2)); hold on
h = quiver(ECMWF.mtLON(1:skp:end,1:skp:end), ECMWF.mtLAT(1:skp:end,1:skp:end),ECMWF.mtu_hp(1:skp:end,1:skp:end,I),ECMWF.mtv_hp(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
% caxis([clw_w chi_w])
title(colb,'m/s')
axis([minlo maxlo minla maxla]) % axis criterian
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
title('HPF WSV');
set(gca, 'FontSize', ftz)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_filter2_.png',i));


tg_time=tg_time+datenum(hours(6));


end


%%

clw=-0.5;
chi=1.5;

clw_p=980;
chi_p=1020;

clw_w=0;
chi_w=30;

skp=3;
ftz=26;

%%%%%%%%%%%%%%%%

fw=1;
fh=1;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

minlo=-81.8;
maxlo=-77.2;
minla=27.5;
maxla=33.5;

tg_time='2016-10-07 18:00:00';

clf
%CMEMS
I=find(CMEMS.mttime==datenum(tg_time));

h1=subplot(1,3,1);
pcolorjw(CMEMS.LON, CMEMS.LAT, CMEMS.mtssh(:,:,I)-CMEMS.mtssh_lp(:,:,I)); hold on
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m')
% axis([-82 -73 24 36]) % axis criterian
axis([minlo maxlo minla maxla]) % axis criterian

graph_handle= gca;
yticks(27:3:33)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
xticks(-81:1:-77)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('HPF SSH');
set(gca, 'FontSize', ftz)
caxis([clw chi])

h2=subplot(1,3,2);
pcolorjw(CMEMS.LON, CMEMS.LAT, sqrt(CMEMS.mtu(:,:,I).^2 + CMEMS.mtv(:,:,I).^2)); hold on
h = quiver(CMEMS.LON(1:skp:end,1:skp:end), CMEMS.LAT(1:skp:end,1:skp:end),CMEMS.mtu(1:skp:end,1:skp:end,I),CMEMS.mtv(1:skp:end,1:skp:end,I),5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
title(colb,'m')
% axis([-82 -73 24 36]) % axis criterian
axis([minlo maxlo minla maxla]) % axis criterian
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
title('HPF SSH');
set(gca, 'FontSize', ftz)
% caxis([clw chi])

clf

I=find(CMEMS.mttime==datenum(tg_time));
h5=subplot(1,3,1);
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, sqrt(ECMWF.mtu_lp(:,:,I).^2 + ECMWF.mtv_lp(:,:,I).^2)); hold on
h = quiver(ECMWF.mtLON(1:skp:end,1:skp:end), ECMWF.mtLAT(1:skp:end,1:skp:end),ECMWF.mtu_lp(1:skp:end,1:skp:end,I),ECMWF.mtv_lp(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
% caxis([clw_w chi_w])
title(colb,'m/s')
axis([minlo maxlo minla maxla]) % axis criterian
set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
title('WSV');
set(gca, 'FontSize', ftz)

I=find(CMEMS.mttime==datenum(tg_time));
h5=subplot(1,3,2);
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, sqrt(ECMWF.mtu(:,:,I).^2 + ECMWF.mtv(:,:,I).^2)); hold on
h = quiver(ECMWF.mtLON(1:skp:end,1:skp:end), ECMWF.mtLAT(1:skp:end,1:skp:end),ECMWF.mtu(1:skp:end,1:skp:end,I),ECMWF.mtv(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
% caxis([clw_w chi_w])
title(colb,'m/s')
axis([minlo maxlo minla maxla]) % axis criterian
set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
title('WSV');
set(gca, 'FontSize', ftz)

I=find(CMEMS.mttime==datenum(tg_time));
h5=subplot(1,3,3);
pcolorjw(ECMWF.mtLON, ECMWF.mtLAT, sqrt(ECMWF.mtu_hp(:,:,I).^2 + ECMWF.mtv_hp(:,:,I).^2)); hold on
h = quiver(ECMWF.mtLON(1:skp:end,1:skp:end), ECMWF.mtLAT(1:skp:end,1:skp:end),ECMWF.mtu_hp(1:skp:end,1:skp:end,I),ECMWF.mtv_hp(1:skp:end,1:skp:end,I),1.5,'w','LineWidth',2);
% h.Head.LineStyle = 'cback1';    %magic property, magic property value, notice this is not '-'
SAB_coast
colormap(gca,getpmap(7));
colb=colorbar;
% caxis([clw_w chi_w])
title(colb,'m/s')
axis([minlo maxlo minla maxla]) % axis criterian
set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
title('WSV');
set(gca, 'FontSize', ftz)
