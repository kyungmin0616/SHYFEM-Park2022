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

lat_s = 32.0847; % Savannah city
lon_s = -81.0365;

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
TP=240;
ftsize=24;

% clf

h1=subplot(2,2,1);


ID = find(GA_D(:,1)>=datenum('2019-09-01 00:00:00') & GA_D(:,1)<=datenum('2019-09-11 23:00:00'));
IM = find(GA_M(:,1)>=datenum('2016-10-04 00:00:00') & GA_M(:,1)<=datenum('2016-10-14 23:00:00'));



clear stide tide I_stide I_tide
% tide=sshtime3(1,25:25+24*6)+os-0.5;

a_x=1:1:145;
a_x2=1:144/1440:145;
I_stide=interp1(a_x,stide',a_x2);
% I_tide=interp1(a_x,tide',a_x2);

rmse_stide_t=sqrt(nanmean((I_stide'-GA_M(gi:ge,2)).^2));
% rmse_tide_t=sqrt(nanmean((I_tide'-GA_M(gi:ge,3)).^2));



startDate = datenum('10-04-2016 00:00:00'); %Entire period
endDate = datenum('10-11-2016 00:00:00');
refDate = datenum('2016-10-04 00:00:00');


gi=find(GA_M(:,1)==startDate);
ge=find(GA_M(:,1)==endDate);



clear stide
stide=sshtime5(1,1:24*7+1)+0.68-1.8;
a_x=1:1:169;
a_x2=1:168/1680:169;
f_intp_tide=interp1(a_x,stide',a_x2);

clear stide
stide=sshtime1(1,1:24*7+1)+0.68-1.15;
a_x=1:1:169;
a_x2=1:168/1680:169;
f_intp_total=interp1(a_x,stide',a_x2);

clear stide
stide=sshtime3(1,1:24*7+1)+0.6;
a_x=1:1:169;
a_x2=1:168/1680:169;
f_intp_surge=interp1(a_x,stide',a_x2);

clear NOAA SHYFEM

NOAA.time=GA_M(gi:ge,1);
NOAA.total=GA_M(gi:ge,2);
NOAA.tide=GA_M(gi:ge,3);

SHYFEM.time=GA_M(gi:ge,1);
SHYFEM.total=f_intp_total'
SHYFEM.tide=f_intp_tide';
SHYFEM.surge=f_intp_surge';

save manu.mat NOAA SHYFEM


figure(4)
clf
% 
% 
% plot(SHYFEM.time,SHYFEM.total-SHYFEM.tide,'-r','linewidth', 2); hold on
% plot(NOAA.time,NOAA.total-NOAA.tide,'-b','linewidth', 2,'MarkerSize',15); 
% plot(SHYFEM.time,NOAA.total-SHYFEM.total,'-g','linewidth', 2,'MarkerSize',15); 
% plot(NOAA.time,NOAA.tide-SHYFEM.tide,'-k','linewidth', 2,'MarkerSize',15); 
% plot(SHYFEM.time,SHYFEM.surge,'-k','linewidth', 2,'MarkerSize',15); 

plot(SHYFEM.time,NOAA.tide,'-r','linewidth', 2); hold on
plot(SHYFEM.time,SHYFEM.tide,'-b','linewidth', 2); hold on

plot(GA_M(gi:ge,1),f_intp_total'-f_intp_tide','-r','linewidth', 2); hold on
plot(GA_M(gi:ge,1),GA_M(gi:ge,2)-GA_M(gi:ge,3),'-b','linewidth', 2,'MarkerSize',15); 
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+0.6,'-g','linewidth', 2,'MarkerSize',15); 


%total
% plot(GA_M(gi:ge,1),f_intp_total','-r','linewidth', 2); hold on
% plot(GA_M(gi:ge,1),GA_M(gi:ge,2),'-b','linewidth', 2,'MarkerSize',15); 

%tide
% plot(GA_M(gi:ge,1),f_intp_tide','-r','linewidth', 2); hold on
% plot(GA_M(gi:ge,1),GA_M(gi:ge,3),'-b','linewidth', 2,'MarkerSize',15); 


set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','mmm-dd hh','keepticks')
% yticks([-1.5 -1 0 1 2])
% ylim([-1.5 2])
% legend('SHYFEM','NOAA','Diff. Total','Diff. Tide')
legend('SHYFEM','NOAA','Storm surge')

% xlabel('Date (2016)')
ylabel('Water level (m)')
title('Hurricane Matthew')
box on
grid on
set(gca, 'FontSize', ftsize)
% set(gca,'XTickLabel',[]);



figure(4)
clf
% 
% 
% plot(GA_M(gi:ge,1),f_intp_total'-GA_M(gi:ge,3),'-r','linewidth', 2); hold on
% plot(GA_M(gi:ge,1),GA_M(gi:ge,2)-GA_M(gi:ge,3),'-b','linewidth', 2,'MarkerSize',15); 
% plot(GA_M(gi:ge,1),GA_M(gi:ge,2)-f_intp_total','-g','linewidth', 2,'MarkerSize',15); 
% plot(GA_M(gi:ge,1),GA_M(gi:ge,3)-f_intp_tide','-k','linewidth', 2,'MarkerSize',15); 

% plot(GA_M(gi:ge,1),f_intp_total'-f_intp_tide','-r','linewidth', 2); hold on
% plot(GA_M(gi:ge,1),GA_M(gi:ge,2)-f_intp_tide','-b','linewidth', 2,'MarkerSize',15); 

plot(GA_M(gi:ge,1),f_intp_total'-f_intp_tide','-r','linewidth', 2); hold on
plot(GA_M(gi:ge,1),GA_M(gi:ge,2)-GA_M(gi:ge,3),'-b','linewidth', 2,'MarkerSize',15); 
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime3(1,1:TP)+0.6,'-g','linewidth', 2,'MarkerSize',15); 


%total
% plot(GA_M(gi:ge,1),f_intp_total','-r','linewidth', 2); hold on
% plot(GA_M(gi:ge,1),GA_M(gi:ge,2),'-b','linewidth', 2,'MarkerSize',15); 

%tide
% plot(GA_M(gi:ge,1),f_intp_tide','-r','linewidth', 2); hold on
% plot(GA_M(gi:ge,1),GA_M(gi:ge,3),'-b','linewidth', 2,'MarkerSize',15); 


set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','mmm-dd hh','keepticks')
% yticks([-1.5 -1 0 1 2])
% ylim([-1.5 2])
% legend('SHYFEM','NOAA','Diff. Total','Diff. Tide')
legend('SHYFEM','NOAA','Storm surge')

% xlabel('Date (2016)')
ylabel('Water level (m)')
title('Hurricane Matthew')
box on
grid on
set(gca, 'FontSize', ftsize)
% set(gca,'XTickLabel',[]);



reflevel=-0.46;
figure(1)
clf

% plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)-sshtime5(1,1:TP),'-k','linewidth', 2); hold on
% plot(GA_M(gi:ge,1),GA_M(gi:ge,2)-(f_intp_tide'-1.8)-0.9,'-g','linewidth', 2,'MarkerSize',15); 
plot(refDate+time1(1:TP,1)/(60*60*24),sshtime1(1,1:TP)-0.46,'-r','linewidth', 2); hold on
plot(GA_M(gi:ge,1),GA_M(gi:ge,2),'-b','linewidth', 2); hold on


set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate])
datetick('x','mmm-dd hh','keepticks')
% yticks([-1.5 -1 0 1 2])
% ylim([-1.5 2])
legend('SHYFEM','NOAA')
% xlabel('Date (2016)')
ylabel('Water level (m)')
title('Hurricane Matthew')
box on
grid on
set(gca, 'FontSize', ftsize)
% set(gca,'XTickLabel',[]);







