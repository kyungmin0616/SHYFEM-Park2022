%% Wave parameters
clc
clear


%%%%%%%%%% MATTHEW %%%%%%%%%%%
FLF_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/FL_T_WL_MATTHEW.csv');
date1=table2array(FLF_I(:,1));
date2=table2array(FLF_I(:,2));
FLF_M(:,1)=datenum(strcat(date1,{' '},date2));
FLF_M(:,2) = table2array(FLF_I(:,5));
FLF_M(:,3) = table2array(FLF_I(:,3));
FLF_M(:,4) = FLF_M(:,2)-FLF_M(:,3);
clear date1 date2 FLF_I

FLM_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/FL_M_WL_MATTHEW.csv');
date1=table2array(FLM_I(:,1));
date2=table2array(FLM_I(:,2));
FLM_M(:,1)=datenum(strcat(date1,{' '},date2));
FLM_M(:,2) = table2array(FLM_I(:,5));
FLM_M(:,3) = table2array(FLM_I(:,3));
FLM_M(:,4) = FLM_M(:,2)-FLM_M(:,3);
clear date1 date2 FLM_I

% FLV_I=readtable('FL_V_WL_MATTHEW.csv');
% date1=table2array(FLV_I(:,1));
% date2=table2array(FLV_I(:,2));
% FLV_M(:,1)=datenum(strcat(date1,{' '},date2));
% FLV_M(:,2) = str2double(table2array(FLV_I(:,5)));
% FLV_M(:,3) = str2double(table2array(FLV_I(:,3)));
% FLV_M(:,4) = FLV_M(:,2)-FLV_M(:,3);
% clear date1 date2 FLV_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = table2array(GA_I(:,5));
GA_M(:,3) = table2array(GA_I(:,3));
GA_M(:,4) = GA_M(:,2)-GA_M(:,3);
clear date1 date2 GA_I

NC_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/NC_WL_MATTHEW.csv');
date1=table2array(NC_I(:,1));
date2=table2array(NC_I(:,2));
NC_M(:,1)=datenum(strcat(date1,{' '},date2));
NC_M(:,2) = table2array(NC_I(:,5));
NC_M(:,3) = table2array(NC_I(:,3));
NC_M(:,4) = NC_M(:,2)-NC_M(:,3);
clear date1 date2 NC_I

SC_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/SC_WL_MATTHEW.csv');
date1=table2array(SC_I(:,1));
date2=table2array(SC_I(:,2));
SC_M(:,1)=datenum(strcat(date1,{' '},date2));
SC_M(:,2) = table2array(SC_I(:,5));
SC_M(:,3) = table2array(SC_I(:,3));
SC_M(:,4) = SC_M(:,2)-SC_M(:,3);
clear date1 date2 SC_I

WL_MATTHEW(:,1)=FLF_M(:,1);
% WL_MATTHEW(:,2)=FLF_M(:,4)+FLM_M(:,4)+FLV_M(:,4)+GA_M(:,4)+NC_M(:,4)+SC_M(:,4);
WL_MATTHEW(:,2)=FLF_M(:,4)+FLM_M(:,4)+GA_M(:,4)+NC_M(:,4)+SC_M(:,4);
WL_MATTHEW(:,3)=WL_MATTHEW(:,2)./5;


%% Plotting-Matthew


startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

%%%%%%%%%%%% NC to GA %%%%%%%%%%%

h=figure('units','normalized','position',[0 0 0.5 1]);

% figure(1)
set(h, 'Visible', 'on');

clf
h1=subplot(5,1,1);
plot(NC_M(:,1),NC_M(:,2),'b', 'LineWidth', 2);hold on
plot(NC_M(:,1),NC_M(:,3),'r', 'LineWidth', 2);
plot(NC_M(:,1),NC_M(:,2)-NC_M(:,3),'g', 'LineWidth', 2);
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-1.5 1.5],'YTick',[-1.5 0 1.5])
datetick('x','mmm-dd','keeplimits')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Wilmington, NC')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',20)
ytickformat('%.1f')

h2=subplot(5,1,2);
plot(SC_M(:,1),SC_M(:,2),'b', 'LineWidth', 2);hold on
plot(SC_M(:,1),SC_M(:,3),'r', 'LineWidth', 2);
plot(SC_M(:,1),SC_M(:,2)-SC_M(:,3),'g', 'LineWidth', 2);
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-2 2],'YTick',[-2 0 2])
datetick('x','mmm-dd','keeplimits')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Charleston, SC')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',20)
ytickformat('%.1f')


h3=subplot(5,1,3);
plot(GA_M(:,1),GA_M(:,2),'b', 'LineWidth', 2);hold on
plot(GA_M(:,1),GA_M(:,3),'r', 'LineWidth', 2);
plot(GA_M(:,1),GA_M(:,2)-GA_M(:,3),'g', 'LineWidth', 2);
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-2.5 2.5],'YTick',[-2.5 0 2.5])
datetick('x','mmmdd','keeplimits')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Fort Pulaski, GA')
ylabel('m')
set(gca,'FontSize',20)
set(gca,'XTickLabel',[]);
ytickformat('%.1f')

h4=subplot(5,1,4);
plot(FLM_M(:,1),FLM_M(:,2),'b', 'LineWidth', 2);hold on
plot(FLM_M(:,1),FLM_M(:,3),'r', 'LineWidth', 2);
plot(FLM_M(:,1),FLM_M(:,2)-FLM_M(:,3),'g', 'LineWidth', 2);
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-1.5 1.5],'YTick',[-1.5 0 1.5])
datetick('x','mmmdd','keeplimits')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Mayport, FL')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',20)
ytickformat('%.1f')

h5=subplot(5,1,5);
plot(FLF_M(:,1),FLF_M(:,2),'b', 'LineWidth', 2);hold on
plot(FLF_M(:,1),FLF_M(:,3),'r', 'LineWidth', 2);
plot(FLF_M(:,1),FLF_M(:,2)-FLF_M(:,3),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-1.5 1.5],'YTick',[-1.5 0 1.5])
datetick('x','mmm-dd','keeplimits')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Trident Pier, FL')
ylabel('m')
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',20)
xlabel('Date (2016)')
% xtickangle(-30)
set(gcf,'color','w')
ytickformat('%.1f')


h1_pos = get(h1,'Position');
h2_pos = get(h2,'Position');
h3_pos = get(h3,'Position');
h4_pos = get(h4,'Position');
h5_pos = get(h5,'Position');

sp_width= 0.895;
sp_height= 0.14;
y_gap=0.05;

x_os=-0.06;

y1 = 0.83;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;
y4 = y3-sp_height-y_gap;
y5 = y4-sp_height-y_gap;

set(h1,'Position',[h1_pos(1)+x_os y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[h1_pos(1)+x_os y2 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[h1_pos(1)+x_os y3 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[h1_pos(1)+x_os y4 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[h1_pos(1)+x_os y5 sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_2_a.png'));



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
