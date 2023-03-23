%% Observations

%%%%%%%%%%% Load data
load NOAA_1yr.mat
% load USGS.mat
% load SSLS.mat

%%%%%%%%%%% NOAA
% OUT=NOAA_data(2016,2016,'8670870','water_level','NAVD');

%%%%%%%%%%% SSLS
offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');

clear SLS desc list wl SSLS
SLS = importdata('/Users/kpark350/Ga_tech/Projects/DataSet/SSLS/Py/hurricane_dorian.csv');

desc = string(SLS.textdata(2:end,1));
list = unique(desc);
SLS.textdata(1,:)=[];

for i=1:length(list)

    lon_tmp=SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),2);
    lat_tmp=SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),3);
    
    list(i,2) = string(lon_tmp(1,1));
    list(i,3) = string(lat_tmp(1,1));
    
    SSLS.(['sta',num2str(i)])(:,1)=datenum(string(SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),4)),'yyyy-mm-dd HH:MM:SS')+offdate; %NEW VER
    SSLS.(['sta',num2str(i)])(:,2)=SLS.data(strcmp(string(SLS.textdata(:,1)),list(i)),1)*0.3048;
    SSLS.(['sta',num2str(i)])(:,3)=SLS.data(strcmp(string(SLS.textdata(:,1)),list(i)),2)*0.3048;

    clear lon_tmp lat_tmp
    
end

startDate = datenum('08-30-2019');
endDate = datenum('09-07-2019');
dt = minutes(6);

clear SSLS_int

for i=1:length(list)

   
    ID = find(SSLS.(['sta',num2str(i)])(:,1)>=startDate & SSLS.(['sta',num2str(i)])(:,1)<=endDate);
    [C,IA,IC] = unique(SSLS.(['sta',num2str(i)])(ID,1));
    TT = timetable(datetime(datestr(SSLS.(['sta',num2str(i)])(ID(IA),1))),SSLS.(['sta',num2str(i)])(ID(IA),3));
    TT2 = retime(TT,'regular','linear','TimeStep',dt);
    
    SSLS_int.(['sta',num2str(i)])(:,1)=datenum(TT2.Time);
    SSLS_int.(['sta',num2str(i)])(:,2)=TT2.Var1;
    [TIDESTRUC,SSLS_int.(['sta',num2str(i)])(:,3)]=t_tide(SSLS_int.(['sta',num2str(i)])(:,2),'interval',1/10,'latitude',32);

    
end



%%%%%%%%%%% USGS
clear USGS
files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/1yr/Matthew');
files(1:3)=[];

files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/1yr/Dorian');
files2(1:3)=[];


clear USGS

startDate = datenum('10-04-2016');
endDate = datenum('10-15-2016');

for i = 1:length(files)
    
  temp=readtable([files(i).folder '/' files(i).name]);
  
  ID = find(datenum(table2array(temp(:,3)))+offdate>=startDate & datenum(table2array(temp(:,3)))+offdate<=endDate);
      
  USGS.(sprintf('mtSTA_%d', i))(:,2) = datenum(table2array(temp(ID,3)))+offdate;
  USGS.(sprintf('mtSTA_%d', i))(:,3) = table2array(temp(ID,5)).*0.3048;
  USGS.(sprintf('mtSTA_%d', i))(:,1) = table2array(temp(ID,2));
  [TIDESTRUC,USGS.(sprintf('mtSTA_%d', i))(:,4)]=t_tide(USGS.(sprintf('mtSTA_%d', i))(:,3),'interval',1/4,'latitude',31);

  clear temp
  
end

startDate = datenum('09-01-2019');
endDate = datenum('09-12-2019');

