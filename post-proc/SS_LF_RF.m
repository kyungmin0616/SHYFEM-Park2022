%% Observations

%%%%%%%%%%% SSLS
offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');

clear SLS desc list wl SSLS
SLS = importdata('/Users/kpark350/Ga_tech/Projects/DataSet/SSLS/Py/hurricane_dorian.csv');

desc = string(SLS.textdata(2:end,1));
list = unique(desc);
SLS.textdata(1,:)=[];

for i=1:length(list)

    lon_tmp=SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),2);
    lat_tmp=SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),3);
    
    list(i,2) = string(lon_tmp(1,1));
    list(i,3) = string(lat_tmp(1,1));
    
    SSLS.(['sta',num2str(i)])(:,1)=datenum(string(SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),4)),'yyyy-mm-dd HH:MM:SS')+offdate; %NEW VER
%     SSLS.(['sta',num2str(i)])(:,2)=SLS.data(strcmp(string(SLS.textdata(:,1)),list(i)),1)*0.3048;
%     SSLS.(['sta',num2str(i)])(:,3)=SLS.data(strcmp(string(SLS.textdata(:,1)),list(i)),2)*0.3048;

    clear lon_tmp lat_tmp
    
end


%% Each hurricane Plotting
fw=1;
fh=1;
ftsz=21;
ftszt=16;
xdt=24;
ftd=13;


h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

%%%%%%%%%%%%%%%%%%% Matthew
TP=170;
clf

startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

h1=subplot(5,2,1);

lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));
sshtime2=squeeze(ssh2(index_dist,:));
sshtime3=squeeze(ssh3(index_dist,:));

plot(time1(1:TP),sshtime1(1:TP),'-k','linewidth', 3);hold on
plot(time1(1:TP),sshtime2(1:TP),'-r','linewidth', 3);hold on
plot(time1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
plot(time1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
plot(time1(1:TP,1),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP)),'-m','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 3]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
title('NOAA 8670870','FontSize',ftszt)

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', ftsz)

% USGS 0219897993
h2=subplot(5,2,2);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));
sshtime2=squeeze(ssh2(index_dist,:));
sshtime3=squeeze(ssh3(index_dist,:));

plot(time1(1:TP),sshtime1(1:TP),'-k','linewidth', 3);hold on
plot(time1(1:TP),sshtime2(1:TP),'-r','linewidth', 3);hold on
plot(time1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
plot(time1(1:TP,1),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP)),'-m','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)

% USGS 021989715
clear sshtime1 usgs_time usgs_wl
h3=subplot(5,2,3);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));
sshtime2=squeeze(ssh2(index_dist,:));
sshtime3=squeeze(ssh3(index_dist,:));

plot(time1(1:TP),sshtime1(1:TP),'-k','linewidth', 3);hold on
plot(time1(1:TP),sshtime2(1:TP),'-r','linewidth', 3);hold on
plot(time1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
plot(time1(1:TP,1),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP)),'-m','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',ftszt)
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

% USGS 022035975
clear sshtime1 usgs_time usgs_wl
h4=subplot(5,2,4);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));
sshtime2=squeeze(ssh2(index_dist,:));
sshtime3=squeeze(ssh3(index_dist,:));

plot(time1(1:TP),sshtime1(1:TP),'-k','linewidth', 3);hold on
plot(time1(1:TP),sshtime2(1:TP),'-r','linewidth', 3);hold on
plot(time1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
plot(time1(1:TP,1),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP)),'-m','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1.5 2.5],'YTick',[-1.5 -1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',ftszt)
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Val_MT_storm_surge4.png',1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dorian %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');
clf
h1=subplot(5,2,1);
lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));
sshtime2=squeeze(sshd2(index_dist,:));
sshtime3=squeeze(sshd3(index_dist,:));

plot(timed1(1:TP),sshtime1(1:TP),'-k','linewidth', 3);hold on
plot(timed1(1:TP),sshtime2(1:TP),'-r','linewidth', 3);hold on
plot(timed1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
plot(timed1(1:TP,1),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP)),'-m','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
title('NOAA 8670870','FontSize',ftszt)
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', ftsz)


% USGS 0219897993

h2=subplot(5,2,2);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));
sshtime2=squeeze(sshd2(index_dist,:));
sshtime3=squeeze(sshd3(index_dist,:));

plot(timed1(1:TP),sshtime1(1:TP),'-k','linewidth', 3);hold on
plot(timed1(1:TP),sshtime2(1:TP),'-r','linewidth', 3);hold on
plot(timed1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
plot(timed1(1:TP,1),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP)),'-m','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)


% USGS 021989715
clear sshtime1 usgs_time usgs_wl

h3=subplot(5,2,3);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));
sshtime2=squeeze(sshd2(index_dist,:));
sshtime3=squeeze(sshd3(index_dist,:));

plot(timed1(1:TP),sshtime1(1:TP),'-k','linewidth', 3);hold on
plot(timed1(1:TP),sshtime2(1:TP),'-r','linewidth', 3);hold on
plot(timed1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
plot(timed1(1:TP,1),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP)),'-m','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

% USGS 022035975
clear sshtime1 usgs_time usgs_wl

h4=subplot(5,2,4);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));
sshtime2=squeeze(sshd2(index_dist,:));
sshtime3=squeeze(sshd3(index_dist,:));

plot(timed1(1:TP),sshtime1(1:TP),'-k','linewidth', 3);hold on
plot(timed1(1:TP),sshtime2(1:TP),'-r','linewidth', 3);hold on
plot(timed1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
plot(timed1(1:TP,1),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP)),'-m','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

%%%%%%%%%%%%%%%% SSLS
IDXXX=[1 20 11 18 4 5];
k=5;
for stn=1:length(IDXXX)
    stn=IDXXX(1,stn);
%     stn=11;
    lat_s = str2num(list(stn,2));
    lon_s = str2num(list(stn,3));
%     
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:));
    sshtime2=squeeze(sshd2(index_dist,:));
    sshtime3=squeeze(sshd3(index_dist,:));
    
    subplot(5,2,k)
    plot(timed1(1:TP),sshtime1(1:TP),'-k','linewidth', 3);hold on
    plot(timed1(1:TP),sshtime2(1:TP),'-r','linewidth', 3);hold on
    plot(timed1(1:TP),sshtime3(1:TP),'-b','linewidth', 3);hold on
    plot(timed1(1:TP,1),sshtime1(1,1:TP)-(sshtime2(1,1:TP)+sshtime3(1,1:TP)),'-m','linewidth', 2,'MarkerSize',15); 

    set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
    set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);
    grid on
    ax = gca;
    ax.GridLineStyle = '--';
    ax.GridAlpha = 0.7;
    title(""+list(stn,1)+"",'FontSize',ftszt)
%     set(gca,'XTickLabel',[]);
    set(gca,'FontSize',ftsz)
    set(gcf,'color','w')
    datetick('x','mmm-dd','keepticks')

    if k < 9
        set(gca,'XTickLabel',[]);
    end
    
  
    k=k+1;
    
end

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Val_DR_storm_surge3.png',1));


