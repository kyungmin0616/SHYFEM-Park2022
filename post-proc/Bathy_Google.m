clc
close all
clear all

% Script custumized for SHYFEM unstructured-NetCDF outputs
% I. Federico
% starting from function plot_ounf_unstr(fname,tout)
% by
% --- WAVEWATCH III(R) Version 4.07 ---
% Script for plotting NetCDF field output on an unstructured mesh
% Andre van der Westhuysen, Dec 2012

%Read output files
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-ad.nc'],'NC_NOWRITE');



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
end;

fac = 1.0;

[nl nn nt]=size(field{9}.data)

% parameters for map
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;


min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;

depth=(field{7}.data);


depth1=depth;
depth1(depth1<5)=NaN;


startDate=-81.5;
endDate=-80.3;
%%
clear SLS desc list wl
SLS = importdata('/Users/kpark350/Ga_tech/Projects/DataSet/SSLS/Py/surveyed_sensors_export_isaias.csv');

desc = string(SLS.textdata(2:end,1));
list = unique(desc);
SLS.textdata(1,:)=[];

for i=1:length(list)
%     i=5
    lon_tmp=SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),2);
    lat_tmp=SLS.textdata(strcmp(string(SLS.textdata(:,1)),list(i)),3);
    
    list(i,2) = string(lon_tmp(1,1));
    list(i,3) = string(lat_tmp(1,1));
    
end

clear ssls
for i= 1:length(list)
    ssls(i,1) = str2num(list(i,3));
    ssls(i,2) = str2num(list(i,2));
end


ssls2=([-81.236375 31.995264;-81.238418 32.007320;-81.314744 32.062226;-81.010769 31.958661;...
     -81.021504 31.990396;-81.061556 31.889711;-80.962163 32.018171;-81.088157 31.840637;-80.994272  31.987188;
     -81.187966 32.172647;-81.084099 32.085707;-81.082003 32.023062;-81.210754 32.168133;-81.205440 32.063457;...
     -81.156335 32.164164;-81.203851 32.039975;-81.201916 31.791509]);

ssls=([ssls; ssls2]);

z(1:length(ssls),1)=100;

    
%%

axis([-81.45 -81 31.3 31.7]);
clear lonVec latVec imag
[lonVec latVec imag]=plot_google_map('MapType','satellite','Resize',2,'MapScale', 0,'AutoAxis',0,'Refresh',0,'ShowLabels',0);

axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)

save ggmap_sap2.mat lonVec latVec imag

%% Bathy

adj=0;
sz=200;

load ggmap_entire.mat
h_final= figure('units','normalized','position',[0 0 1 0.78]);
set(h_final, 'Visible', 'on');

clf
% subplot(1,2,1)
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)


trisurf(element_index,lon,lat,depth+adj); hold on
shading interp;   
% colormap(flipud(jet))
colormap(jet)

view(0,90);
% caxis([-22+adj 0+adj])
% caxis([0 25])
% caxis([-25 0])
hcb=colorbar;
% title(hcb,'Depth (m)')


