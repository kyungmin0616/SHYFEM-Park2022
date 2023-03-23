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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-ref.nc'],'NC_NOWRITE');

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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-6h-tide.nc'],'NC_NOWRITE');

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


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-12h-tide.nc'],'NC_NOWRITE');

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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-18h-tide.nc'],'NC_NOWRITE');

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
u4=squeeze(field{8}.data);
v4=squeeze(field{9}.data);
% 
refdate = datenum('2016-10-04 00:00:00');

%% Dorian

% clear
% clc

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-ref.nc'],'NC_NOWRITE');

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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-6h-tide.nc'],'NC_NOWRITE');

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


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-12h-tide.nc'],'NC_NOWRITE');

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


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-18h-tide.nc'],'NC_NOWRITE');

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
sshd4=field{10}.data;
u4d=squeeze(field{8}.data);
v4d=squeeze(field{9}.data);

refdate2 = datenum('2019-09-01 00:00:00');

%% Plotting


for its=49:1:144 %48, nt
            
    
    its
    timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'off');
        
    trisurf(element_index,lon,lat,ssh(:,its)-(ssh2(:,its)+ssh3(:,its)))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}Ref.: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-0.4 0.4]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)

    
    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/STORM/res_fig_%d.png',its));

end


    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'on');
        
    trisurf(element_index,lon,lat,var(ssh(:,49:1:144)-(ssh2(:,49:1:144)+ssh3(:,49:1:144)),0,2))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}Ref.: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
%     caxis([-0.4 0.4]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)
    
    

for its=49:1:144 %48, nt
            
    
    its
    timestamp=datestr(refdate2+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'off');
        
    subplot(1,3,1)
    trisurf(element_index,lon,lat,ssh(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}Ref.: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-.7 1.1]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)

    subplot(1,3,2)
    trisurf(element_index,lon,lat,ssh2(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}AD: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-1 0.7]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)
    
    subplot(1,3,3)
    trisurf(element_index,lon,lat,ssh3(:,its))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}OD: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-0.3 0.7]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)
    
%     subplot(1,4,4)
%     trisurf(element_index,lon,lat,ssh4(:,its))
%     view(0,90);shading interp;     
%     colormap(getpmap(7));
%     %            colorbar;axis equal
%     title(['\color{black}Hy-dv: ',timestamp],'FontSize',22);
%     %            xlabel('Longitude (deg)','FontSize',22);
%     %            ylabel('Latitude (deg)','FontSize',22);
%     axis([min_lon max_lon min_lat max_lat]);
%     %            axis([-81.2 -80.8 32 32.3]);
%     caxis([0 0.5]);
%     hcb=colorbar;
%     title(hcb,'m','fontsize', 12)
%     box on;
%     grid on;
%     graph_handle= gca;
%     set(graph_handle,'fontsize', 18)
%     set(graph_handle,'linewidth', 1)
    
    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/STORM/M_fig_%d.png',its));

end


for its=25:1:144 %48, nt
            
    
    its
    timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');
    timestamp2=datestr(refdate2+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

    h=figure('units','normalized','position',[0 0 1 1]);
    set(h, 'Visible', 'off');
        
    subplot(1,2,1)
    trisurf(element_index,lon,lat,ssh4(:,its))
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
    trisurf(element_index,lon,lat,ssh4d(:,its))
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
    
    
    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/STORM/M_fig_%d.png',its));

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
%%%%%%%%% MAX

h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');


clf
subplot(2,4,1)
trisurf(element_index,lon,lat,max(ssh(:,25:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-ref',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0.9 2.3]);
% caxis([0 1]);

hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(2,4,2)
trisurf(element_index,lon,lat,max(ssh2(:,25:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-6h-ps',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0.9 2.3]);
% caxis([0 1]);

hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(2,4,3)
trisurf(element_index,lon,lat,max(ssh3(:,25:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-12h-ps',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0.9 2.3]);
% caxis([0 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');


subplot(2,4,4)
trisurf(element_index,lon,lat,max(ssh4(:,25:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-18h-ps',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([0.9 2.3]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');



subplot(2,4,5)
trisurf(element_index,lon,lat,max(sshd(:,25:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-ref',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([1.1 2]);
% caxis([0 1]);

hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(2,4,6)
trisurf(element_index,lon,lat,max(sshd2(:,25:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-6h-ps',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([1.1 2]);
% caxis([0 1]);

hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)

subplot(2,4,7)
trisurf(element_index,lon,lat,max(sshd3(:,25:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-12h-ps',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([1.1 2]);
% caxis([0 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');


subplot(2,4,8)
trisurf(element_index,lon,lat,max(sshd4(:,25:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-18h-ps',],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
%            axis([-81.2 -80.8 32 32.3]);
caxis([1.1 2]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 24)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');


saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/STORM/Vel_fig_%d.png',its));

