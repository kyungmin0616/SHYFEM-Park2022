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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-at-dv.nc'],'NC_NOWRITE');

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


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-oc-dv-wp-0-slp-std.nc'],'NC_NOWRITE');

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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide.nc'],'NC_NOWRITE');

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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-at-dv.nc'],'NC_NOWRITE');

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


ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide-oc-dv-wp-0-slp-std.nc'],'NC_NOWRITE');

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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Matthew %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


h=figure('units','normalized','position',[0 0 0.5 1]);
set(h, 'Visible', 'on');
% clf

ctd=-8;
its=104-48;
timestamp=datestr(refdate+((its-1)/24),'mmm-dd-yyyy HH:MM:SS');
timestamp2=datestr(refdate2+((its-1+ctd)/24),'mmm-dd-yyyy HH:MM:SS');

h1=subplot(2,3,1);
trisurf(element_index,lon,lat,ssh(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-BS:','\color{black} ',timestamp],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.4 1.7]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.2:80.1)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.2:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
  
h2=subplot(2,3,4);
trisurf(element_index,lon,lat,ssh3(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{blue}MT-OD:','\color{black} ',timestamp],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.02 0.1]);
box on;
grid on;
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
xticks(-81.4:0.2:80.1)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.2:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
    

its=104;
timestamp=datestr(refdate+((its-1)/24),'mmm-dd-yyyy HH:MM:SS');
timestamp2=datestr(refdate2+((its-1+ctd)/24),'mmm-dd-yyyy HH:MM:SS');

h3=subplot(2,3,2);
trisurf(element_index,lon,lat,ssh2(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-BS:','\color{black} ',timestamp],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.4 1.7]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
  
h4=subplot(2,3,5);
trisurf(element_index,lon,lat,ssh3(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{blue}MT-OD:','\color{black} ',timestamp],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.02 0.1]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
    

its=104+48;
timestamp=datestr(refdate+((its-1)/24),'mmm-dd-yyyy HH:MM:SS');
timestamp2=datestr(refdate2+((its-1+ctd)/24),'mmm-dd-yyyy HH:MM:SS');

h5=subplot(2,3,3);
trisurf(element_index,lon,lat,ssh2(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}MT-BS:','\color{black} ',timestamp],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.4 1.7]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
set(hcb,'YTick',-0.4:0.4:1.6)
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
  
h6=subplot(2,3,6);
trisurf(element_index,lon,lat,ssh3(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{blue}MT-OD:','\color{black} ',timestamp],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.02 0.1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

% h1_pos = get(h1,'Position');
% h2_pos = get(h2,'Position');
% h3_pos = get(h3,'Position');
% h4_pos = get(h4,'Position');
% h5_pos = get(h5,'Position');
% h6_pos = get(h6,'Position');

sp_width= 0.3;
sp_height= 0.43;
x_gap=0.015;
x1 = 0.05;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap;
y1 = 0.55;
y2 = 0.05;
x_os=0;
y_os=-0.02;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x3+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h2,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x3+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.



saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_8_a.png',1));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dorian %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=figure('units','normalized','position',[0 0 0.5 1]);
set(h, 'Visible', 'on');
% clf
ctd=-7;
its=104-48;
timestamp=datestr(refdate+((its-1)/24),'mmm-dd-yyyy HH:MM:SS');
timestamp2=datestr(refdate2+((its-1+ctd)/24),'mmm-dd-yyyy HH:MM:SS');

h1=subplot(2,3,1);
trisurf(element_index,lon,lat,sshd(:,its+ctd))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-BS:','\color{black} ',timestamp2],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.4 1]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.2:80.1)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.2:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
  
h2=subplot(2,3,4);
trisurf(element_index,lon,lat,sshd3(:,its+ctd))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{blue}DR-OD:','\color{black} ',timestamp2],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.02 0.1]);
box on;
grid on;
graph_handle= gca;
xticks(-81.4:0.2:80.1)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.2:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
    

its=104;
timestamp=datestr(refdate+((its-1)/24),'mmm-dd-yyyy HH:MM:SS');
timestamp2=datestr(refdate2+((its-1+ctd)/24),'mmm-dd-yyyy HH:MM:SS');

h3=subplot(2,3,2);
trisurf(element_index,lon,lat,sshd(:,its+ctd))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-BS:','\color{black} ',timestamp2],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.4 1]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
  
h4=subplot(2,3,5);
trisurf(element_index,lon,lat,sshd3(:,its+ctd))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{blue}DR-OD:','\color{black} ',timestamp2],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.02 0.1]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
    

its=104+48;
timestamp=datestr(refdate+((its-1)/24),'mmm-dd-yyyy HH:MM:SS');
timestamp2=datestr(refdate2+((its-1+ctd)/24),'mmm-dd-yyyy HH:MM:SS');

h5=subplot(2,3,3);
trisurf(element_index,lon,lat,sshd(:,its+ctd))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{black}DR-BS:','\color{black} ',timestamp2],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.4 1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
  
h6=subplot(2,3,6);
trisurf(element_index,lon,lat,sshd3(:,its+ctd))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
title(['\color{blue}DR-OD:','\color{black} ',timestamp2],'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.02 0.1]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

sp_width= 0.3;
sp_height= 0.43;
x_gap=0.015;
x1 = 0.05;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap;
y1 = 0.55;
y2 = 0.05;
x_os=0;
y_os=-0.02;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x3+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h2,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h4,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x3+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.



saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_8_b.png',1));



