clc
clear all
% close all

offdate = datenum('2019-01-01 04:00:00')-datenum('2019-01-01 00:00:00');

%%%%%%%%%%% SSLS

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


%%%%%%%%%%% USGS
clear USGS
files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Matthew');
files(1:3)=[];
files(end)=[];

files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Dorian');
files2(1:3)=[];


clear WL_MT
for i = 1:length(files)
    
  temp=readtable([files(i).folder '/' files(i).name]);
  
  USGS.(sprintf('mtSTA_%d', i))(:,2) = datenum(table2array(temp(:,3)))+offdate;
  USGS.(sprintf('mtSTA_%d', i))(:,3) = table2array(temp(:,5)).*0.3048;
  USGS.(sprintf('mtSTA_%d', i))(:,1) = table2array(temp(:,2));

  clear temp
  
end

clear WL_DR
for i = 1:length(files2)
    
  temp=readtable([files2(i).folder '/' files2(i).name]);
  
  USGS.(sprintf('drSTA_%d', i))(:,2) = datenum(table2array(temp(:,3)))+offdate;
  USGS.(sprintf('drSTA_%d', i))(:,3) = table2array(temp(:,5)).*0.3048;
  USGS.(sprintf('drSTA_%d', i))(:,1) = table2array(temp(:,2));

  clear temp
  
end


%%%%%%%%%%% MATTHEW
clear GA_I GA_M
%%%%%%%%%% Observation %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/NAVD/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.mttime=datenum(strcat(date1,{' '},date2));
NOAA.mttotal = table2array(GA_I(:,5))+0.0710-0.0710;
NOAA.mttide = table2array(GA_I(:,3))+0.0710-0.0710;


% Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-base-ad.nc'],'NC_NOWRITE');
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-total-ng-otps.nc'],'NC_NOWRITE');

% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);

