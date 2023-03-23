%% Matthew

fw=1;
fh=1;
ftsz=21;
ftszt=16;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

% NOAA Fort Pulaski
h1=subplot(5,2,1);

lat_s = 32.03455; 
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh1(index_dist,:));

clear obs_wl obs_t
obs_wl=NOAA.mttotal;
obs_t=NOAA.mttime;
dt = minutes(6);
clear TT TT2 TT3 ID IDO
ID = find(time1>=startDate & time1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(time1(ID,1))),sshtime1(1,ID)');
TT2 = retime(TT,'regular','linear','TimeStep',dt);
obs_wl=obs_wl(IDO,1);
obs_t=obs_t(IDO,1);

bias.noaa1_mt=(nanmean(TT2.Var1-obs_wl));
corrcoef(TT2.Var1,obs_wl);
corr.noaa1_mt=ans(1,2);
rmse.noaa1_mt=sqrt(nanmean((TT2.Var1-obs_wl).^2));

plot(obs_t,TT2.Var1,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color','r','MarkerFaceColor','r');hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-1.5 0 1.5 3]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
title('NOAA 8670870','FontSize',ftszt)
legend('Mdl.','Obs.','Orientation','horizontal')
% legend('Ori.','New','Obs.','Orientation','horizontal')

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

clear obs_wl obs_t
obs_wl=USGS.mtSTA_10(:,3);
obs_t=USGS.mtSTA_10(:,2);
dt = minutes(15);
clear TT TT2 ID IDO
ID = find(time1>=startDate & time1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(time1(ID,1))),sshtime1(1,ID)');
TT2 = retime(TT,'regular','linear','TimeStep',dt);
obs_wl=obs_wl(IDO,1);
obs_t=obs_t(IDO,1);

bias.usgs1_mt=(nanmean(TT2.Var1-obs_wl))
corrcoef(TT2.Var1,obs_wl);
corr.usgs1_mt=ans(1,2)
rmse.usgs1_mt=sqrt(nanmean((TT2.Var1-obs_wl).^2))

plot(obs_t,TT2.Var1,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color','g','MarkerFaceColor','g');

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-1.5 0 1.5 3]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
% legend('Ori.','New','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)


% USGS 021989715

h3=subplot(5,2,3);

clear sshtime1 sshtime2
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:));

clear obs_wl obs_t
obs_wl=USGS.mtSTA_5(:,3);
obs_t=USGS.mtSTA_5(:,2);
dt = minutes(15);
clear TT TT2 TT3 ID IDO
ID = find(time1>=startDate & time1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(time1(ID,1))),sshtime1(1,ID)');
TT2 = retime(TT,'regular','linear','TimeStep',dt);
obs_wl=obs_wl(IDO,1);
obs_t=obs_t(IDO,1);

bias.usgs2_mt=(nanmean(TT2.Var1-obs_wl))
corrcoef(TT2.Var1,obs_wl);
corr.usgs2_mt=ans(1,2)
rmse.usgs2_mt=sqrt(nanmean((TT2.Var1-obs_wl).^2))

plot(obs_t,TT2.Var1,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color','g','MarkerFaceColor','g');

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-1.5 0 1.5 3]);
datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
% legend('Ori.','New','Obs.','Orientation','horizontal')

grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',ftszt)
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

% USGS 022035975
h4=subplot(5,2,4);

lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(ssh1(index_dist,:))-0.3;

clear obs_wl obs_t
obs_wl=USGS.mtSTA_11(:,3);
obs_t=USGS.mtSTA_11(:,2);
dt = minutes(15);
clear TT TT2 TT3 ID IDO
ID = find(time1>=startDate & time1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(time1(ID,1))),sshtime1(1,ID)');
TT2 = retime(TT,'regular','linear','TimeStep',dt);
obs_wl=obs_wl(IDO,1);
obs_t=obs_t(IDO,1);

bias.usgs3_mt=(nanmean(TT2.Var1-obs_wl))
corrcoef(TT2.Var1,obs_wl);
corr.usgs3_mt=ans(1,2)
rmse.usgs3_mt=sqrt(nanmean((TT2.Var1-obs_wl).^2))

plot(obs_t,TT2.Var1,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color','g','MarkerFaceColor','g');

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-1.5 0 1.5 3]);
datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
% legend('Ori.','New','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',ftszt)
% set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')



saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Val_mt3.png',1));


%% Dorian

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

fw=1;
fh=1;
ftsz=21;
ftszt=16;

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

h1=subplot(5,2,1);

lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=NOAA.drtotal;
obs_t=NOAA.drtime;
dt = minutes(6);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(time1(ID,1))),sshtime1(1,ID)');
TT2 = retime(TT,'regular','linear','TimeStep',dt);
obs_wl=obs_wl(IDO,1);
obs_t=obs_t(IDO,1);

bias.noaa1_dr=(nanmean(TT2.Var1-obs_wl));
corrcoef(TT2.Var1,obs_wl);
corr.noaa1_dr=ans(1,2);
rmse.noaa1_dr=sqrt(nanmean((TT2.Var1-obs_wl).^2));

plot(obs_t,TT2.Var1,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color','r','MarkerFaceColor','r');hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
title('NOAA 8670870','FontSize',ftszt)
legend('Mdl.','Obs.','Orientation','horizontal')
% legend('Ori.','New','Obs.','Orientation','horizontal')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', ftsz)

clf
% USGS 0219897993
h2=subplot(5,2,2);
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=USGS.drSTA_10(:,3);
obs_t=USGS.drSTA_10(:,2);
dt = minutes(60);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(obs_t(IDO,1))),obs_wl(IDO,1));
TT2 = retime(TT,'regular','linear','TimeStep',dt);
mdl_wl=sshtime1(1,ID)';
mdl_t=timed1(ID,1);

bias.usgs1_dr=(nanmean(TT2.Var1-mdl_wl));
corrcoef(TT2.Var1,mdl_wl);
corr.usgs1_dr=ans(1,2);
rmse.usgs1_dr=sqrt(nanmean((TT2.Var1-mdl_wl).^2));

plot(mdl_t,mdl_wl,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color','g','MarkerFaceColor','g');hold on
plot(mdl_t,TT2.Var1,'o','Color','g','MarkerFaceColor','g');hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 0219897993','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)


% USGS 021989715

h3=subplot(5,2,3);
lat_s = 32.1160833333333;
lon_s = -81.1283333333333;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=USGS.drSTA_5(:,3);
obs_t=USGS.drSTA_5(:,2);
dt = minutes(15);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(time1(ID,1))),sshtime1(1,ID)');
TT2 = retime(TT,'regular','linear','TimeStep',dt);
obs_wl=obs_wl(IDO,1);
obs_t=obs_t(IDO,1);

bias.usgs2_dr=(nanmean(TT2.Var1-obs_wl));
corrcoef(TT2.Var1,obs_wl);
corr.usgs2_dr=ans(1,2);
rmse.usgs2_dr=sqrt(nanmean((TT2.Var1-obs_wl).^2));

plot(obs_t,TT2.Var1,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color','g','MarkerFaceColor','g');hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);
datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 021989715','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

% USGS 022035975
figure
clf
% h4=subplot(5,2,4);
lat_s = 31.45333333;
lon_s = -81.36277778;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:))-0.3;

clear obs_wl obs_t
obs_wl=USGS.drSTA_11(:,3);
obs_t=USGS.drSTA_11(:,2);
dt = minutes(15);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(time1(ID,1))),sshtime1(1,ID)');
TT2 = retime(TT,'regular','linear','TimeStep',dt);
obs_wl=obs_wl(IDO,1);
obs_t=obs_t(IDO,1);

bias.usgs3_dr=(nanmean(TT2.Var1-obs_wl));
corrcoef(TT2.Var1,obs_wl);
corr.usgs3_dr=ans(1,2);
rmse.usgs3_dr=sqrt(nanmean((TT2.Var1-obs_wl).^2));

plot(obs_t,TT2.Var1,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color','g','MarkerFaceColor','g');hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);
datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('USGS 022035975','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

%%%%%%%%% Station number for SSLS &&&& 1 4 5 11 18 20
% SSLS 1: Bull River (stn:1) 2: Turner Creek (stn:20) 3: Hwy 80 at Grays
% creek (stn:11) 4: Solomon Bridge (stn:18) 5: Diamond Causeway (stn:4) 6: Faye drive
% (stn: 5)

% startDate = datenum('09-02-2019 12:00:00');
% endDate = datenum('09-06-2019 12:00:00');

h5=subplot(5,2,5);
stn=1; % 

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=SSLS.(['sta',num2str(stn)])(:,3);
obs_t=SSLS.(['sta',num2str(stn)])(:,1);
dt = minutes(60);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(obs_t(IDO,1))),obs_wl(IDO,1));
TT2 = retime(TT,'regular','linear','TimeStep',dt);
mdl_wl=sshtime1(1,ID)';
mdl_t=timed1(ID,1);

bias.ssls1_dr=(nanmean(TT2.Var1-mdl_wl));
corrcoef(TT2.Var1,mdl_wl);
corr.ssls1_dr=ans(1,2);
rmse.ssls1_dr=sqrt(nanmean((TT2.Var1-mdl_wl).^2));

