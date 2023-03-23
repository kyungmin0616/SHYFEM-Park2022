

offdate = datenum(hours(4));

%% USGS

clear SLS desc list wl SSLS
SLS = readtable('/Users/kpark350/Ga_tech/Projects/DataSet/SSLS/Py/hurricane_dorian.csv');

desc = string(SLS.Var1(2:end,1));
list = unique(desc);
SLS.textdata(1,:)=[];


for i=1:length(list)

    lon_tmp=SLS.Var1(strcmp(string(SLS.Var1(:,1)),list(i)),2);
    lat_tmp=SLS.Var1(strcmp(string(SLS.Var1(:,1)),list(i)),3);
    
    list(i,2) = string(lon_tmp(1,1));
    list(i,3) = string(lat_tmp(1,1));
    
    SSLS.(['sta',num2str(i)])(:,1)=datenum(string(SLS.Var1(strcmp(string(SLS.Var1(:,1)),list(i)),4)),'yyyy-mm-dd HH:MM:SS')+offdate; %NEW VER
    SSLS.(['sta',num2str(i)])(:,2)=SLS.data(strcmp(string(SLS.Var1(:,1)),list(i)),1)*0.3048;
    SSLS.(['sta',num2str(i)])(:,3)=SLS.data(strcmp(string(SLS.Var1(:,1)),list(i)),2)*0.3048;
    clear lon_tmp lat_tmp
    
  
    
end


%% USGS

clear USGS
files = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Matthew');
files(1:3)=[];
files(end)=[];

files2 = dir('/Users/kpark350/Ga_tech/Projects/DataSet/USGS/WaterLevel/Dorian');
files2(1:3)=[];

%%%%%%%%%% Matthew %%%%%%%%%%%

clear WL_MT
for i = 1:length(files)
    
  temp=readtable([files(i).folder '/' files(i).name]);
  
  USGS.(sprintf('mtSTA_%d', i))(:,2) = datenum(table2array(temp(:,3)))+offdate;
  USGS.(sprintf('mtSTA_%d', i))(:,3) = table2array(temp(:,5)).*0.3048;
  USGS.(sprintf('mtSTA_%d', i))(:,1) = table2array(temp(:,2));

  clear temp
  
end

%%%%%%%%%% Dorian %%%%%%%%%%%

clear WL_DR
for i = 1:length(files2)
    
  temp=readtable([files2(i).folder '/' files2(i).name]);
  
  USGS.(sprintf('drSTA_%d', i))(:,2) = datenum(table2array(temp(:,3)))+offdate;
  USGS.(sprintf('drSTA_%d', i))(:,3) = table2array(temp(:,5)).*0.3048;
  USGS.(sprintf('drSTA_%d', i))(:,1) = table2array(temp(:,2));

  clear temp
  
end


%% NOAA


%%%%%%%%%% Matthew %%%%%%%%%%%

clear GA_I 
%%%%%%%%%% Observation %%%%%%%%%%%
GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/NAVD/GA_WL_MATTHEW.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.mttime=datenum(strcat(date1,{' '},date2));
NOAA.mttotal = table2array(GA_I(:,5))+0.0710-0.0710;
NOAA.mttide = table2array(GA_I(:,3))+0.0710-0.0710;


%%%%%%%%%% Dorian %%%%%%%%%%%
clear GA_I

GA_I=readtable('/Users/kpark350/Ga_tech/Projects/DataSet/NOAA/TideGauge/MHHW/GA_WL_DORIAN.csv');
date1=table2array(GA_I(:,1));
date2=table2array(GA_I(:,2));
NOAA.drtime=datenum(strcat(date1,{' '},date2));
NOAA.drtotal = table2array(GA_I(:,5))+1.1230-0.0710;
NOAA.drtide = table2array(GA_I(:,3))+1.1230-0.0710;


