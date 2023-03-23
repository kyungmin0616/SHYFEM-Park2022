clc
% close all
clear all

% Script custumized for SHYFEM unstructured-NetCDF outputs
% I. Federico
% starting from function plot_ounf_unstr(fname,tout)
% by
% --- WAVEWATCH III(R) Version 4.07 ---
% Script for plotting NetCDF field output on an unstructured mesh
% Andre van der Westhuysen, Dec 2012

%% Matthew

%Read output files

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-at-dv-local.nc'],'NC_NOWRITE');

%il = 1;    % select layer_id for map plot
%ik = 70500; % select node_id for profile plot
%it = 1;    % select time_id for profile plot

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

fac = 1.0;

[nl nn nt]=size(field{9}.data)

% parameters for map
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
bathy=field{9}.data;

min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;
ssh=field{10}.data;
depth=-field{9}.data;

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-at-dv-wind.nc'],'NC_NOWRITE');

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
ssh2=field{10}.data;


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-at-dv-slp.nc'],'NC_NOWRITE');

%il = 1;    % select layer_id for map plot
%ik = 70500; % select node_id for profile plot
%it = 1;    % select time_id for profile plot

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
ssh3=field{10}.data;

% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-hy-dv-v2.nc'],'NC_NOWRITE');
% 
% %il = 1;    % select layer_id for map plot
% %ik = 70500; % select node_id for profile plot
% %it = 1;    % select time_id for profile plot
% 
% % Get information about the contents of the file.
% [numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
% 
% for ii = 0:(numvars-1)
%    % Get information about the variables in the file.
%    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
%    field{ii+1}.name = varname;
% 
%    % Get variable IDs
%    varid = netcdf.inqVarID(ncid,varname);
% 
%    % Get the value of all variables
%    field{ii+1}.data = netcdf.getVar(ncid,varid);
% end
% ssh4=field{10}.data;
% u4=squeeze(field{8}.data);
% v4=squeeze(field{9}.data);
% 
refdate = datenum('2016-10-04 00:00:00');

%% Dorian

% clear
% clc

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-at-dv-local.nc'],'NC_NOWRITE');

%il = 1;    % select layer_id for map plot
%ik = 70500; % select node_id for profile plot
%it = 1;    % select time_id for profile plot

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

% fac = 1.0;
% 
% [nl nn nt]=size(field{9}.data)

% parameters for map
% element_index=field{1}.data(1:3,:)';
% lon=field{4}.data;
% lat=field{2}.data;
% bathy=field{9}.data;
% 
% min_lon=min(lon)-0.03;
% max_lon=max(lon)+0.03;
% min_lat=min(lat)-0.03;
% max_lat=max(lat)+0.03;
sshd=field{10}.data;
% depth=-field{9}.data;

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-at-dv-wind.nc'],'NC_NOWRITE');

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
sshd2=field{10}.data;


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-at-dv-slp.nc'],'NC_NOWRITE');

%il = 1;    % select layer_id for map plot
%ik = 70500; % select node_id for profile plot
%it = 1;    % select time_id for profile plot

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
sshd3=field{10}.data;


% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-hy-dv-v2.nc'],'NC_NOWRITE');
% 
% %il = 1;    % select layer_id for map plot
% %ik = 70500; % select node_id for profile plot
% %it = 1;    % select time_id for profile plot
% 
% % Get information about the contents of the file.
% [numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid);
% 
% for ii = 0:(numvars-1)
%    % Get information about the variables in the file.
%    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid,ii);
%    field{ii+1}.name = varname;
% 
%    % Get variable IDs
%    varid = netcdf.inqVarID(ncid,varname);
% 
%    % Get the value of all variables
%    field{ii+1}.data = netcdf.getVar(ncid,varid);
% end
% ssh4d=field{10}.data;
% u4d=squeeze(field{8}.data);
% v4d=squeeze(field{9}.data);

refdate2 = datenum('2019-09-01 00:00:00');

%% Plotting