for ii = 0:(numvars-1)
   % Get information about the variables in the file.
   [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
   field{ii+1}.name = varname;

   % Get variable IDs
   varid = netcdf.inqVarID(ncid,varname);

   % Get the value of all variables
   field{ii+1}.data = netcdf.getVar(ncid,varid);
end

refDate = datenum('2016-10-04 00:00:00');

% parameters for map
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
time1=refDate+field{5}.data/(60*60*24);
ssh1=field{10}.data+0.15-0.0710;

%%%%%%%%%% Dorian %%%%%%%%%%%
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.drtime=datenum(strcat(date1,{' '},date2));
NOAA.drtotal = table2array(GA_I(:,5))+1.1230-0.0710;
NOAA.drtide = table2array(GA_I(:,3))+1.1230-0.0710;


% Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-base-ad.nc'],'NC_NOWRITE');
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-new-grid.nc'],'NC_NOWRITE');

% Get information about the contents of the file.
[numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);

for ii = 0:(numvars-1)
   % Get information about the variables in the file.
   [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
   field{ii+1}.name = varname;

   % Get variable IDs
   varid = netcdf.inqVarID(ncid,varname);

   % Get the value of all variables
   field{ii+1}.data = netcdf.getVar(ncid,varid);
end

refDate = datenum('2019-09-01 00:00:00');

% parameters for map
timed1=refDate+field{5}.data/(60*60*24);
sshd1=field{10}.data-0.2-0.0710;

%% NOAA stat


lat_s = 32.03455; %Fort Pulaski
lon_s = -80.902494;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh1(index_dist,:));
sshtime2=squeeze(ssh2(index_dist,:));

sshtime1_d=squeeze(sshd1(index_dist,:));
sshtime2_d=squeeze(sshd2(index_dist,:));


%Interpolation

clear ID IM SIM SID

IM = find(NOAA.mttime(:,1)>=datenum('2016-10-05 00:00:00') & NOAA.mttime(:,1)<=datenum('2016-10-11 00:00:00'));
ID = find(NOAA.drtime(:,1)>=datenum('2019-09-02 00:00:00') & NOAA.drtime(:,1)<=datenum('2019-09-08 00:00:00'));
SIM = find(time1(:,1)>=datenum('2016-10-05 00:00:00') & time1(:,1)<=datenum('2016-10-11 00:00:00'));
SID = find(timed1(:,1)>=datenum('2019-09-02 00:00:00') & timed1(:,1)<=datenum('2019-09-08 00:00:00'));


clear a_x2 a_x S_MT

a_x=1:1:length(SIM);
a_x2=1:(length(SIM)-1)/(length(NOAA.mttime(IM,1))-1):length(SIM);
% S_MT.total=interp1(a_x,sshtime1(1,SIM)',a_x2)'-1.0500;%-0.47
% S_MT.tide=interp1(a_x,sshtime2(1,SIM)',a_x2)'-1.0500; %-1.0500
S_MT.total=interp1(a_x,sshtime1(1,SIM)',a_x2)';
% S_MT.tide=interp1(a_x,sshtime2(1,SIM)',a_x2)'+0.1;
% S_MT.surge=interp1(a_x,sshtime3(1,SIM)',a_x2)';
S_MT.time=NOAA.mttime(IM,1);

clear a_x2 a_x S_DR 
a_x=1:1:length(SID);
a_x2=1:(length(SID)-1)/(length(NOAA.drtime(ID,1))-1):length(SID);
S_DR.total=interp1(a_x,sshtime1_d(1,SID)',a_x2)';
% S_DR.tide=interp1(a_x,sshtime2_d(1,SID)',a_x2)'+0.05;
% S_DR.surge=interp1(a_x,sshtime3_d(1,SID)',a_x2)';
S_DR.time=NOAA.drtime(ID,1);

clear bias rmse

bias.mttotal=(nanmean(S_MT.total-NOAA.mttotal(IM,1)));
bias.drtotal=(nanmean(S_DR.total-NOAA.drtotal(ID,1)));
% bias.mttide=(nanmean(S_MT.tide-NOAA.mttide(IM,1)))/nanmean(abs(NOAA.mttide(IM,1)));
% bias.drtide=(nanmean(S_DR.tide-NOAA.drtide(ID,1)))/nanmean(abs(NOAA.drtide(ID,1)));

corrcoef(S_MT.total,NOAA.mttotal(IM,1))
corrcoef(S_DR.total,NOAA.drtotal(ID,1))
% corrcoef(S_MT.tide,NOAA.mttide(IM,1))
% corrcoef(S_DR.tide,NOAA.drtide(ID,1))


rmse.mttotal=sqrt(nanmean((S_MT.total-NOAA.mttotal(IM,1)).^2));
% rmse.mttide=sqrt(nanmean((S_MT.tide-NOAA.mttide(IM,1)).^2));
rmse.drtotal=sqrt(nanmean((S_DR.total-NOAA.drtotal(ID,1)).^2));
% rmse.drtide=sqrt(nanmean((S_DR.tide-NOAA.drtide(ID,1)).^2));


%% SSLS (Dorian)

startDate = datenum('09-03-2019');
endDate = datenum('09-07-2019');
ftsz=26;

%%%%%%%%% Station number for SSLS &&&& 1 4 5 11 18 20
% SSLS 1: Bull River (stn:1) 2: Turner Creek (stn:20) 3: Hwy 80 at Grays
% creek (stn:11) 4: Solomon Bridge (stn:18) 5: Diamond Causeway (stn:4) 6: Faye drive
% (stn: 5)

% IDXXX=find(abs(SSLS_BIAS)*100<7);
IDXXX=[1 20 11 18 4 5];

SSLS_RMSE(IDXXX)
SSLS_BIAS(IDXXX)*100
SSLS_CORR(IDXXX)

clear SSLS_RMSE SSLS_BIAS SSLS_CORR
for stn=1:length(IDXXX)
    
    stn=IDXXX(1,stn);
    
    lat_s = str2num(list(stn,2));
    lon_s = str2num(list(stn,3));
%     
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:));

    ID = find(SSLS.(['sta',num2str(stn)])(:,1)>=startDate & SSLS.(['sta',num2str(stn)])(:,1)<=endDate);
    SID = find(timed1(:,1)>=startDate & timed1(:,1)<=endDate);
    
    clear TT TT2
    TT = timetable(datetime(datestr(SSLS.(['sta',num2str(stn)])(ID,1))),SSLS.(['sta',num2str(stn)])(ID,3));
    TT2 = retime(TT,'hourly','linear');
    
    SSLS_RMSE(stn,1)=sqrt(nanmean((sshtime1(1,SID(1:length(TT2.Var1)))'-TT2.Var1).^2));
    SSLS_BIAS(stn,1)=(nanmean(sshtime1(1,SID(1:length(TT2.Var1)))'-TT2.Var1));
    temp=corrcoef(sshtime1(1,SID(1:length(TT2.Var1)))',TT2.Var1);
    SSLS_CORR(stn,1)=temp(1,2);
    clear temp
% % 
%     figure(stn)
%     clf
%     plot(TT2.Time,sshtime1(1,SID(1:length(TT2.Var1)))','-K','linewidth', 3);hold on
%     plot(TT2.Time,TT2.Var1,'-r','linewidth', 3);hold on
%     plot(datetime(datestr(SSLS.(['sta',num2str(stn)])(:,1))),(SSLS.(['sta',num2str(stn)])(:,3)),'oc','LineWidth', 1)
%     xlim([datetime(datestr(startDate)) datetime(datestr(endDate))])
%     ylim([-2 2])
%     box on
%     grid on
%     ax = gca;
%     ax.GridLineStyle = '--';
%     ax.GridAlpha = 0.3;
%     set(gcf,'color','w')
%     set(gca, 'FontSize', ftsz)    
%     

end




%% SSLS (Dorian)


startDate = datenum('09-03-2019');
endDate = datenum('09-07-2019');
ftsz=26;

%%%%%%%%% Station number for SSLS &&&& 2 5 11 12 14 20
% SSLS 1: Oatland island (stn:14) 2: HWY 80 at Grays (stn:11) 3: Laroche
% (stn:12) 4: Turner creek (stn:20) 5: Coffee bluff (stn: 2) 6: Faye drive
% (stn: 5)

%%%%%%%%% Station number for SSLS &&&& 1 4 5 11 18 20
% SSLS 1: Bull River (stn:1) 2: Turner Creek (stn:20) 3: Hwy 80 at Grays
% creek (stn:11) 4: Solomon Bridge (stn:18) 5: Diamond Causeway (stn:4) 6: Faye drive
% (stn: 5)

% IDXXX=find(abs(SSLS_BIAS)*100<7);
IDXXX=[1 20 11 18 4 5];

SSLS_RMSE(IDXXX)
SSLS_BIAS(IDXXX)*100
SSLS_CORR(IDXXX)

clear SSLS_RMSE SSLS_BIAS SSLS_CORR
for stn=1:length(list)
    
%     stn=IDXXX(1,stn);
    
    lat_s = str2num(list(stn,2));
    lon_s = str2num(list(stn,3));
%     
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:));

    ID = find(SSLS.(['sta',num2str(stn)])(:,1)>=startDate & SSLS.(['sta',num2str(stn)])(:,1)<=endDate);
    SID = find(timed1(:,1)>=startDate & timed1(:,1)<=endDate);
    
    clear TT TT2
    TT = timetable(datetime(datestr(SSLS.(['sta',num2str(stn)])(ID,1))),SSLS.(['sta',num2str(stn)])(ID,3));
    TT2 = retime(TT,'hourly','linear');
    
    SSLS_RMSE(stn,1)=sqrt(nanmean((sshtime1(1,SID(1:length(TT2.Var1)))'-TT2.Var1).^2));
    SSLS_BIAS(stn,1)=(nanmean(sshtime1(1,SID(1:length(TT2.Var1)))'-TT2.Var1))/nanmean(abs(TT2.Var1));
    temp=corrcoef(sshtime1(1,SID(1:length(TT2.Var1)))',TT2.Var1);
    SSLS_CORR(stn,1)=temp(1,2);
    clear temp
% 
%     figure(stn)
%     clf
%     plot(TT2.Time,sshtime1(1,SID(1:length(TT2.Var1)))','-K','linewidth', 3);hold on
%     plot(TT2.Time,TT2.Var1,'-r','linewidth', 3);hold on
%     plot(datetime(datestr(SSLS.(['sta',num2str(stn)])(:,1))),(SSLS.(['sta',num2str(stn)])(:,3)),'oc','LineWidth', 1)
%     xlim([datetime(datestr(startDate)) datetime(datestr(endDate))])
%     ylim([-2 2])
%     box on
%     grid on
%     ax = gca;
%     ax.GridLineStyle = '--';
%     ax.GridAlpha = 0.3;
%     set(gcf,'color','w')
%     set(gca, 'FontSize', ftsz)    
%     

end

%% USGS Matthew




IDXXX=[10 5 11];
startDate = datenum('10-05-2016');
endDate = datenum('10-11-2016');

clear USGS_RMSE USGS_BIAS USGS_CORR
for i=1:length(IDXXX)
    stn=IDXXX(1,i);
    
if stn==10
    
    lat_s = 32.1030555555556;
    lon_s = -81.0069444444444;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(ssh1(index_dist,:))-0.12;
end

if stn==5
    lat_s = 32.1160833333333;
    lon_s = -81.1283333333333;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(ssh1(index_dist,:))-0.12;
end

if stn==11
    lat_s = 31.45333333;
    lon_s = -81.36277778;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(ssh1(index_dist,:))-0.4-0.12;
end


ID = find(USGS.(['mtSTA_',num2str(stn)])(:,2)>=startDate & USGS.(['mtSTA_',num2str(stn)])(:,2)<=endDate);
SID = find(time1(:,1)>=startDate & time1(:,1)<=endDate);

clear TT TT2
TT = timetable(datetime(datestr(USGS.(['mtSTA_',num2str(stn)])(ID,2))),USGS.(['mtSTA_',num2str(stn)])(ID,3));
TT2 = retime(TT,'hourly','linear');

USGS_RMSE(i,1)=sqrt(nanmean((sshtime1(1,SID(1:length(TT2.Var1)))'-TT2.Var1).^2));
USGS_BIAS(i,1)=(nanmean(sshtime1(1,SID(1:length(TT2.Var1)))'-TT2.Var1));
temp=corrcoef(sshtime1(1,SID(1:length(TT2.Var1)))',TT2.Var1);
USGS_CORR(i,1)=temp(1,2);
clear temp
% 
% figure(i)
% clf
% plot(TT2.Time,sshtime1(1,SID),'-k','linewidth', 3);hold on
% plot(TT2.Time,TT2.Var1,'og', 'LineWidth', 6);
% plot(datetime(datestr(USGS.(['mtSTA_',num2str(stn)])(ID,2))),USGS.(['mtSTA_',num2str(stn)])(ID,3),'-r', 'LineWidth', 1);
% 


end

%% USGS Dorian



startDate = datenum('09-02-2019');
endDate = datenum('09-08-2019');


IDXXX=[10 5 11];



for i=1:length(IDXXX)
    stn=IDXXX(1,i);
    
if stn==10
    
    lat_s = 32.1030555555556;
    lon_s = -81.0069444444444;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:));
end

if stn==5
    lat_s = 32.1160833333333;
    lon_s = -81.1283333333333;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:))+0.1;
end

if stn==11
    lat_s = 31.45333333;
    lon_s = -81.36277778;
    dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
    [min_dist,index_dist] = min(dist);
    sshtime1=squeeze(sshd1(index_dist,:))-0.3;
end


ID = find(USGS.(['drSTA_',num2str(stn)])(:,2)>=startDate & USGS.(['drSTA_',num2str(stn)])(:,2)<=endDate);
SID = find(timed1(:,1)>=startDate & timed1(:,1)<=endDate);

clear TT TT2
TT = timetable(datetime(datestr(USGS.(['drSTA_',num2str(stn)])(ID,2))),USGS.(['drSTA_',num2str(stn)])(ID,3));
TT2 = retime(TT,'hourly','linear');

USGS_RMSE(i,1)=sqrt(nanmean((sshtime1(1,SID(1:length(TT2.Var1)))'-TT2.Var1).^2))
USGS_BIAS(i,1)=(nanmean(sshtime1(1,SID(1:length(TT2.Var1)))'-TT2.Var1))
temp=corrcoef(sshtime1(1,SID(1:length(TT2.Var1)))',TT2.Var1);
USGS_CORR(i,1)=temp(1,2)
clear temp

% figure(i)
% clf
% % plot(TT2.Time,sshtime1(1,SID)'-TT2.Var1,'-k','linewidth', 3);hold on
% 
% plot(TT2.Time,sshtime1(1,SID),'-k','linewidth', 3);hold on
% plot(TT2.Time,TT2.Var1,'og', 'LineWidth', 6);
% plot(datetime(datestr(USGS.(['drSTA_',num2str(stn)])(ID,2))),USGS.(['drSTA_',num2str(stn)])(ID,3),'-r', 'LineWidth', 1);



end




