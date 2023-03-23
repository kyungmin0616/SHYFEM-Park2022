%% Wave parameters
clc
clear


%%%%%%%%%% MATTHEW %%%%%%%%%%%
FLF_I=readtable('FL_T_WL_DORIAN.csv');
date1=table2array(FLF_I(:,1));
date2=table2array(FLF_I(:,2));
FLF_M(:,1)=datenum(strcat(date1,{' '},date2));
FLF_M(:,2) = str2double(table2array(FLF_I(:,5)));
FLF_M(:,3) = str2double(table2array(FLF_I(:,3)));
FLF_M(:,4) = FLF_M(:,2)-FLF_M(:,3);

clear date1 date2 FLF_I

FLM_I=readtable('FL_M_WL_DORIAN.csv');
date1=table2array(FLM_I(:,1));
date2=table2array(FLM_I(:,2));
FLM_M(:,1)=datenum(strcat(date1,{' '},date2));
FLM_M(:,2) = str2double(table2array(FLM_I(:,5)));
FLM_M(:,3) = str2double(table2array(FLM_I(:,3)));
FLM_M(:,4) = FLM_M(:,2)-FLM_M(:,3);

clear date1 date2 FLM_I

% FLV_I=readtable('FL_V_WL_DORIAN.csv');
% date1=table2array(FLV_I(:,1));
% date2=table2array(FLV_I(:,2));
% FLV_M(:,1)=datenum(strcat(date1,{' '},date2));
% FLV_M(:,2) = str2double(table2array(FLV_I(:,5)));
% FLV_M(:,3) = str2double(table2array(FLV_I(:,3)));
% FLV_M(:,4) = FLV_M(:,2)-FLV_M(:,3);
% 
% clear date1 date2 FLV_I

GA_I=readtable('GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = str2double(table2array(GA_I(:,5)));
GA_M(:,3) = str2double(table2array(GA_I(:,3)));
GA_M(:,4) = GA_M(:,2)-GA_M(:,3);

clear date1 date2 GA_I

NC_I=readtable('NC_WL_DORIAN.csv');
date1=table2array(NC_I(:,1));
date2=table2array(NC_I(:,2));
NC_M(:,1)=datenum(strcat(date1,{' '},date2));
NC_M(:,2) = str2double(table2array(NC_I(:,5)));
NC_M(:,3) = str2double(table2array(NC_I(:,3)));
NC_M(:,4) = NC_M(:,2)-NC_M(:,3);

clear date1 date2 NC_I

SC_I=readtable('SC_WL_DORIAN.csv');
date1=table2array(SC_I(:,1));
date2=table2array(SC_I(:,2));
SC_M(:,1)=datenum(strcat(date1,{' '},date2));
SC_M(:,2) = str2double(table2array(SC_I(:,5)));
SC_M(:,3) = str2double(table2array(SC_I(:,3)));
SC_M(:,4) = SC_M(:,2)-SC_M(:,3);

clear date1 date2 SC_I

WL_DORIAN(:,1)=FLF_M(:,1);
% WL_DORIAN(:,2)=FLF_M(:,4)+FLM_M(:,4)+FLV_M(:,4)+GA_M(:,4)+NC_M(:,4)+SC_M(:,4);
WL_DORIAN(:,2)=FLF_M(:,4)+FLM_M(:,4)+GA_M(:,4)+NC_M(:,4)+SC_M(:,4);
WL_DORIAN(:,3)=WL_DORIAN(:,2)./5;


%% Plotting-Matthew


startDate = datenum('08-20-2019');
endDate = datenum('09-20-2019');

%%%%%%%%%%%% NC to GA %%%%%%%%%%%

h=figure('units','normalized','position',[0.1 0.2 .4 0.8]);

% figure(1)
clf
set(h, 'Visible', 'on');
subplot(5,1,1)
plot(NC_M(:,1),NC_M(:,2),'b', 'LineWidth', 2);hold on
plot(NC_M(:,1),NC_M(:,3),'r', 'LineWidth', 2);
plot(NC_M(:,1),NC_M(:,2)-NC_M(:,3),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide');
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-1.5 1.5],'YTick',[-1.5:1:1.5])
datetick('x','mmmdd','keepticks')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Wilmington, NC')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',15)