for i = 1:length(files2)
    
  temp=readtable([files2(i).folder '/' files2(i).name]);
  
  ID = find(datenum(table2array(temp(:,3)))+offdate>=startDate & datenum(table2array(temp(:,3)))+offdate<=endDate);

  USGS.(sprintf('drSTA_%d', i))(:,2) = datenum(table2array(temp(ID,3)))+offdate;
  USGS.(sprintf('drSTA_%d', i))(:,3) = table2array(temp(ID,5)).*0.3048;
  USGS.(sprintf('drSTA_%d', i))(:,1) = table2array(temp(ID,2));
  [TIDESTRUC,USGS.(sprintf('drSTA_%d', i))(:,4)]=t_tide(USGS.(sprintf('drSTA_%d', i))(:,3),'interval',1/4,'latitude',31);

  clear temp
  
end



startDate = datenum('10-04-2016');
endDate = datenum('10-15-2016');
dt = minutes(6);

for i=1:length(files)

   
    ID = find(USGS.(sprintf('mtSTA_%d', i))(:,2)>=startDate & USGS.(sprintf('mtSTA_%d', i))(:,2)<=endDate);
    [C,IA,IC] = unique(USGS.(sprintf('mtSTA_%d', i))(:,2));
    TT = timetable(datetime(datestr(USGS.(sprintf('mtSTA_%d', i))(ID(IA),2))),USGS.(sprintf('mtSTA_%d', i))(:,3));
    TT2 = retime(TT,'regular','linear','TimeStep',dt);
    
    USGS_int.(sprintf('mtSTA_%d', i))(:,1)=datenum(TT2.Time);
    USGS_int.(sprintf('mtSTA_%d', i))(:,2)=TT2.Var1;
    [TIDESTRUC,USGS_int.(sprintf('mtSTA_%d', i))(:,3)]=t_tide(USGS_int.(sprintf('mtSTA_%d', i))(:,2),'interval',1/10,'latitude',32);

    
end

startDate = datenum('09-01-2019');
endDate = datenum('09-12-2019');


for i=1:length(files2)

   
    ID = find(USGS.(sprintf('drSTA_%d', i))(:,2)>=startDate & USGS.(sprintf('drSTA_%d', i))(:,2)<=endDate);
    [C,IA,IC] = unique(USGS.(sprintf('drSTA_%d', i))(:,2));
    TT = timetable(datetime(datestr(USGS.(sprintf('drSTA_%d', i))(ID(IA),2))),USGS.(sprintf('drSTA_%d', i))(:,3));
    TT2 = retime(TT,'regular','linear','TimeStep',dt);
    
    USGS_int.(sprintf('drSTA_%d', i))(:,1)=datenum(TT2.Time);
    USGS_int.(sprintf('drSTA_%d', i))(:,2)=TT2.Var1;
    [TIDESTRUC,USGS_int.(sprintf('drSTA_%d', i))(:,3)]=t_tide(USGS_int.(sprintf('drSTA_%d', i))(:,2),'interval',1/10,'latitude',32);

    
end


%% vs SSLS comparison

fs=1/(6*60);
fti=1/(24*60*60);

startDate = datenum('09-01-2019');
endDate = datenum('09-12-2019');

IDXXX=[1 20 11 18 4 5];
k=1;
figure(2)
clf
for stn=1:length(IDXXX)
    stn=IDXXX(1,stn);
%     stn=11;
    lat_s = str2num(list(stn,2));
    lon_s = str2num(list(stn,3));
%     
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:));

    figure(2)
    subplot(length(IDXXX),1,k)
    plot(SSLS_int.(['sta',num2str(stn)])(:,1),SSLS_int.(['sta',num2str(stn)])(:,2),'linewidth', 3);hold on
    plot(SSLS_int.(['sta',num2str(stn)])(:,1),SSLS_int.(['sta',num2str(stn)])(:,3),'linewidth', 3);hold on
    plot(NOAA.drtide(:,1),NOAA.drtide(:,2),'linewidth', 3);hold on
%     plot(SSLS_int.(['sta',num2str(stn)])(:,1),lowpass(SSLS_int.(['sta',num2str(stn)])(:,2)-SSLS_int.(['sta',num2str(stn)])(:,3),fti,fs,'Steepness',0.999999999),'linewidth', 3);hold on
%     plot(timed1,sshtime1,'linewidth', 3);hold on
    set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
    datetick('x','mmm-dd','keepticks')
