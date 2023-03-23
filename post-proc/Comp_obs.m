clear
clc
% figure(1)
% clf

load FC

%%%%%%%%%% NOAA %%%%%%%%%%%

%%%%%%%%%%%%%% Matthew
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/NAVD/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));

NOAA.mttime=datenum(strcat(date1,{' '},date2));
NOAA.mttotal = table2array(GA_I(:,5))+0.0710-0.0710;
NOAA.mttide = table2array(GA_I(:,3))+0.0710-0.0710;

clear GA_I
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/METEO/GA_MATTHEW.csv');
NOAA.mtws=table2array(GA_I(:,2));
NOAA.mtwd=table2array(GA_I(:,3));
NOAA.mtap=table2array(GA_I(:,6));

%%%%%%%%%%%%%% Dorian
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.drtime=datenum(strcat(date1,{' '},date2));
NOAA.drtotal = table2array(GA_I(:,5))+1.1230-0.0710;
NOAA.drtide = table2array(GA_I(:,3))+1.1230-0.0710;

clear GA_I
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/METEO/GA_DORIAN.csv');
NOAA.drws=table2array(GA_I(:,2));
NOAA.drwd=table2array(GA_I(:,3));
NOAA.drap=table2array(GA_I(:,6));



temp.ws = squeeze(NOAA.mtws);
temp.ws(isnan(temp.ws))=0;

temp.wd = squeeze(NOAA.mtwd);
temp.wd(isnan(temp.wd))=0;


%% PLOT

%%%%%%%%%%%%%%%%%%%%%%%% Matthew
ft=27;
fw=0.5;
fh=1;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

clf
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

h1=subplot(4,1,1);
plot(NOAA.mttime,NOAA.mttotal-NOAA.mttide,'k','LineWidth',3)

set(gca,'YLim',[-0.8 2.5],'YTick',[-0.5:1:2.5])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
title('Nontidal residual')
ylabel('m')
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', ft)
set(gca,'XTickLabel',[]);
grid on

h2=subplot(4,1,2);

atp=3;
ra=10;

[xWind, yWind] = pol2cart(deg2rad(-NOAA.mtwd(1:atp:end,1)-90), NOAA.mtws(1:atp:end,1)); 

IN=find(NOAA.mttime(:,1)==datenum('10-10-2016 2:00:00'));
NT = [NOAA.mttime(1:atp:end,1); NOAA.mttime(IN,1)];
NU = [xWind; ra]; 
NY = [yWind; 0]; 
NZ = zeros(size(NU));
NZ(end,1) = 0.2;

q1=quiver(NT, NZ, NU, NY,1,'-k','LineWidth',3);hold on
q1.ShowArrowHead='off';

ylim([-0.6 0.3])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
title('Wind')
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', ft)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'YGrid', 'off', 'XGrid', 'on')

h3=subplot(4,1,3);
plot(NOAA.mttime,NOAA.mtap,'k','LineWidth',3)

ylim([970 1040])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
title('Atmospheric pressure')
ylabel('mb')
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', ft)
set(gca,'XTickLabel',[]);
grid on

h4=subplot(4,1,4);
plot(FC(:,1),FC(:,2),'k','LineWidth',3)

ylim([15 35])
set(gca,'YLim',[15 35],'YTick',[15:10:35])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
title('Florida Current')
xlabel('Date (2016)')
ylabel('Sv')
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', ft)
grid on
set(gcf,'color','w');


sp_width= 0.43/fw;
sp_height= 0.18/fh;
y_gap=0.05;

x1=0.101;
y1 = 0.78;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;
y4 = y3-sp_height-y_gap;
y5 = y4-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x1 y4 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_3_a.png',1));

%%%%%%%%%%%%%%%%%%%%%%%% Matthew

fw=0.5;
fh=1;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

clf
startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

h1=subplot(4,1,1);
plot(NOAA.drtime,NOAA.drtotal-NOAA.drtide,'k','LineWidth',3)