%%%%%%%%%%%%%%%%%%%% Observations for Allianz %%%%%%%%%%%%%%%%%%%%
scatter3(ssls(:,1), ssls(:,2),z,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %SSLS
scatter3(-80.991889, 32.020471,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %Turner Creek Boat Ramp Sea Level Sensor
scatter3(-81.011631,  32.052507,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %Oatland Island Road environmental sensors
scatter3(-81.031204,  32.038669,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %Hwy 80 at Grays Creek Sea Level Sensor
scatter3(-81.063662,  32.000149,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %LaRoche Avenue at Nottingham Creek Sea Level Sensor
scatter3(-81.084020,  31.928350,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %Faye Drive on Burnside Island Sea Level Sensor
scatter3(-81.153906,  31.935783,100,sz,'filled','o','MarkerFaceColor','g',...
%     'MarkerEdgeColor','g'); %Coffee Bluff Marina environmental sensors

% 
% %%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
% % scatter3(ssls(:,1), ssls(:,2),z,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
% %     'MarkerEdgeColor',[1 0.5 0]); %SSLS
% % scatter3(-80.902494,    32.034550,100,sz,'filled','o','MarkerFaceColor','r',...
% %     'MarkerEdgeColor','r'); %Fort Pulaski
% % scatter3(-81.006944,     32.103056,100,sz,'filled','o','MarkerFaceColor','g',...
% %     'MarkerEdgeColor','g'); %USGS 0219897993
% % scatter3(-81.128333,     32.116083,100,sz,'filled','o','MarkerFaceColor','g',...
% %     'MarkerEdgeColor','g'); %USGS 021989715
% % scatter3(-81.362778,      31.453333,100,sz,'filled','o','MarkerFaceColor','g',...
% %     'MarkerEdgeColor','g'); %USGS 022035975
% scatter3(-80.991889, 32.020471,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
%     'MarkerEdgeColor',[1 0.5 0]); %Turner Creek Boat Ramp Sea Level Sensor
% scatter3(-81.011631,  32.052507,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
%     'MarkerEdgeColor',[1 0.5 0]); %Oatland Island Road environmental sensors
% scatter3(-81.031204,  32.038669,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
%     'MarkerEdgeColor',[1 0.5 0]); %Hwy 80 at Grays Creek Sea Level Sensor
% scatter3(-81.063662,  32.000149,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
%     'MarkerEdgeColor',[1 0.5 0]); %LaRoche Avenue at Nottingham Creek Sea Level Sensor
% scatter3(-81.084020,  31.928350,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
%     'MarkerEdgeColor',[1 0.5 0]); %Faye Drive on Burnside Island Sea Level Sensor
% scatter3(-81.153906,  31.935783,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
%     'MarkerEdgeColor',[1 0.5 0]); %Coffee Bluff Marina environmental sensors
% %%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%%%%%%%%% subset zoom-in %%%%%%%%%%%%%%%%%%%%
% rectangle('Position',[-81.17 31.85 0.42 0.3],'LineStyle','--','EdgeColor','w','LineWidth',3)
% rectangle('Position',[-81.45 31.35 0.42 0.28],'LineStyle','--','EdgeColor','w','LineWidth',3)
% %%%%%%%%%%%%%%%%%%%% subset zoom-in %%%%%%%%%%%%%%%%%%%%

axis([-81.5 -80.3 31.1 32.5]);
box on;
graph_handle= gca;
xticks(-81.5:0.2:80.)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.1:0.2:32.5)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
xlabel('Longitude')
ylabel('Latitude')

set(graph_handle,'fontsize', 26)
set(graph_handle,'linewidth', 1) 
set(gcf,'color','w')

% lon=1.2
% lat=1.4
sp_width= 0.3;
sp_height= 0.86;
x1 = 0.055;
y1 = 0.095;


set(graph_handle,'Position',[x1 y1 sp_width sp_height])

%% Sav city %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load ggmap_savcity.mat
% subplot(2,2,2)

figure(2)
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)

trisurf(element_index,lon,lat,depth); hold on
shading interp;   
caxis([0 25])
view(0,90);
axis([-81.17 -80.75 31.85 32.15]);

%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
scatter3(-80.959417, 32.034717,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
    'MarkerEdgeColor',[1 0.5 0]); %Bull River Marina
scatter3(-81.084020,  31.928350,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
    'MarkerEdgeColor',[1 0.5 0]); %Faye Drive on Burnside Island
scatter3(-81.084056,  31.951711,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
    'MarkerEdgeColor',[1 0.5 0]); %Diamond Causeway at Shipyard Creek
scatter3(-81.055977,   31.993082,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
    'MarkerEdgeColor',[1 0.5 0]); %Solomon Bridge
scatter3(-80.991889,   32.020471,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
    'MarkerEdgeColor',[1 0.5 0]); %Turner Creek Boat Ramp 
scatter3(-81.031204,   32.038669,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
    'MarkerEdgeColor',[1 0.5 0]); %Hwy 80 at Grays Creek
scatter3(-80.902494,    32.034550,100,sz,'filled','o','MarkerFaceColor','r',...
    'MarkerEdgeColor','r'); %Fort Pulaski
scatter3(-81.006944,     32.103056,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %USGS 0219897993
scatter3(-81.128333,     32.116083,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %USGS 021989715
%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%

box on;
graph_handle= gca;
set(graph_handle,'linewidth', 1)  
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);

% lon=0.42
% lat=0.3
fc=2.2;
sp_width= 0.42/4*fc;
sp_height= 0.3/(1.4/0.86)*fc;
x1 = 0.45;
y1 = 0.55;

set(graph_handle,'Position',[x1 y1 sp_width sp_height])

%% Sap Island %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load ggmap_sap.mat
subplot(2,2,4)

axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)

trisurf(element_index,lon,lat,depth); hold on
shading interp;   
caxis([0 25])
view(0,90);
axis([-81.45 -81.03 31.35 31.63]);
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);

%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
scatter3(-81.362778,      31.453333,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %USGS 022035975
%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%

graph_handle= gca;

% lon=0.42
% lat=0.28
fc=2.2;
sp_width= 0.42/4*fc;
sp_height= 0.3/(1.4/0.86)*fc;
x1 = 0.45;
y1 = 0.05;

set(graph_handle,'Position',[x1 y1 sp_width sp_height])


saveas(h_final,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/bathy_google_2.png'));


%%

%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
scatter3(-80.991889, 32.020471,100,sz,'filled','o','MarkerFaceColor',[1 0.5 0],...
    'MarkerEdgeColor','y'); %Turner Creek Boat Ramp Sea Level Sensor
scatter3(-81.011631,  32.052507,100,sz,'filled','o','MarkerFaceColor','y',...
    'MarkerEdgeColor','y'); %Oatland Island Road environmental sensors
scatter3(-81.031204,  32.038669,100,sz,'filled','o','MarkerFaceColor','y',...
    'MarkerEdgeColor','y'); %Hwy 80 at Grays Creek Sea Level Sensor
scatter3(-81.063662,  32.000149,100,sz,'filled','o','MarkerFaceColor','y',...
    'MarkerEdgeColor','y'); %LaRoche Avenue at Nottingham Creek Sea Level Sensor
scatter3(-81.084020,  31.928350,100,sz,'filled','o','MarkerFaceColor','y',...
    'MarkerEdgeColor','y'); %Faye Drive on Burnside Island Sea Level Sensor
scatter3(-81.153906,  31.935783,100,sz,'filled','o','MarkerFaceColor','y',...
    'MarkerEdgeColor','y'); %Coffee Bluff Marina environmental sensors
% scatter3(-80.850964,   32.018310,100,sz,'filled','o','MarkerFaceColor','y',...
%     'MarkerEdgeColor','y'); %Hwy 80 at Chimney Creek on Tybee Island Sea Level Sensor
scatter3(-80.902494,    32.034550,100,sz,'filled','o','MarkerFaceColor','r',...
    'MarkerEdgeColor','r'); %Fort Pulaski
scatter3(-81.006944,     32.103056,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %USGS 0219897993
scatter3(-81.128333,     32.116083,100,sz,'filled','o','MarkerFaceColor','g',...
    'MarkerEdgeColor','g'); %USGS 021989715
%%%%%%%%%%%%%%%%%%%% Observations %%%%%%%%%%%%%%%%%%%%
