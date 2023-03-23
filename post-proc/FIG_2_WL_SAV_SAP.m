clc
clear all
close all



%%%%%%%%%% Observation %%%%%%%%%%%

%%%%%%%%%%% MATTHEW

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_M(:,1)=datenum(strcat(date1,{' '},date2));
GA_M(:,2) = str2double(table2array(GA_I(:,5)));
GA_M(:,3) = str2double(table2array(GA_I(:,3)));
GA_M(:,4) = GA_M(:,2)-GA_M(:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% DORIAN

clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
GA_D(:,1)=datenum(strcat(date1,{' '},date2));
GA_D(:,2) = str2double(table2array(GA_I(:,5)));
GA_D(:,3) = str2double(table2array(GA_I(:,3)));
GA_D(:,4) = GA_D(:,2)-GA_D(:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%
% 
lat_s = 32.03455;  % Fort Pulaski
lon_s = -80.902494;

% lat_s = 31.4832;   % Sapelo inside
% lon_s = -81.3192;
% 

% lat_s = 31.5415;   % Sapelo estuary
% lon_s = -81.2192;

% lat_s = 32.0847; % Savannah city
% lon_s = -81.0365;

% lat_s = 32.2018; % Upstream of Savannah river
% lon_s = -81.142;


% lat_s = 31.761316; % Blackbeard Creek 3
% lon_s = -81.271091;
% 
% lat_s = 31.707687; % Blackbeard Creek 2
% lon_s = -81.120906;
% 
% lat_s =  31.672922; % Blackbeard Creek 1
% lon_s = -80.945734;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);



sshtime1=squeeze(ssh1(index_dist,:));
m_sshtime1=mean(sshtime1);
sshtime2=squeeze(ssh2(index_dist,:));
m_sshtime2=mean(sshtime2);
sshtime3=squeeze(ssh3(index_dist,:));
m_sshtime3=mean(sshtime3);
sshtime4=squeeze(ssh4(index_dist,:));
m_sshtime4=mean(sshtime4);
sshtime5=squeeze(ssh5(index_dist,:));
m_sshtime5=mean(sshtime5);


sshtime1_d=squeeze(sshd1(index_dist,:));
m_sshtime1_d=mean(sshtime1_d);
sshtime2_d=squeeze(sshd2(index_dist,:));
m_sshtime2_d=mean(sshtime2_d);
sshtime3_d=squeeze(sshd3(index_dist,:));
m_sshtime3_d=mean(sshtime3_d);
sshtime4_d=squeeze(sshd4(index_dist,:));
m_sshtime4_d=mean(sshtime4_d);
sshtime5_d=squeeze(sshd5(index_dist,:));
m_sshtime5_d=mean(sshtime5_d);



% lat_s = 32.03455;  % Fort Pulaski
% lon_s = -80.902494;

% lat_s = 31.4832;   % Sapelo inside
% lon_s = -81.3192;
% % % 

lat_s = 31.5415;   % Sapelo estuary
lon_s = -81.2192;

% lat_s = 32.0847; % Savannah city
% lon_s = -81.0365;

% lat_s = 32.2018; % Upstream of Savannah river
% lon_s = -81.142;


% lat_s = 31.761316; % Blackbeard Creek 3
% lon_s = -81.271091;
% 
% lat_s = 31.707687; % Blackbeard Creek 2
% lon_s = -81.120906;
% 
% lat_s =  31.672922; % Blackbeard Creek 1
% lon_s = -80.945734;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sp_sshtime1=squeeze(ssh1(index_dist,:));
% m_sshtime1=mean(sshtime1);
sp_sshtime2=squeeze(ssh2(index_dist,:));
% m_sshtime2=mean(sshtime2);
sp_sshtime3=squeeze(ssh3(index_dist,:));
% m_sshtime3=mean(sshtime3);
sp_sshtime4=squeeze(ssh4(index_dist,:));
% m_sshtime4=mean(sshtime4);
sp_sshtime5=squeeze(ssh5(index_dist,:));
% m_sshtime5=mean(sshtime5);


sp_sshtime1_d=squeeze(sshd1(index_dist,:));
% m_sshtime1_d=mean(sshtime1_d);
sp_sshtime2_d=squeeze(sshd2(index_dist,:));
% m_sshtime2_d=mean(sshtime2_d);
sp_sshtime3_d=squeeze(sshd3(index_dist,:));
% m_sshtime3_d=mean(sshtime3_d);
sp_sshtime4_d=squeeze(sshd4(index_dist,:));
% m_sshtime4_d=mean(sshtime4_d);
sp_sshtime5_d=squeeze(sshd5(index_dist,:));
% m_sshtime5_d=mean(sshtime5_d);



return

%Plotting

% Tide vs NL
ast=25;
TP=240;

figure(5)
clf
subplot(2,1,1)
plot(sshtime3(1,ast:TP),sshtime1(1,ast:TP)-(sshtime3(1,ast:TP)+sshtime5(1,ast:TP)),'ok','linewidth', 2,'MarkerSize',15); hold on
plot(sshtime3_d(1,ast:TP),sshtime1_d(1,ast:TP)-(sshtime3_d(1,ast:TP)+sshtime5_d(1,ast:TP)),'or','linewidth', 2,'MarkerSize',15); 
box on
grid on
xlim([-1.5 1.5])
ylim([-0.3 0.2])
xlabel('Tide (m)')
ylabel('Interaction (m)')
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
plot(sshtime3(1,ast:TP),sshtime2(1,ast:TP)-(sshtime4(1,ast:TP)+sshtime5(1,ast:TP)),'ok','linewidth', 2,'MarkerSize',15); hold on
plot(sshtime3_d(1,ast:TP),sshtime2_d(1,ast:TP)-(sshtime4_d(1,ast:TP)+sshtime5_d(1,ast:TP)),'or','linewidth', 2,'MarkerSize',15); 
box on
grid on
xlim([-1.5 1.5])
ylim([-0.3 0.2])
xlabel('Tide (m)')
ylabel('Interaction (m)')
% ax = gca;
% ax.GridLineStyle = '--';
% ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', 28)


%%
% Time history of each variable


fw=1;
fh=0.6;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

os=0;
skp=20;
TP=220;
ftsize=24;

clf

h1=subplot(2,2,1);
startDate = datenum('10-07-2016'); %Entire period
endDate = datenum('10-09-2016');
refDate = datenum('2016-10-04 00:00:00');

plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+time2(1:TP,1)/(60*60*24),sshtime2(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+os,'ok','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sshtime4(1,1:TP)+os,'or','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sshtime5(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 


set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','dd hh:MM','keepticks')
yticks([-1.5 -1 0 1 2 3])
ylim([-1.5 3])
legend('MT-ST','MT-ST6H','MT-SO','MT-SO6H','MT-TO')
xlabel('Date (2016)')
ylabel('Water level (m)')
title('Hurricane Matthew')
box on
grid on
set(gca, 'FontSize', ftsize)
set(gca,'XTickLabel',[]);


h2=subplot(2,2,2);
os=0;
startDate = datenum('09-04-2019'); %Entire period
endDate = datenum('09-06-2019');
refDate = datenum('2019-09-01 00:00:00');

plot(refDate+timed1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+timed2(1:TP,1)/(60*60*24),sshtime2_d(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(1:TP,1)/(60*60*24),sshtime3_d(1,1:TP)+os,'ok','linewidth', 2,'MarkerSize',15); hold on
plot(refDate+timed4(1:TP,1)/(60*60*24),sshtime4_d(1,1:TP)+os,'or','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed5(1:TP,1)/(60*60*24),sshtime5_d(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
yticks([-1.5 -1 0 1 2 3])
ylim([-1.5 3])
datetick('x','dd hh:MM','keepticks')
legend('DR-ST','DR-ST6H','DR-SO','DR-SO6H','DR-TO')
% xlabel('Date (2019)')
ylabel('Water level (m)')
title('Hurricane Dorian')
box on
grid on
set(gca, 'FontSize', ftsize)
set(gca,'XTickLabel',[]);

h3=subplot(2,2,3);
startDate = datenum('10-07-2016'); 
endDate = datenum('10-09-2016');
refDate = datenum('2016-10-04 00:00:00');

plot(refDate+time1(1:TP,1)/(60*60*24),sp_sshtime1(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+time2(1:TP,1)/(60*60*24),sp_sshtime2(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time3(1:TP,1)/(60*60*24),sp_sshtime3(1,1:TP)+os,'ok','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sp_sshtime4(1,1:TP)+os,'or','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sp_sshtime5(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','dd hh:MM','keepticks')
yticks([-1.5 -1 0 1 2 3])
ylim([-1.5 3])

% legend('MT-ST','MT-ST6H','MT-OS','MT-OS6H','MT-OT')

xlabel('Date (2016-Oct-)')
ylabel('Water level (m)')
box on
grid on
set(gca, 'FontSize', ftsize)

h4=subplot(2,2,4);
startDate = datenum('09-04-2019'); 
endDate = datenum('09-06-2019');
refDate = datenum('2019-09-01 00:00:00');

plot(refDate+timed1(1:TP,1)/(60*60*24),sp_sshtime1_d(1,1:TP)+os,'-k','linewidth', 2); hold on
plot(refDate+timed2(1:TP,1)/(60*60*24),sp_sshtime2_d(1,1:TP)+os,'-r','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed3(1:TP,1)/(60*60*24),sp_sshtime3_d(1,1:TP)+os,'ok','linewidth', 2,'MarkerSize',15); hold on
plot(refDate+timed4(1:TP,1)/(60*60*24),sp_sshtime4_d(1,1:TP)+os,'or','linewidth', 2,'MarkerSize',15); 
plot(refDate+timed5(1:TP,1)/(60*60*24),sp_sshtime5_d(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
yticks([-1.5 -1 0 1 2 3])
ylim([-1.5 3])
datetick('x','dd hh:MM','keepticks')
% legend('DR-ST','DR-ST6H','DR-OS','DR-OS6H','DR-OT')
xlabel('Date (2019-Sep-)')
ylabel('Water level (m)')
box on
grid on
set(gca, 'FontSize', ftsize)
set(gcf,'color','w')

sp_width= 0.419/fw;
sp_height= 0.2/fh;
x_gap=0.08;
y_gap=0.07;
x1 = 0.05;
y1 = 0.55;
x2 = x1+sp_width+x_gap;
y2 = y1-sp_height-y_gap;
x_os=0;
y_os=-0.02;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StormTide/Figures/Figure_2.png',1));


return

%% Practical surge vs pure surge


fw=1;
fh=0.6;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

os=0;
skp=20;
TP=240;
ftsize=24;

clf

h1=subplot(2,2,1);
startDate = datenum('10-07-2016'); %Entire period
endDate = datenum('10-09-2016');
refDate = datenum('2016-10-04 00:00:00');

plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)-sshtime5(1,1:TP),'-k','linewidth', 2); hold on
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime2(1,1:TP)-sshtime5(1,1:TP),'-r','linewidth', 2); hold on
plot(refDate+time3(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+os,'-.k','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sshtime4(1,1:TP)+os,'-.r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sshtime5(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','dd hh:MM','keepticks')
yticks([-1.5 -1 0 1 2])
ylim([-1.5 2])
legend('MT-PS','MT-PS6H','MT-SO','MT-SO6H','MT-TO')
% xlabel('Date (2016)')
ylabel('Water level (m)')
title('Hurricane Matthew')
box on
grid on
set(gca, 'FontSize', ftsize)
set(gca,'XTickLabel',[]);

h2=subplot(2,2,2);
os=0;
startDate = datenum('09-04-2019'); %Entire period
endDate = datenum('09-06-2019');
refDate = datenum('2019-09-01 00:00:00');

plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1_d(1,1:TP)-sshtime5_d(1,1:TP),'-k','linewidth', 2); hold on
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime2_d(1,1:TP)-sshtime5_d(1,1:TP),'-r','linewidth', 2); hold on
plot(refDate+time3(1:TP,1)/(60*60*24),sshtime3_d(1,1:TP)+os,'-.k','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sshtime4_d(1,1:TP)+os,'-.r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sshtime5_d(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
yticks([-1.5 -1 0 1 2])
ylim([-1.5 2])
datetick('x','dd hh:MM','keepticks')
legend('DR-PS','DR-PS6H','DR-SO','DR-SO6H','DR-TO')
% xlabel('Date (2019)')
ylabel('Water level (m)')
title('Hurricane Dorian')
box on
grid on
set(gca, 'FontSize', ftsize)
set(gca,'XTickLabel',[]);

h3=subplot(2,2,3);
startDate = datenum('10-07-2016'); 
endDate = datenum('10-09-2016');
refDate = datenum('2016-10-04 00:00:00');

plot(refDate+time1(1:TP,1)/(60*60*24),sp_sshtime1(1,1:TP)-sshtime5(1,1:TP),'-k','linewidth', 2); hold on
plot(refDate+time1(1:TP,1)/(60*60*24),sp_sshtime2(1,1:TP)-sshtime5(1,1:TP),'-r','linewidth', 2); hold on
plot(refDate+time3(1:TP,1)/(60*60*24),sp_sshtime3(1,1:TP)+os,'-.k','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sp_sshtime4(1,1:TP)+os,'-.r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sp_sshtime5(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','dd hh:MM','keepticks')
yticks([-1.5 -1 0 1 2])
ylim([-1.5 2])

% legend('MT-ST','MT-ST6H','MT-OS','MT-OS6H','MT-OT')

xlabel('Date (2016-Oct-)')
ylabel('Water level (m)')
box on
grid on
set(gca, 'FontSize', ftsize)

h4=subplot(2,2,4);
startDate = datenum('09-04-2019'); 
endDate = datenum('09-06-2019');
refDate = datenum('2019-09-01 00:00:00');

plot(refDate+time1(1:TP,1)/(60*60*24),sp_sshtime1_d(1,1:TP)-sshtime5_d(1,1:TP),'-k','linewidth', 2); hold on
plot(refDate+time1(1:TP,1)/(60*60*24),sp_sshtime2_d(1,1:TP)-sshtime5_d(1,1:TP),'-r','linewidth', 2); hold on
plot(refDate+time3(1:TP,1)/(60*60*24),sp_sshtime3_d(1,1:TP)+os,'-.k','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sp_sshtime4_d(1,1:TP)+os,'-.r','linewidth', 2,'MarkerSize',15); 
plot(refDate+time4(1:TP,1)/(60*60*24),sp_sshtime5_d(1,1:TP)+os,'-g','linewidth', 2,'MarkerSize',15); 

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
yticks([-1.5 -1 0 1 2])
ylim([-1.5 2])
datetick('x','dd hh:MM','keepticks')
% legend('DR-ST','DR-ST6H','DR-OS','DR-OS6H','DR-OT')
xlabel('Date (2019-Sep-)')
ylabel('Water level (m)')
box on
grid on
set(gca, 'FontSize', ftsize)
set(gcf,'color','w')

sp_width= 0.419/fw;
sp_height= 0.2/fh;
x_gap=0.08;
y_gap=0.07;
x1 = 0.05;
y1 = 0.55;
x2 = x1+sp_width+x_gap;
y2 = y1-sp_height-y_gap;
x_os=0;
y_os=-0.02;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Figures_StormTide/Figures/Figure_2.png',1));