%     set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);
    legend
    k=k+1;
end



%% vs USGS comparison

fs=1/(15*60);
fti=1/(24*60*60);

startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

%%%%%%%%%%%%%%%%% Matthew

clf
for stn=1:3
    
if stn==1
    lat_s = 32.1160833333333;
    lon_s = -81.1283333333333;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(ssh1(index_dist,:));

end

if stn==2
    
    lat_s = 32.1030555555556;
    lon_s = -81.0069444444444;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(ssh1(index_dist,:));
    
end

if stn==3
    lat_s = 31.45333333;
    lon_s = -81.36277778;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(ssh1(index_dist,:))-0.37;
end


figure(2)
subplot(3,1,stn)
plot(USGS_int.(sprintf('mtSTA_%d', stn))(:,1),USGS_int.(sprintf('mtSTA_%d', stn))(:,2),'linewidth', 3);hold on
plot(USGS_int.(sprintf('mtSTA_%d', stn))(:,1),USGS_int.(sprintf('mtSTA_%d', stn))(:,3),'linewidth', 3);hold on
plot(NOAA.mttide(:,1),NOAA.mttide(:,2),'linewidth', 3);hold on
% plot(USGS.(sprintf('mtSTA_%d', stn))(:,2),lowpass(USGS.(sprintf('mtSTA_%d', stn))(:,3),fti,fs,'Steepness',0.999999999),'linewidth', 3);hold on
% plot(USGS.(sprintf('mtSTA_%d', stn))(:,2),lowpass(USGS.(sprintf('mtSTA_%d', stn))(:,3)-USGS.(sprintf('mtSTA_%d', stn))(:,4),fti,fs,'Steepness',0.999999999),'linewidth', 3);hold on
% plot(USGS.(sprintf('mtSTA_%d', stn))(:,2),lowpass(USGS.(sprintf('mtSTA_%d', stn))(:,3),fti,fs,'Steepness',0.999999999)-lowpass(USGS.(sprintf('mtSTA_%d', stn))(:,3)-USGS.(sprintf('mtSTA_%d', stn))(:,4),fti,fs,'Steepness',0.999999999),'linewidth', 3);hold on
% plot(time1,sshtime1,'linewidth', 3);hold on
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
datetick('x','mmm-dd','keepticks')
% ylim([-2 3])
legend

end


%%%%%%%%%%%%%%%%% Dorian


fs=1/(15*60);
fti=1/(24*60*60);

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');
clf
for stn=1:3
    
if stn==1
    lat_s = 32.1160833333333;
    lon_s = -81.1283333333333;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:));

end

if stn==2
    
    lat_s = 32.1030555555556;
    lon_s = -81.0069444444444;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:));
    
end

if stn==3
    lat_s = 31.45333333;
    lon_s = -81.36277778;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:))-0.37;
end


figure(1)
subplot(3,1,stn)
plot(USGS.(sprintf('drSTA_%d', stn))(:,2),USGS.(sprintf('drSTA_%d', stn))(:,3),'linewidth', 3);hold on
plot(USGS.(sprintf('drSTA_%d', stn))(:,2),USGS.(sprintf('drSTA_%d', stn))(:,4),'linewidth', 3);hold on
plot(NOAA.drtide(:,1),NOAA.drtide(:,2),'linewidth', 3);hold on

% plot(USGS.(sprintf('drSTA_%d', stn))(:,2),lowpass(USGS.(sprintf('drSTA_%d', stn))(:,3),fti,fs,'Steepness',0.999999999),'linewidth', 3);hold on
% plot(USGS.(sprintf('drSTA_%d', stn))(:,2),lowpass(USGS.(sprintf('drSTA_%d', stn))(:,3)-USGS.(sprintf('drSTA_%d', stn))(:,4),fti,fs,'Steepness',0.999999999),'linewidth', 3);hold on
% plot(USGS.(sprintf('drSTA_%d', stn))(:,2),lowpass(USGS.(sprintf('drSTA_%d', stn))(:,3),fti,fs,'Steepness',0.999999999),'linewidth', 3);hold on
% plot(timed1,sshtime1,'linewidth', 3);hold on
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
datetick('x','mmm-dd','keepticks')
% ylim([-2 3])
legend