set(gca,'YLim',[-0.8 2.5],'YTick',[-0.5:1:2.5])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
title('Nontidal residual')
ylabel('m')
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', ft)
set(gca,'XTickLabel',[]);
grid on

h2=subplot(4,1,2);

atp=3;
ra=10;

[xWind, yWind] = pol2cart(deg2rad(-NOAA.drwd(1:atp:end,1)-90), NOAA.drws(1:atp:end,1)); 

IN=find(NOAA.drtime(:,1)==datenum('09-07-2019 2:00:00'));
NT = [NOAA.drtime(1:atp:end,1); NOAA.drtime(IN,1)];
NU = [xWind; ra]; 
NY = [yWind; 0]; 
NZ = zeros(size(NU));
NZ(end,1) = 0.2;

q1=quiver(NT, NZ, NU, NY,0.72,'-k','LineWidth',3);hold on
q1.ShowArrowHead='off';

ylim([-0.6 0.3])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
title('Wind')
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', ft)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(gca, 'YGrid', 'off', 'XGrid', 'on')

h3=subplot(4,1,3);
plot(NOAA.drtime,NOAA.drap,'k','LineWidth',3)

ylim([970 1040])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
title('Atmospheric pressure')
ylabel('mb')
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gca,'fontsize', ft)
set(gca,'XTickLabel',[]);
grid on

h4=subplot(4,1,4);
plot(FC(:,1),FC(:,2),'k','LineWidth',3)

ylim([15 35])
set(gca,'YLim',[15 35],'YTick',[15:10:35])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
title('Florida Current')
xlabel('Date (2019)')
ylabel('Sv')
set(gca,'fontsize', ft)
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
set(gcf,'color','w');


sp_width= 0.43/fw;
sp_height= 0.18/fh;
y_gap=0.05;

x1=0.101;
y1 = 0.78;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;
y4 = y3-sp_height-y_gap;
y5 = y4-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x1 y4 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_3_b.png',1));


%% Dorian



figure(2)
atp=5;
[xWind, yWind] = pol2cart(deg2rad(-NOAA.drwd(1:atp:end,1)-90), NOAA.drws(1:atp:end,1)); 
 
clf
q=quiver(NOAA.drtime(1:atp:end,1), zeros(size(xWind)), xWind, yWind,1,'-k','LineWidth',3);hold on
% q=quiver(NOAA.mttime(1:atp:end,1), NOAA.mtws(1:atp:end,1), XW, YW,1);hold on


q.ShowArrowHead='off';
% q.Marker='h';
% q.AutoScale='off';
% plot(NOAA.mttime(1:atp:end,1),zeros(size(xWind)))

ylim([-1 1])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
set(gcf,'color','w');
set(gca,'fontsize', 26)
set(gca,'linewidth', 1) 
set(gca,'fontsize', 26)
set(gca,'linewidth', 1) 



%MATTHEW
lp_dr_day=5;
% lp_dr_day=18;

test=lowpass(temp,1/lp_dr_day);
% NOAA.drtotal_lp=lowpass(NOAA.drresi,1/(lp_dr_day*10));

% fh=figure('units','normalized','position',[0 0.3 1 .5]);
    NOAA.mttime,test,2,...

% figure(5)
% clf
% subplot(2,1,1)
clf
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
linecolors={'r' [0 .5 0] 'b' 'g' 'k'};

h3i=plotNy(NOAA.mttime,NOAA.mttotal-NOAA.mttide,1,...
    NOAA.mttime,test,2,...
    NOAA.mttime(1:1:end,1),NOAA.mtws(1:1:end,1),3,...
    NOAA.mttime,NOAA.mtap,4,...
    FC(:,1),FC(:,2),5,...
    'Linewidth',2,...
    'YAxisLabels',{'[m]' '[m/s]' '[deg]' '[mb]' '[Sv]'},...
    'LineColor',linecolors,...
    'FontSize',22,...
    'Ylim',[-0.8 2.5; 0 30; 0 30; 980 1030; 15 35],...
    'Fontname','Helvetica Neue',...
    'Parent',fh,... 
    'Grid','on',...
    'LegendString',{'Water level anomailes' 'Wind Speed' 'Wind direction' 'Atmospheric Pressure' 'Florida current'});
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
% xtickangle(45)
set(gcf,'color','w');


