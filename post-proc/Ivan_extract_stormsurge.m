%% Observations

%%%%%%%%%%% Load data
load NOAA_1yr.mat

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

startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

fti=1/(18*60*60); %cut-off period
fs=1/(6*60); %data frequency in second

plot(NOAA.mttotal(:,1),lowpass(NOAA.mttotal(:,2)-NOAA.mttide(:,2),fti,fs,'Steepness',0.9999),'o','Color','r','MarkerFaceColor','r');hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 2.5],'YTick',[-1 0 1 2 3]);
datetick('x','mmm-dd','keepticks')
title('NOAA 8670870','FontSize',ftszt)

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', ftsz)