plot(mdl_t,mdl_wl,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);
datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h6=subplot(5,2,6);
stn=20;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=SSLS.(['sta',num2str(stn)])(:,3);
obs_t=SSLS.(['sta',num2str(stn)])(:,1);
dt = minutes(60);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(obs_t(IDO,1))),obs_wl(IDO,1));
TT2 = retime(TT,'regular','linear','TimeStep',dt);
mdl_wl=sshtime1(1,ID)';
mdl_t=timed1(ID,1);

bias.ssls2_dr=(nanmean(TT2.Var1-mdl_wl));
corrcoef(TT2.Var1,mdl_wl);
corr.ssls2_dr=ans(1,2);
rmse.ssls2_dr=sqrt(nanmean((TT2.Var1-mdl_wl).^2));

plot(mdl_t,mdl_wl,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);
datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

h7=subplot(5,2,7);
stn=11;
lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=SSLS.(['sta',num2str(stn)])(:,3);
obs_t=SSLS.(['sta',num2str(stn)])(:,1);
dt = minutes(60);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(obs_t(IDO,1))),obs_wl(IDO,1));
TT2 = retime(TT,'regular','linear','TimeStep',dt);
mdl_wl=sshtime1(1,ID)';
mdl_t=timed1(ID,1);

bias.ssls3_dr=(nanmean(TT2.Var1-mdl_wl));
corrcoef(TT2.Var1,mdl_wl);
corr.ssls3_dr=ans(1,2);
rmse.ssls3_dr=sqrt(nanmean((TT2.Var1-mdl_wl).^2));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h8=subplot(5,2,8);
stn=18;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=SSLS.(['sta',num2str(stn)])(:,3);
obs_t=SSLS.(['sta',num2str(stn)])(:,1);
dt = minutes(60);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(obs_t(IDO,1))),obs_wl(IDO,1));
TT2 = retime(TT,'regular','linear','TimeStep',dt);
mdl_wl=sshtime1(1,ID)';
mdl_t=timed1(ID,1);

bias.ssls4_dr=(nanmean(TT2.Var1-mdl_wl));
corrcoef(TT2.Var1,mdl_wl);
corr.ssls4_dr=ans(1,2);
rmse.ssls4_dr=sqrt(nanmean((TT2.Var1-mdl_wl).^2));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h9=subplot(5,2,9);
stn=4;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=SSLS.(['sta',num2str(stn)])(:,3);
obs_t=SSLS.(['sta',num2str(stn)])(:,1);
dt = minutes(60);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(obs_t(IDO,1))),obs_wl(IDO,1));
TT2 = retime(TT,'regular','linear','TimeStep',dt);
mdl_wl=sshtime1(1,ID)';
mdl_t=timed1(ID,1);

bias.ssls5_dr=(nanmean(TT2.Var1-mdl_wl));
corrcoef(TT2.Var1,mdl_wl);
corr.ssls5_dr=ans(1,2);
rmse.ssls5_dr=sqrt(nanmean((TT2.Var1-mdl_wl).^2));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h10=subplot(5,2,10);
stn=5;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=SSLS.(['sta',num2str(stn)])(:,3);
obs_t=SSLS.(['sta',num2str(stn)])(:,1);
dt = minutes(60);
clear TT TT2 TT3 ID IDO
ID = find(timed1>=startDate & timed1<=endDate);
IDO = find(obs_t>=startDate & obs_t<=endDate);
clear TT
TT = timetable(datetime(datestr(obs_t(IDO,1))),obs_wl(IDO,1));
TT2 = retime(TT,'regular','linear','TimeStep',dt);
mdl_wl=sshtime1(1,ID)';
mdl_t=timed1(ID,1);

bias.ssls6_dr=(nanmean(TT2.Var1-mdl_wl));
corrcoef(TT2.Var1,mdl_wl);
corr.ssls6_dr=ans(1,2);
rmse.ssls6_dr=sqrt(nanmean((TT2.Var1-mdl_wl).^2));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(SSLS.(['sta',num2str(stn)])(:,1),SSLS.(['sta',num2str(stn)])(:,3),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0])

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'FontSize',ftsz)
set(gcf,'color','w')

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Val_dr2.png',1));


%%%%%%%%% Station number for SSLS &&&& 2 5 11 12 14 20
% SSLS 1: Oatland island (stn:14) 2: HWY 80 at Grays (stn:11) 3: Laroche
% (stn:12) 4: Turner creek (stn:20) 5: Coffee bluff (stn: 2) 6: Faye drive
% (stn: 5)
