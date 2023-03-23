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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-oc-0-at-0.nc'],'NC_NOWRITE');

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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-oc-0-at-0-wo-hydro.nc'],'NC_NOWRITE');

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


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide.nc'],'NC_NOWRITE');

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


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-wo-hydro.nc'],'NC_NOWRITE');

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
ssh4=field{10}.data;

refdate = datenum('2016-10-04 00:00:00');



%% Plotting


for its=58:1:168 %48, nt
            
    
    its
    timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'off');
        
    subplot(1,2,1)
    trisurf(element_index,lon,lat,ssh(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}w/ hydro: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 0.4]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)

    subplot(1,2,2)
    trisurf(element_index,lon,lat,ssh2(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}w/o hydro: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([0 0.4]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)
        
    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/HYDRO/M_fig_%d.png',its));

end



for its=58:1:168 %48, nt
            
    
    its
    timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'off');
        
    subplot(1,2,1)
    trisurf(element_index,lon,lat,ssh3(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}w/ hydro: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-1 1.5]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)

    subplot(1,2,2)
    trisurf(element_index,lon,lat,ssh4(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}w/o hydro: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-1 1.5]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)
        
    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/HYDRO/CH_fig_%d.png',its));

end




h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

subplot(1,3,1)
trisurf(element_index,lon,lat,max(ssh(:,:),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Ref.',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-1 1.5]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(1,3,2)
trisurf(element_index,lon,lat,max(ssh2(:,:),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Const. BC',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-0.5 0.5]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(1,3,3)
trisurf(element_index,lon,lat,max(ssh3(:,:),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Const. SP',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-0.5 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');



h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

subplot(1,3,1)
trisurf(element_index,lon,lat,min(ssh(:,:),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Ref.',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-1 1.5]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(1,3,2)
trisurf(element_index,lon,lat,min(ssh2(:,:),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Const. BC',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-0.5 0.5]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(1,3,3)
trisurf(element_index,lon,lat,min(ssh3(:,:),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Const. SP',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-0.5 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');




h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

clf
subplot(1,3,1)
trisurf(element_index,lon,lat,mean(ssh(:,1:168),2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Ref.',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-0.1 0.1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(1,3,2)
trisurf(element_index,lon,lat,mean(ssh2(:,1:168),2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Const. BC',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-0.2 0.2]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(1,3,3)
trisurf(element_index,lon,lat,mean(ssh3(:,1:168),2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}Const. SP',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-0.1 0.1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');




ssh4=ssh-(ssh2+ssh3);


% h=figure('units','normalized','position',[0 0 0.5 1]);
% set(h, 'Visible', 'on');

clf
trisurf(element_index,lon,lat,min(ssh4(:,49:168),[],2))
% trisurf(element_index,lon,lat,max(ssh4,[],2))

view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title('Minimum nonlinear interaction value','FontSize',22);
%title(['\color{blue}FC: ',timestamp],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([-0.3 0.300001]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');


