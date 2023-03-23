%% Matthew

fw=1;
fh=1;
ftsz=21;
ftszt=16;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');
% NOAA Fort Pulaski ---------------  Matthew
h1=subplot(2,1,1);

lat_s = 32.03455; 
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh1(index_dist,:));

clear obs_wl obs_t
obs_wl=NOAA.mttide;
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
% plot(time2,sshtime2,'-b','linewidth', 3);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-1.5 0 1.5 3]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
title('NOAA 8670870','FontSize',ftszt)
legend('Mdl.','NOAA','Orientation','horizontal')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', ftsz)


% NOAA Fort Pulaski ---------------  Dorian

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

h1=subplot(2,1,2);

lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

clear obs_wl obs_t
obs_wl=NOAA.drtide;
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

bias.noaa1_dr=(nanmean(TT2.Var1-obs_wl))
corrcoef(TT2.Var1,obs_wl);
corr.noaa1_dr=ans(1,2)
rmse.noaa1_dr=sqrt(nanmean((TT2.Var1-obs_wl).^2))

plot(obs_t,TT2.Var1,'-k','linewidth', 3);hold on
plot(obs_t,obs_wl,'o','Color','r','MarkerFaceColor','r');hold on
% plot(timed2,sshtime2,'-b','linewidth', 3);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-2 3],'YTick',[-2 0 2]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
title('NOAA 8670870','FontSize',ftszt)
legend('Mdl.','NOAA','Orientation','horizontal')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', ftsz)
