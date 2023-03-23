%% Wave parameters
clc
clear


%%%%%%%%%% DORIAN %%%%%%%%%%%
FLF_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/FL_T_WL_DORIAN.csv');
date1=table2array(FLF_I(:,1));
date2=table2array(FLF_I(:,2));
NOAA.FLF_D(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.FLF_D(:,2) = table2array(FLF_I(:,5));
NOAA.FLF_D(:,3) = table2array(FLF_I(:,3));
NOAA.FLF_D(:,4) = NOAA.FLF_D(:,2)-NOAA.FLF_D(:,3);
clear date1 date2 FLF_I

FLM_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/FL_M_WL_DORIAN.csv');
date1=table2array(FLM_I(:,1));
date2=table2array(FLM_I(:,2));
NOAA.FLM_D(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.FLM_D(:,2) = table2array(FLM_I(:,5));
NOAA.FLM_D(:,3) = table2array(FLM_I(:,3));
NOAA.FLM_D(:,4) = NOAA.FLM_D(:,2)-NOAA.FLM_D(:,3);
clear date1 date2 FLM_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.GA_D(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.GA_D(:,2) = table2array(GA_I(:,5));
NOAA.GA_D(:,3) = table2array(GA_I(:,3));
NOAA.GA_D(:,4) = NOAA.GA_D(:,2)-NOAA.GA_D(:,3);
clear date1 date2 GA_I

NC_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/NC_WL_DORIAN.csv');
date1=table2array(NC_I(:,1));
date2=table2array(NC_I(:,2));
NOAA.NC_D(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.NC_D(:,2) = table2array(NC_I(:,5));
NOAA.NC_D(:,3) = table2array(NC_I(:,3));
NOAA.NC_D(:,4) = NOAA.NC_D(:,2)-NOAA.NC_D(:,3);
clear date1 date2 NC_I

SC_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/SC_WL_DORIAN.csv');
date1=table2array(SC_I(:,1));
date2=table2array(SC_I(:,2));
NOAA.SC_D(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.SC_D(:,2) = table2array(SC_I(:,5));
NOAA.SC_D(:,3) = table2array(SC_I(:,3));
NOAA.SC_D(:,4) = NOAA.SC_D(:,2)-NOAA.SC_D(:,3);
clear date1 date2 SC_I



%%%%%%%%%% MATTHEW %%%%%%%%%%%
FLF_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/FL_T_WL_MATTHEW.csv');
date1=table2array(FLF_I(:,1));
date2=table2array(FLF_I(:,2));
NOAA.FLF_M(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.FLF_M(:,2) = table2array(FLF_I(:,5));
NOAA.FLF_M(:,3) = table2array(FLF_I(:,3));
NOAA.FLF_M(:,4) = NOAA.FLF_M(:,2)-NOAA.FLF_M(:,3);
clear date1 date2 FLF_I

FLM_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/FL_M_WL_MATTHEW.csv');
date1=table2array(FLM_I(:,1));
date2=table2array(FLM_I(:,2));
NOAA.FLM_M(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.FLM_M(:,2) = table2array(FLM_I(:,5));
NOAA.FLM_M(:,3) = table2array(FLM_I(:,3));
NOAA.FLM_M(:,4) = NOAA.FLM_M(:,2)-NOAA.FLM_M(:,3);
clear date1 date2 FLM_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.GA_M(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.GA_M(:,2) = table2array(GA_I(:,5));
NOAA.GA_M(:,3) = table2array(GA_I(:,3));
NOAA.GA_M(:,4) = NOAA.GA_M(:,2)-NOAA.GA_M(:,3);
clear date1 date2 GA_I

NC_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/NC_WL_MATTHEW.csv');
date1=table2array(NC_I(:,1));
date2=table2array(NC_I(:,2));
NOAA.NC_M(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.NC_M(:,2) = table2array(NC_I(:,5));
NOAA.NC_M(:,3) = table2array(NC_I(:,3));
NOAA.NC_M(:,4) = NOAA.NC_M(:,2)-NOAA.NC_M(:,3);
clear date1 date2 NC_I

SC_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/SC_WL_MATTHEW.csv');
date1=table2array(SC_I(:,1));
date2=table2array(SC_I(:,2));
NOAA.SC_M(:,1)=datenum(strcat(date1,{' '},date2));
NOAA.SC_M(:,2) = table2array(SC_I(:,5));
NOAA.SC_M(:,3) = table2array(SC_I(:,3));
NOAA.SC_M(:,4) = NOAA.SC_M(:,2)-NOAA.SC_M(:,3);
clear date1 date2 SC_I


%% Plotting-Matthew


h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');
clf

startDatem = datenum('10-05-2016');
endDatem = datenum('10-11-2016');

startDated = datenum('09-02-2019');
endDated = datenum('09-08-2019');
fts=26;
%%%%%%%%%%%% Matthew %%%%%%%%%%%

%%%%%%%%%%%% NC to GA %%%%%%%%%%%

h1=subplot(5,2,1);
plot(NOAA.NC_M(:,1),NOAA.NC_M(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.NC_M(:,1),NOAA.NC_M(:,3),'r', 'LineWidth', 2);
plot(NOAA.NC_M(:,1),NOAA.NC_M(:,4),'g', 'LineWidth', 2);
set(gca,'XLim',[startDatem endDatem],'XTick',[startDatem:(endDatem-startDatem)/11:endDatem])
set(gca,'YLim',[-1.6 1.5],'YTick',[-1.5 0 1.5])
datetick('x','mmm-dd','keeplimits')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
% title('Wilmington, NC')
title('NC')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',fts)
ytickformat('%.1f')

h2=subplot(5,2,2);
plot(NOAA.NC_D(:,1),NOAA.NC_D(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.NC_D(:,1),NOAA.NC_D(:,3),'r', 'LineWidth', 2);
plot(NOAA.NC_D(:,1),NOAA.NC_D(:,4),'g', 'LineWidth', 2);
set(gca,'XLim',[startDated endDated],'XTick',[startDated:(endDated-startDated)/11:endDated])
set(gca,'YLim',[-1.6 1.5],'YTick',[-1.5 0 1.5])
datetick('x','mmm-dd','keeplimits')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('NC')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',fts)
ytickformat('%.1f')

h3=subplot(5,2,3);
plot(NOAA.SC_M(:,1),NOAA.SC_M(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.SC_M(:,1),NOAA.SC_M(:,3),'r', 'LineWidth', 2);
plot(NOAA.SC_M(:,1),NOAA.SC_M(:,4),'g', 'LineWidth', 2);
set(gca,'XLim',[startDatem endDatem],'XTick',[startDatem:(endDatem-startDatem)/11:endDatem])
set(gca,'YLim',[-2 2],'YTick',[-2 0 2])
datetick('x','mmm-dd','keeplimits')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('SC')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',fts)
ytickformat('%.1f')

h4=subplot(5,2,4);
plot(NOAA.SC_D(:,1),NOAA.SC_D(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.SC_D(:,1),NOAA.SC_D(:,3),'r', 'LineWidth', 2);
plot(NOAA.SC_D(:,1),NOAA.SC_D(:,4),'g', 'LineWidth', 2);
set(gca,'XLim',[startDated endDated],'XTick',[startDated:(endDated-startDated)/11:endDated])
set(gca,'YLim',[-2 2],'YTick',[-2 0 2])
datetick('x','mmm-dd','keeplimits')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('SC')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',fts)
ytickformat('%.1f')

h5=subplot(5,2,5);
plot(NOAA.GA_M(:,1),NOAA.GA_M(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.GA_M(:,1),NOAA.GA_M(:,3),'r', 'LineWidth', 2);
plot(NOAA.GA_M(:,1),NOAA.GA_M(:,4),'g', 'LineWidth', 2);
set(gca,'XLim',[startDatem endDatem],'XTick',[startDatem:(endDatem-startDatem)/11:endDatem])
set(gca,'YLim',[-2.5 2.5],'YTick',[-2.5 0 2.5])
datetick('x','mmmdd','keeplimits')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('GA')
ylabel('m')
set(gca,'FontSize',fts)
set(gca,'XTickLabel',[]);
ytickformat('%.1f')

h6=subplot(5,2,6);
plot(NOAA.GA_D(:,1),NOAA.GA_D(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.GA_D(:,1),NOAA.GA_D(:,3),'r', 'LineWidth', 2);
plot(NOAA.GA_D(:,1),NOAA.GA_D(:,4),'g', 'LineWidth', 2);
set(gca,'XLim',[startDated endDated],'XTick',[startDated:(endDated-startDated)/11:endDated])
set(gca,'YLim',[-2.5 2.5],'YTick',[-2.5 0 2.5])
datetick('x','mmmdd','keeplimits')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('GA')
ylabel('m')
set(gca,'FontSize',fts)
set(gca,'XTickLabel',[]);
ytickformat('%.1f')

h7=subplot(5,2,7);
plot(NOAA.FLM_M(:,1),NOAA.FLM_M(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.FLM_M(:,1),NOAA.FLM_M(:,3),'r', 'LineWidth', 2);
plot(NOAA.FLM_M(:,1),NOAA.FLM_M(:,4),'g', 'LineWidth', 2);
set(gca,'XLim',[startDatem endDatem],'XTick',[startDatem:(endDatem-startDatem)/11:endDatem])
set(gca,'YLim',[-1.5 1.5],'YTick',[-1.5 0 1.5])
datetick('x','mmmdd','keeplimits')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('FL1')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',fts)
ytickformat('%.1f')

h8=subplot(5,2,8);
plot(NOAA.FLM_D(:,1),NOAA.FLM_D(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.FLM_D(:,1),NOAA.FLM_D(:,3),'r', 'LineWidth', 2);
plot(NOAA.FLM_D(:,1),NOAA.FLM_D(:,4),'g', 'LineWidth', 2);
set(gca,'XLim',[startDated endDated],'XTick',[startDated:(endDated-startDated)/11:endDated])
set(gca,'YLim',[-1.5 1.5],'YTick',[-1.5 0 1.5])
datetick('x','mmmdd','keeplimits')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('FL1')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',fts)
ytickformat('%.1f')

h9=subplot(5,2,9);
plot(NOAA.FLF_M(:,1),NOAA.FLF_M(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.FLF_M(:,1),NOAA.FLF_M(:,3),'r', 'LineWidth', 2);
plot(NOAA.FLF_M(:,1),NOAA.FLF_M(:,4),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide')
set(gca,'XLim',[startDatem endDatem],'XTick',[startDatem:(endDatem-startDatem)/11:endDatem])
set(gca,'YLim',[-1.5 1.5],'YTick',[-1.5 0 1.5])
datetick('x','mmm-dd','keeplimits')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('FL2')
ylabel('m')
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',fts)
xlabel('Date (2016)')
% xtickangle(-30)
set(gcf,'color','w')
ytickformat('%.1f')

h10=subplot(5,2,10);
plot(NOAA.FLF_D(:,1),NOAA.FLF_D(:,2),'b', 'LineWidth', 2);hold on
plot(NOAA.FLF_D(:,1),NOAA.FLF_D(:,3),'r', 'LineWidth', 2);
plot(NOAA.FLF_D(:,1),NOAA.FLF_D(:,4),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide')
set(gca,'XLim',[startDated endDated],'XTick',[startDated:(endDated-startDated)/11:endDated])
set(gca,'YLim',[-1.5 1.5],'YTick',[-1.5 0 1.5])
datetick('x','mmm-dd','keeplimits')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('FL2')
ylabel('m')
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',fts)
xlabel('Date (2019)')
% xtickangle(-30)
set(gcf,'color','w')
ytickformat('%.1f')



h1_pos = get(h1,'Position');
h2_pos = get(h2,'Position');
h3_pos = get(h3,'Position');
h4_pos = get(h4,'Position');
h5_pos = get(h5,'Position');

sp_width= 0.415;
sp_height= 0.135;

y_gap=0.05;
x_gap=0.1;

x1=0.0430;
x2=x1+sp_width+x_gap;

y1 = 0.82;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;
y4 = y3-sp_height-y_gap;
y5 = y4-sp_height-y_gap;

set(h1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x1 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x1 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h7,'Position',[x1 y4 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h9,'Position',[x1 y5 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h2,'Position',[x2 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x2 y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x2 y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x2 y4 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h10,'Position',[x2 y5 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_2.png'));



%%
% Bar chart
d = categorical({'Mayport, FL','Fort Pulaski, GA','Cooper River Entrance, SC',...
    'Duke Marine Lab, NC','Ocean City Inlet, MD','Atlantic City, NJ'});
d = reordercats(d,{'Mayport, FL','Fort Pulaski, GA','Cooper River Entrance, SC',...
    'Duke Marine Lab, NC','Ocean City Inlet, MD','Atlantic City, NJ'});
barh(d,CHANGE,'r');
xlabel('Change in Water Level (m)')
set(gca,'FontSize',25)
set(gcf,'color','w')