%Change the axis colors to match the requested line colors
for i=1:length(h3i.ax)
	set(h3i.ax(i),'ycolor',linecolors{i});	
end



%%

%     'Ylim',[-0.8 2.5; 0 30; 0 360; 980 1030; 15 35],...

%MATTHEW
lp_dr_day=5;
% lp_dr_day=18;

test=lowpass(temp,1/lp_dr_day);
% NOAA.drtotal_lp=lowpass(NOAA.drresi,1/(lp_dr_day*10));

% fh=figure('units','normalized','position',[0 0.3 1 .5]);
    NOAA.mttime,test,2,...

% figure(5)
% clf
% subplot(2,1,1)
clf
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
linecolors={'r' [0 .5 0] 'b' 'g' 'k'};

h3i=plotNy(NOAA.mttime,NOAA.mttotal-NOAA.mttide,1,...
    NOAA.mttime,test,2,...
    NOAA.mttime(1:1:end,1),NOAA.mtws(1:1:end,1),3,...
    NOAA.mttime,NOAA.mtap,4,...
    FC(:,1),FC(:,2),5,...
    'Linewidth',2,...
    'YAxisLabels',{'[m]' '[m/s]' '[deg]' '[mb]' '[Sv]'},...
    'LineColor',linecolors,...
    'FontSize',22,...
    'Ylim',[-0.8 2.5; 0 30; 0 30; 980 1030; 15 35],...
    'Fontname','Helvetica Neue',...
    'Parent',fh,... 
    'Grid','on',...
    'LegendString',{'Water level anomailes' 'Wind Speed' 'Wind direction' 'Atmospheric Pressure' 'Florida current'});
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
% xtickangle(45)
set(gcf,'color','w');


%Change the axis colors to match the requested line colors
for i=1:length(h3i.ax)
	set(h3i.ax(i),'ycolor',linecolors{i});	
end

