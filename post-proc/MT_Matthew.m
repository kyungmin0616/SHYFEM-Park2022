%% Wave parameters
clc
clear


%%%%%%%%%% MATTHEW %%%%%%%%%%%
FLF_I=readtable('GA_MATTHEW.csv');
date1=table2array(FLF_I(:,1));
GA_M(:,1)=datenum(date1);
GA_M(:,2) = table2array(FLF_I(:,2));
GA_M(:,3) = table2array(FLF_I(:,3));
GA_M(:,4) = table2array(FLF_I(:,6));

%%%%%%%%%% DORIAN %%%%%%%%%%%
FLF_I=readtable('GA_DORIAN.csv');
date1=table2array(FLF_I(:,1));
GA_D(:,1)=datenum(date1);
GA_D(:,2) = table2array(FLF_I(:,2));
GA_D(:,3) = table2array(FLF_I(:,3));
GA_D(:,4) = table2array(FLF_I(:,6));


%% Plotting-Matthew


startDate = datenum('10-03-2016');
endDate = datenum('10-13-2016');

%%%%%%%%%%%% NC to GA %%%%%%%%%%%

h=figure('units','normalized','position',[0.1 0.2 .4 0.8]);

% figure(1)
clf
set(h, 'Visible', 'on');
subplot(5,1,1)
plot(GA_M(:,1),GA_M(:,3),'b', 'LineWidth', 2);hold on
plot(GA_M(:,1),GA_M(:,3),'r', 'LineWidth', 2);

figure(1)
clf
startDate = datenum('10-03-2016');
endDate = datenum('10-13-2016');
subplot(2,1,1)
plot(GA_M(:,1),GA_M(:,3),'b', 'LineWidth', 2);hold on
% plot(GA_D(:,3),'r', 'LineWidth', 2);hold on
% datetick('x','mmmdd','keepticks')


% plot(NC_M(:,1),NC_M(:,2)-NC_M(:,3),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide');
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[0 360],'YTick',[0:90:360])
datetick('x','mmmdd','keepticks')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Matthew')
ylabel('m')
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',15)

set(gcf,'color','w')


idx=10;

subplot(2,1,1)
wdatenum=GA_M(1:idx:end,1);
wspeed=GA_M(1:idx:end,2);
wradian=deg2rad(GA_M(1:idx:end,3)); % change degree to radian
[u,v]=pol2cart(wradian,-wspeed);
figure(1)
% q=quiver(wdatenum,wdatenum.*0,u,v,0,'k');
q=quiver(wdatenum,wdatenum.*0,u,v,0,'k');

q.ShowArrowHead='on';
set(gca,'xlim',[min(wdatenum) max(wdatenum)],'fontsize',15);
datetick('x','mm-dd','keepticks','keeplimits');      
% xlabel('Date (Dec.2018)','fontsize',15)  
ylabel('Wind','fontsize',15);
     
subplot(2,1,2)
wdatenum=GA_D(1:idx:end,1);
wspeed=GA_D(1:idx:end,2);
wradian=deg2rad(GA_D(1:idx:end,3)); % change degree to radian
[u,v]=pol2cart(wradian,-wspeed);
figure(1)
% q=quiver(wdatenum,wdatenum.*0,u,v,0,'k');
q=quiver(wdatenum,wdatenum.*0,u,v,0,'k');

q.ShowArrowHead='on';
set(gca,'xlim',[min(wdatenum) max(wdatenum)],'fontsize',15);
datetick('x','mm-dd','keepticks','keeplimits');      
% xlabel('Date (Dec.2018)','fontsize',15)  
ylabel('Wind','fontsize',15);


     

startDate = datenum('08-31-2019');
endDate = datenum('09-10-2019');

subplot(2,1,2)
plot(GA_D(:,1),GA_D(:,3),'b', 'LineWidth', 2);hold on
% plot(GA_D(:,3),'r', 'LineWidth', 2);hold on
% datetick('x','mmmdd','keepticks')


% plot(NC_M(:,1),NC_M(:,2)-NC_M(:,3),'g', 'LineWidth', 2);
% legend('Observation','Tide','Obs.-Tide');
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/11:endDate])
set(gca,'YLim',[0 360],'YTick',[0:90:360])
datetick('x','mmmdd','keepticks')
grid on
ax = gca;
% ax.GridColor = [0 .5 .5];
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Dorian')
ylabel('m')
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',15)

set(gcf,'color','w')