for its=25:1:73 %48, nt
            
    
    its

    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'off');

    
    timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');
    timestamp2=datestr(refdate2+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

    subplot(2,3,1)
    trisurf(element_index,lon,lat,ssh(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}MT-local:',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-0.5 1]);
    % caxis([0 1]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)
    
    subplot(2,3,2)
    trisurf(element_index,lon,lat,ssh2(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}MT-wind:',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-0.5 1]);
    % caxis([0 1]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)
    
    subplot(2,3,3)
    trisurf(element_index,lon,lat,ssh3(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}MT-slp:',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-0.3 0.3]);
    % caxis([0 1]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)
    
    subplot(2,3,4)
    trisurf(element_index,lon,lat,sshd(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}DR-local:',timestamp2],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-0.5 1]);
    % caxis([0 1]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)
    
    subplot(2,3,5)
    trisurf(element_index,lon,lat,sshd2(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}DR-wind:',timestamp2],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-0.5 1]);
    % caxis([0 1]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)
    
    subplot(2,3,6)
    trisurf(element_index,lon,lat,sshd3(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}DR-slp:',timestamp2],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-0.3 0.3]);
    % caxis([0 1]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)
    
    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/STORM/fig_%d.png',its));

end



for its=25:1:115 %48, nt
            
    
    its

    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'off');

    
    timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');
    subplot(2,3,1)
    trisurf(element_index,lon,lat,ssh(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}MT-ref',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 1.6]);
    % caxis([0 1]);

    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)

    subplot(2,3,2)
    trisurf(element_index,lon,lat,ssh2(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}MT-local',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 1.6]);
    % caxis([0 1]);

    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)

    subplot(2,3,3)
    trisurf(element_index,lon,lat,ssh3(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}MT-remote',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 .2]);
    % caxis([0 1]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)
    set(gcf,'color','w');

    timestamp2=datestr(refdate2+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

    subplot(2,3,4)
    trisurf(element_index,lon,lat,sshd(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}MT-ref',timestamp2],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 1.]);
    % caxis([0 1]);

    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)

    subplot(2,3,5)
    trisurf(element_index,lon,lat,sshd2(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}MT-local',timestamp2],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 1.]);
    % caxis([0 1]);

    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)

    subplot(2,3,6)
    trisurf(element_index,lon,lat,sshd3(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}MT-remote',timestamp2],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 .2]);
    % caxis([0 1]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 24)
    set(graph_handle,'linewidth', 1)
    set(gcf,'color','w');

    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'off');
        
    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/STORM/fig_%d.png',its));

end


%%%%%%%%%vel

for its=25:1:144 %48, nt
            
    
    its
    timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');
    timestamp2=datestr(refdate2+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'off');
        
    subplot(1,2,1)
    trisurf(element_index,lon,lat,sqrt(u4(:,its).^2+v4(:,its).^2))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}Ref: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 0.5]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)

    subplot(1,2,2)
    trisurf(element_index,lon,lat,sqrt(u4d(:,its).^2+v4d(:,its).^2))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}At-dv: ',timestamp2],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 0.5]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)
    
    
    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/STORM/Vel_fig_%d.png',its));

end
%%


%%%%%%%%%% Maximum water level for each driver

h=figure('units','normalized','position',[0 0 0.6 1]);
set(h, 'Visible', 'on');

stt=25;
edt=115;

clf
subplot(3,3,1)
trisurf(element_index,lon,lat,max(ssh(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-local',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0 1.6]);
% caxis([0 1]);

hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

subplot(3,3,2)
trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-wind',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0 1.6]);
% caxis([0 1]);

hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

subplot(3,3,3)
trisurf(element_index,lon,lat,max(ssh3(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-slp',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0 .2]);
% caxis([0 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');


subplot(3,3,4)
trisurf(element_index,lon,lat,max(sshd(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-local',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0 1.]);
% caxis([0 1]);

hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

subplot(3,3,5)
trisurf(element_index,lon,lat,max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-wind',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0 1.]);
% caxis([0 1]);

hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

subplot(3,3,6)
trisurf(element_index,lon,lat,max(sshd3(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-slp',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0 .2]);
% caxis([0 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');


subplot(3,3,7)
trisurf(element_index,lon,lat,max(ssh(:,stt:edt),[],2)-max(sshd(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Diff.-local',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
% caxis([0 1.1]);
% caxis([0 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

subplot(3,3,8)
trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2)-max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Diff.-wind',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
% caxis([0 1.1]);
% caxis([0 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

subplot(3,3,9)
trisurf(element_index,lon,lat,max(ssh3(:,stt:edt),[],2)-max(sshd3(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Diff.-slp',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
% caxis([-0.01 0.01]);
% caxis([0 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');