saveas(fh,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Comp_GA_M.png'));




% DORIAN
fh=figure('units','normalized','position',[0 0.3 1 .5]);

% figure(2)
% clf

startDate = datenum('09-01-2019');
endDate = datenum('09-09-2019');
linecolors={'r' [0 .5 0] 'b' 'k'};
h3i=plotNy(WL_GA_D(:,1),WL_GA_D(:,4),1,...
    PREC_GA_D(:,1),PREC_GA_D(:,2),2,...
    RD_GA_D(:,1),RD_GA_D(:,2),3,...
    FC(:,1),FC(:,2),4,...
    'Linewidth',2,...
    'YAxisLabels',{'[m]' '[mm/day]' '[m^3/s]','[SV]'},...
    'LineColor',linecolors,...
    'FontSize',22,...
    'Ylim',[-0.8 2.5; -20 150; 60 170; 15 35],...
    'Fontname','TimesNewRoman',...
    'Parent',fh,... 
    'Grid','on',...
    'LegendString',{'Water level anomailes' 'Precipitation' 'River discharge' 'Florida current'});
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
% xtickangle(45)
set(gcf,'color','w');


%Change the axis colors to match the requested line colors
for i=1:length(h3i.ax)
	set(h3i.ax(i),'ycolor',linecolors{i});	
end


saveas(fh,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Comp_GA_D.png'));



%% COMP MET

startDate = datenum('10-04-2016');
endDate = datenum('10-12-2016');


%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%% Matthew %%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% 
%     GA_M(:,1),-(GA_M(:,4)-1013)./(1025*9.8)*100,2,...

fh=figure('units','normalized','position',[0 0 1 .485]);
linecolors={'k' [0 .5 0] 'r'  'b'};
set(fh, 'Visible', 'off');

h1=plotNy(WL_GA_M(:,1),WL_GA_M(:,4),1,...
    GA_M(:,1),GA_M(:,4),2,...
    GA_M(:,1),GA_M(:,2),3,...
    FC(:,1),FC(:,2),4,...
    'Linewidth',2,...
    'YAxisLabels',{'[m]' '[hPa]' '[m/s]' 'SV'},...
    'XAxisLabel', 'Date (2016)',...
    'TitleStr', 'Hurricane Matthew',...
    'LineColor',linecolors,...
    'Ylim',[-0.8 2.5; 975 1030; 0 30; 15 35],...
    'FontSize',28,...
    'Fontname','Helvetica neue',...
    'Parent',fh,... 
    'RightMarginW', 45,...
    'LeftMarginW', 40,...
    'LowerMarginW', 75,...
    'AxisWidth',60,...
    'LegendString',{'Water level anomailes' 'Atmospheric pressure' 'Wind speed' 'Florida Current'});

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmm-dd','keeplimits')
grid on
box on
legend off
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;

%Change the axis colors to match the requested line colors
for i=1:length(h1.ax)
	set(h1.ax(i),'ycolor',linecolors{i});	
end


saveas(fh,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_4_a2.png'));



%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%% Dorian %%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%% 
%     GA_D(:,1),-(GA_D(:,4)-1013)./(1025*9.8)*100,2,...

startDate = datenum('09-01-2019');
endDate = datenum('09-09-2019');

fh=figure('units','normalized','position',[0 0 1 .485]);
linecolors={'k' [0 .5 0] 'r'  'b'};
set(fh, 'Visible', 'off');

h1=plotNy(WL_GA_D(:,1),WL_GA_D(:,4),1,...
    GA_D(:,1),GA_D(:,4),2,...
    GA_D(:,1),GA_D(:,2),3,...
    FC(:,1),FC(:,2),4,...
    'Linewidth',2,...
    'YAxisLabels',{'[m]' '[hPa]' '[m/s]' 'SV'},...
    'XAxisLabel', 'Date (2019)',...
    'TitleStr', 'Hurricane Dorian',...
    'LineColor',linecolors,...
    'Ylim',[-0.8 2.5; 975 1030; 0 30; 15 35],...
    'FontSize',28,...
    'Fontname','Helvetica neue',...
    'Parent',fh,... 
    'RightMarginW', 45,...
    'LeftMarginW', 40,...
    'LowerMarginW', 75,...
    'AxisWidth',60,...
    'LegendString',{'Water level anomailes' 'Inverted barometer' 'Wind speed' 'Florida Current'});

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmm-dd','keeplimits')
grid on
box on
legend off
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;

%Change the axis colors to match the requested line colors
for i=1:length(h1.ax)
	set(h1.ax(i),'ycolor',linecolors{i});	
end


saveas(fh,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_4_b2.png'));



%Dorian
fh=figure('units','normalized','position',[0 0.3 1 .5]);
startDate = datenum('09-01-2019');
endDate = datenum('09-09-2019');
linecolors={'k' [0 .5 0] 'r'  'b'};
h3i=plotNy(WL_GA_D(:,1),WL_GA_D(:,4),1,...
    GA_D(:,1),-(GA_D(:,4)-1013)./(1025*9.8)*100,2,...
    GA_D(:,1),GA_D(:,2),3,...
    FC(:,1),FC(:,2),4,...
    'Linewidth',2,...
    'YAxisLabels',{'[m]' '[m]' '[m/s]' 'SV'},...
    'LineColor',linecolors,...
    'Ylim',[-0.8 2.5; -0.8 2.5; 0 30; 15 35],...
    'FontSize',22,...
    'Fontname','Helvetica',...
    'Parent',fh,... 
    'Grid','on',...
    'LegendString',{'Water level anomailes' 'Inverted barometer' 'Wind speed' 'Florida Current'});
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
datetick('x','mmmdd','keeplimits')
% xtickangle(45)
set(gcf,'color','w');


%Change the axis colors to match the requested line colors
for i=1:length(h3i.ax)
	set(h3i.ax(i),'ycolor',linecolors{i});	
end

saveas(fh,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Comp_MET_GA_D2.png'));