subplot(5,1,2)
plot(SC_M(:,1),SC_M(:,2),'b', 'LineWidth', 2);hold on
plot(SC_M(:,1),SC_M(:,3),'r', 'LineWidth', 2);
plot(SC_M(:,1),SC_M(:,2)-SC_M(:,3),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-2 2],'YTick',[-2:1:2])
datetick('x','mmmdd','keepticks')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Charleston, SC')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',15)

subplot(5,1,3)
plot(GA_M(:,1),GA_M(:,2),'b', 'LineWidth', 2);hold on
plot(GA_M(:,1),GA_M(:,3),'r', 'LineWidth', 2);
plot(GA_M(:,1),GA_M(:,2)-GA_M(:,3),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-2.5 2.5],'YTick',[-2.5:1:2.5])
datetick('x','mmmdd','keepticks')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Fort Pulaski, GA')
ylabel('m')
set(gca,'FontSize',15)
% xlabel('Date (2019)')
% xtickangle(-30)
set(gca,'XTickLabel',[]);

% saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/WL_M_NCGA_%d.png',1));



%%%%%%%%%%%% FL %%%%%%%%%%%
% h=figure;
% % figure(1)
% clf
% set(h, 'Visible', 'off');
% subplot(3,1,1)
% plot(FLF_M(:,1),FLF_M(:,2),'b', 'LineWidth', 2);hold on
% plot(FLF_M(:,1),FLF_M(:,3),'r', 'LineWidth', 2);
% plot(FLF_M(:,1),FLF_M(:,2)-FLF_M(:,3),'g', 'LineWidth', 2);
% % legend('Observation','Tide','Obs.-Tide')
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
% set(gca,'YLim',[-2 2],'YTick',[-2:1:2])
% datetick('x','mmmdd','keepticks')
% grid on
% ax = gca;
% % ax.GridColor = [0 .5 .5];
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
% title('Fernandina Beach, FL')
% ylabel('Water Level (m)')
% set(gca,'XTickLabel',[]);
% set(gca,'FontSize',10)

subplot(5,1,4)
plot(FLM_M(:,1),FLM_M(:,2),'b', 'LineWidth', 2);hold on
plot(FLM_M(:,1),FLM_M(:,3),'r', 'LineWidth', 2);
plot(FLM_M(:,1),FLM_M(:,2)-FLM_M(:,3),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-2 2],'YTick',[-2:1:2])
datetick('x','mmmdd','keepticks')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Mayport, FL')
ylabel('m')
set(gca,'XTickLabel',[]);
set(gca,'FontSize',15)

subplot(5,1,5)
plot(FLF_M(:,1),FLF_M(:,2),'b', 'LineWidth', 2);hold on
plot(FLF_M(:,1),FLF_M(:,3),'r', 'LineWidth', 2);
plot(FLF_M(:,1),FLF_M(:,2)-FLF_M(:,3),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide')
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[-2 2],'YTick',[-2:1:2])
datetick('x','mmmdd','keepticks')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Trident Pier, FL')
ylabel('m')
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',15)
xlabel('Date (2019)')
xtickangle(-30)
set(gcf,'color','w')

% subplot(3,1,3)
% plot(FLV_M(:,1),FLV_M(:,2),'b', 'LineWidth', 2);hold on
% plot(FLV_M(:,1),FLV_M(:,3),'r', 'LineWidth', 2);
% plot(FLV_M(:,1),FLV_M(:,2)-FLV_M(:,3),'g', 'LineWidth', 2);
% % legend('Observation','Tide','Obs.-Tide')
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
% set(gca,'YLim',[-0.6 0.6],'YTick',[-0.6:0.3:0.6])
% datetick('x','mmmdd','keepticks')
% grid on
% ax = gca;
% % ax.GridColor = [0 .5 .5];
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.7;
% title('Virginia Key, FL')
% ylabel('Water Level (m)')
% set(gca,'FontSize',10)
% xlabel('Date (2016)')
% xtickangle(-30)
% set(gcf,'color','w')


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/WL_D.png'));