end

%% Each hurricane Plotting
fw=1;
fh=1;
ftsz=21;
ftszt=16;
xdt=24;
ftd=13;

fti=1/(24*60*60);
fw=1;
fh=1;
ftsz=21;
ftszt=16;

startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

h1=subplot(5,2,1);
fs=1/(6*60);
lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'-k','linewidth', 3);hold on
plot(NOAA.drtotal(:,1),lowpass(NOAA.drtotal(:,2)-NOAA.drtide(:,2),fti,fs,'Steepness',0.999999999),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);
datetick('x','mmm-dd','keepticks')
set(gca,'XTickLabel',[]);
title('Fort Pulaski Water Level Monitor','FontSize',ftszt)

legend('Mdl.','Obs.','Orientation','horizontal')

box on
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.3;
set(gcf,'color','w')
set(gca, 'FontSize', ftsz)


% Hutchinson Island Water Level Monitor

h2=subplot(5,2,2);
fs=1/(15*60);
stn=2;
lat_s = 32.1030555555556;
lon_s = -81.0069444444444;
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'k','linewidth', 3);hold on
plot(USGS.(sprintf('drSTA_%d', stn))(:,2),lowpass(USGS.(sprintf('drSTA_%d', stn))(:,3)-USGS.(sprintf('drSTA_%d', stn))(:,4),fti,fs,'Steepness',0.999999999),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:datenum(hours(xdt)):endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title('Hutchinson Island Water Level Monitor','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)

fs=1/(6*60);
h5=subplot(4,2,3);
stn=1; % 

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
%     
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'k','linewidth', 3);hold on
plot(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,1),lowpass(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,2)-SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,3),fti,fs,'Steepness',0.999999999),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);
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


h6=subplot(4,2,5);
stn=20;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
%     
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'k','linewidth', 3);hold on
plot(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,1),lowpass(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,2)-SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,3),fti,fs,'Steepness',0.999999999),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);
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

h7=subplot(4,2,4);
stn=11;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
%     
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'k','linewidth', 3);hold on
plot(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,1),lowpass(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,2)-SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,3),fti,fs,'Steepness',0.999999999),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);

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


h8=subplot(4,2,6);
stn=18;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
%     
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'k','linewidth', 3);hold on
plot(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,1),lowpass(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,2)-SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,3),fti,fs,'Steepness',0.999999999),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on

set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
% title(""+list(stn,1)+"",'FontSize',ftszt)
title('Savannah State Water Level Monitor','FontSize',ftszt)
set(gca,'XTickLabel',[]);
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h9=subplot(4,2,7);
stn=4;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
%     
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'k','linewidth', 3);hold on
plot(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,1),lowpass(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,2)-SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,3),fti,fs,'Steepness',0.999999999),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


h10=subplot(4,2,8);
stn=5;

lat_s = str2num(list(stn,2));
lon_s = str2num(list(stn,3));
%     
dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);
sshtime1=squeeze(sshd1(index_dist,:));

plot(timed1,sshtime1,'k','linewidth', 3);hold on
plot(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,1),lowpass(SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,2)-SSLS_int.(['sta',num2str(stn)])(10*24*4-12*10:end,3),fti,fs,'Steepness',0.999999999),'o','Color',[1 0.5 0],'MarkerFaceColor',[1 0.5 0]);hold on
set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/6:endDate]);
set(gca,'YLim',[-1 1.5],'YTick',[-1 0 1 2 3]);

datetick('x','mmm-dd','keepticks')
legend('Mdl.','Obs.','Orientation','horizontal')
grid on
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0.7;
title(""+list(stn,1)+"",'FontSize',ftszt)
set(gca,'FontSize',ftsz)
set(gcf,'color','w')


