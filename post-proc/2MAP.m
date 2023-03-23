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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-base.nc'],'NC_NOWRITE');

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


ssh1=field{10}.data;


% Netcdf file
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

% parameters for map
ssh=field{10}.data;

ssh2=ssh;

clear ssh time

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-only-tide.nc'],'NC_NOWRITE');

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

% parameters for map
ssh=field{10}.data;

ssh3=ssh;


clear ssh


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-6h-only-tide.nc'],'NC_NOWRITE');

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

% parameters for map
ssh=field{10}.data;

ssh4=ssh;

clear ssh 

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide.nc'],'NC_NOWRITE');

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

% parameters for map
ssh=field{10}.data;

ssh5=ssh;

clear ssh 
%% Dorian

% clear
% clc

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-base.nc'],'NC_NOWRITE');

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


sshd1=field{10}.data;

% Netcdf file
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

% parameters for map
time=field{5}.data;
ssh=field{10}.data;

sshd2=ssh;
timed2=time;

clear ssh time

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-only-tide.nc'],'NC_NOWRITE');

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

% parameters for map
time=field{5}.data;
ssh=field{10}.data;

sshd3=ssh;
timed3=time;

clear ssh time

% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-6h-only-tide.nc'],'NC_NOWRITE');

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

% parameters for map
time=field{5}.data;
ssh=field{10}.data;

sshd4=ssh;
timed4=time;

clear ssh time


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-tide.nc'],'NC_NOWRITE');

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

% parameters for map
time=field{5}.data;
ssh=field{10}.data;

sshd5=ssh;
timed5=time;

refdate = datenum('2016-10-04 00:00:00');
refdate2 = datenum('2019-09-01 00:00:00');

min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;




%% Peak Level


h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');
clf

stt=24*3;
edt=24*5;
its=120;
h1=subplot(2,2,1);
trisurf(element_index,lon,lat,max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}Matthew-ST','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([0.75 2.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h2=subplot(2,2,2);
trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}Matthew-ST6H','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([0.75 2.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)


h3=subplot(2,2,3);
trisurf(element_index,lon,lat,max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}Dorian-ST','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([1.1 1.9]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h3=subplot(2,2,4);
trisurf(element_index,lon,lat,max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
colormap(turbo);
% axis equal
title('\color{black}Dorian-ST6H','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([1.1 1.9]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_9_a_add2.png',1));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% W/ Difference %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

% figure(1)
clf

stt=24*2;
edt=24*7;
its=120;
h1=subplot(2,3,1);
trisurf(element_index,lon,lat,max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
colorbar;
% axis equal
title('\color{black}MT-ST','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([0.75 2.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h2=subplot(2,3,2);
trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST6H','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([0.75 2.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h3=subplot(2,3,3);
trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
% trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))
% 
view(0,90);shading interp;     
% axis equal
title('\color{black}Change in peak level','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
% caxis([-40 10]);
% caxis([-42 10]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% colormap(graph_handle,parula)
colormap(graph_handle,bluewhitered)

h4=subplot(2,3,4);
trisurf(element_index,lon,lat,max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-ST','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([1.1 1.9]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h5=subplot(2,3,5);
trisurf(element_index,lon,lat,max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
% colormap(getpmap(7));
% colormap(turbo);
% axis equal
title('\color{black}DR-ST6H','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([1.1 1.9]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h6=subplot(2,3,6);
trisurf(element_index,lon,lat,(max(sshd2(:,stt:edt),[],2)-max(sshd1(:,stt:edt),[],2))./max(sshd1(:,stt:edt),[],2)*100)
% trisurf(element_index,lon,lat,max(sshd2(:,stt:edt),[],2)-max(sshd1(:,stt:edt),[],2))
view(0,90); shading interp;     
% colormap(turbo);
% axis equal
title('\color{black}Change in peak level','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
% caxis([-10 2]);
% caxis([-42 10]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
% colormap(graph_handle,parula)
colormap(graph_handle,bluewhitered)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_9_a_add2.png',1));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAV / SAP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SAV
h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

% figure(1)
clf

stt=24*3;
edt=24*5;
% its=120;
h1=subplot(2,3,1);
trisurf(element_index,lon,lat,max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
colorbar;
% axis equal
title('\color{black}MT-ST','FontSize',22);
axis([-81.3 -80.8 31.8 32.3]); % Sav
caxis([0.75 2.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h2=subplot(2,3,2);
trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST6H','FontSize',22);
axis([-81.3 -80.8 31.8 32.3]); % Sav
caxis([0.75 2.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h3=subplot(2,3,3);
trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
% 
view(0,90);shading interp;     
% axis equal
title('\color{black}Change in peak level','FontSize',22);
axis([-81.3 -80.8 31.8 32.3]); % Sav
% caxis([-40 10]);
% caxis([-42 10]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,bluewhitered)

h4=subplot(2,3,4);
trisurf(element_index,lon,lat,max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-ST','FontSize',22);
axis([-81.3 -80.8 31.8 32.3]); % Sav
caxis([1.1 1.9]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h5=subplot(2,3,5);
trisurf(element_index,lon,lat,max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
% colormap(getpmap(7));
% colormap(turbo);
% axis equal
title('\color{black}DR-ST6H','FontSize',22);
axis([-81.3 -80.8 31.8 32.3]); % Sav
caxis([1.1 1.9]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h6=subplot(2,3,6);
trisurf(element_index,lon,lat,(max(sshd2(:,stt:edt),[],2)-max(sshd1(:,stt:edt),[],2))./max(sshd1(:,stt:edt),[],2)*100)
view(0,90); shading interp;     
% colormap(turbo);
% axis equal
title('\color{black}Change in peak level','FontSize',22);
axis([-81.3 -80.8 31.8 32.3]); % Sav
% caxis([-10 2]);
% caxis([-42 10]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,bluewhitered)
% colormap(graph_handle,parula)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/Figure_9_a_add2.png',1));

% SAP
h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

figure(1)
clf

stt=24*3;
edt=24*5;
% its=120;
h1=subplot(2,3,1);
trisurf(element_index,lon,lat,max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
colorbar;
% axis equal
title('\color{black}MT-ST','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0.75 2.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h2=subplot(2,3,2);
trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST6H','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0.75 2.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h3=subplot(2,3,3);
trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
% 
view(0,90);shading interp;     
% axis equal
title('\color{black}Change in peak level','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-40 10]);
% caxis([-42 10]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,bluewhitered)

h4=subplot(2,3,4);
trisurf(element_index,lon,lat,max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-ST','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([1.1 1.9]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h5=subplot(2,3,5);
trisurf(element_index,lon,lat,max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
% colormap(getpmap(7));
% colormap(turbo);
% axis equal
title('\color{black}DR-ST6H','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([1.1 1.9]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h6=subplot(2,3,6);
trisurf(element_index,lon,lat,(max(sshd2(:,stt:edt),[],2)-max(sshd1(:,stt:edt),[],2))./max(sshd1(:,stt:edt),[],2)*100)
view(0,90); shading interp;     
% colormap(turbo);
% axis equal
title('\color{black}Change in peak level','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-10 2]);
% caxis([-42 10]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,bluewhitered)
% colormap(graph_handle,parula)

%% Ir calculation

stt=24*3;
edt=24*5;

clear Ir_MT Ir_MT_6H
for i=1:length(ssh1(:,1))
    
    Ir_MT(i,1) = sqrt(mean((ssh1(i,stt:edt)-(ssh3(i,stt:edt)+ssh5(i,stt:edt))).^2)) / sqrt(sqrt(mean(ssh3(i,stt:edt).^2)).*sqrt(mean(ssh5(i,stt:edt).^2)));
    Ir_MT_6H(i,1) = sqrt(mean((ssh2(i,stt:edt)-(ssh4(i,stt:edt)+ssh5(i,stt:edt))).^2)) / sqrt(sqrt(mean(ssh4(i,stt:edt).^2)).*sqrt(mean(ssh5(i,stt:edt).^2)));
   
    Ir_DR(i,1) = sqrt(mean((sshd1(i,stt:edt)-(sshd3(i,stt:edt)+sshd5(i,stt:edt))).^2)) / sqrt(sqrt(mean(sshd3(i,stt:edt).^2)).*sqrt(mean(sshd5(i,stt:edt).^2)));
    Ir_DR_6H(i,1) = sqrt(mean((sshd2(i,stt:edt)-(sshd4(i,stt:edt)+sshd5(i,stt:edt))).^2)) / sqrt(sqrt(mean(sshd4(i,stt:edt).^2)).*sqrt(mean(sshd5(i,stt:edt).^2)));
    
end


figure(1)
clf

h1=subplot(2,3,1);
trisurf(element_index,lon,lat,Ir_MT)
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}MT-OT','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 0.45]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h2=subplot(2,3,2);
trisurf(element_index,lon,lat,Ir_MT_6H)
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}MT-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 0.45]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h3=subplot(2,3,3);
trisurf(element_index,lon,lat,Ir_MT-Ir_MT_6H)
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}Ir_MT-Ir_MT_6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([0 0.45]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h4=subplot(2,3,4);
trisurf(element_index,lon,lat,Ir_DR)
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-ST','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.8 0.1]);
caxis([0 0.5]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h5=subplot(2,3,5);
trisurf(element_index,lon,lat,Ir_DR_6H)
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-ST6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 0.5]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h5=subplot(2,3,6);
trisurf(element_index,lon,lat,Ir_DR-Ir_DR_6H)
view(0,90);shading interp;     
% axis equal
title('\color{black}Ir DR-Ir DR 6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([-0.1 0.1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Entire view %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

stt=24*3;
edt=24*5;

clear Ir_MT Ir_MT_6H
for i=1:length(ssh1(:,1))
    
    Ir_MT(i,1) = sqrt(mean((ssh1(i,stt:edt)-(ssh3(i,stt:edt)+ssh5(i,stt:edt))).^2)) / sqrt(sqrt(mean(ssh3(i,stt:edt).^2)).*sqrt(mean(ssh5(i,stt:edt).^2)));
    Ir_MT_6H(i,1) = sqrt(mean((ssh2(i,stt:edt)-(ssh4(i,stt:edt)+ssh5(i,stt:edt))).^2)) / sqrt(sqrt(mean(ssh4(i,stt:edt).^2)).*sqrt(mean(ssh5(i,stt:edt).^2)));
   
    Ir_DR(i,1) = sqrt(mean((sshd1(i,stt:edt)-(sshd3(i,stt:edt)+sshd5(i,stt:edt))).^2)) / sqrt(sqrt(mean(sshd3(i,stt:edt).^2)).*sqrt(mean(sshd5(i,stt:edt).^2)));
    Ir_DR_6H(i,1) = sqrt(mean((sshd2(i,stt:edt)-(sshd4(i,stt:edt)+sshd5(i,stt:edt))).^2)) / sqrt(sqrt(mean(sshd4(i,stt:edt).^2)).*sqrt(mean(sshd5(i,stt:edt).^2)));
    
end





% h=figure('units','normalized','position',[0 0 1 1]);
% set(h, 'Visible', 'on');
figure(5)
clf

h1=subplot(4,2,1);
trisurf(element_index,lon,lat,Ir_MT)
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
box on;
grid on;
% caxis([-15 2]);
% caxis([-20 1]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% view(0,90);shading interp;     
% set(gcf,'color','y');
% set(gca,'Color',[0.5, 0.5, 0.5]) % grey for plot
colormap(graph_handle,bluewhitered)

h2=subplot(4,2,2);
trisurf(element_index,lon,lat,NL_MT_6H*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]);
axis([-81.3 -80.8 31.8 32.3]);% Sav
% caxis([-0.2 0.05]); %Sav
% caxis([-0.2 0.02]);
% caxis([-15 2]);
caxis([-20 1]);
box on;
grid on;
% caxis([-15 0]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% set(gca,'Color',[0.5, 0.5, 0.5])
colormap(graph_handle,bluewhitered)


% colormap(bluewhitered)

h4=subplot(4,2,3);
trisurf(element_index,lon,lat,NL_DR*100)
view(0,90);shading interp;     
% colormap(turbo);
% axis equal
title('\color{black}DR-ST','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]);
axis([-81.3 -80.8 31.8 32.3]);% Sav
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
box on;
grid on;
% caxis([-10 10]);
caxis([-20 1]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% set(gca,'Color',[0.5, 0.5, 0.5])
colormap(graph_handle,bluewhitered)


h5=subplot(4,2,4);
trisurf(element_index,lon,lat,NL_DR_6H*100)
view(0,90);shading interp;     
% colormap(parula)
% axis equal
title('\color{black}DR-ST6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]);
axis([-81.3 -80.8 31.8 32.3]);% Sav
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
box on;
grid on;
% caxis([-10 10]);
% caxis([-20 10]);
caxis([-20 1]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,bluewhitered)


h7=subplot(4,2,5);
trisurf(element_index,lon,lat,NL_MT*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
box on;
grid on;
% caxis([-15 2]);
caxis([-20 1]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% view(0,90);shading interp;     
% set(gcf,'color','y');
% set(gca,'Color',[0.5, 0.5, 0.5]) % grey for plot
colormap(graph_handle,bluewhitered)

h8=subplot(4,2,6);
trisurf(element_index,lon,lat,NL_MT_6H*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST6H','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% axis([-81.3 -80.8 31.8 32.3]);% Sav
% caxis([-0.2 0.05]); %Sav
% caxis([-0.2 0.02]);
% caxis([-15 2]);
caxis([-20 1]);
box on;
grid on;
% caxis([-15 0]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% set(gca,'Color',[0.5, 0.5, 0.5])
colormap(graph_handle,bluewhitered)



% colormap(bluewhitered)

h10=subplot(4,2,7);
trisurf(element_index,lon,lat,NL_DR*100)
view(0,90);shading interp;     
% colormap(turbo);
% axis equal
title('\color{black}DR-ST','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]);
% axis([-81.3 -80.8 31.8 32.3]);% Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
box on;
grid on;
% caxis([-10 10]);
caxis([-20 1]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% set(gca,'Color',[0.5, 0.5, 0.5])
colormap(graph_handle,bluewhitered)


h11=subplot(4,2,8);
trisurf(element_index,lon,lat,NL_DR_6H*100)
view(0,90);shading interp;     
% colormap(parula)
% axis equal
title('\color{black}DR-ST6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
box on;
grid on;
% caxis([-10 10]);
% caxis([-20 10]);
caxis([-20 1]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,bluewhitered)
%% Contribution of tide to peak water level

stt=24*3;
edt=24*5;

OT_MT=zeros(length(ssh1(:,1)),1);
OT_MT_6H=zeros(length(ssh1(:,1)),1);
OT_DR=zeros(length(sshd1(:,1)),1);
OT_DR_6H=zeros(length(sshd1(:,1)),1);

ST_MT=zeros(length(ssh1(:,1)),1);
ST_MT_6H=zeros(length(ssh1(:,1)),1);

ST_DR=zeros(length(sshd1(:,1)),1);
ST_DR_6H=zeros(length(sshd1(:,1)),1);

% storm tide timing
for i=1:length(ssh1(:,1))
    
    [M,mi1]=max(ssh1(i,stt:edt));
    OT_MT(i,1)=ssh3(i,stt+mi1-1);
    ST_MT(i,1)=ssh5(i,stt+mi1-1);

    [M,mi2]=max(ssh2(i,stt:edt));
    OT_MT_6H(i,1)=ssh4(i,stt+mi2-1);
    ST_MT_6H(i,1)=ssh5(i,stt+mi2-1);
    
    [M,di1]=max(sshd1(i,stt:edt));
    OT_DR(i,1)=sshd3(i,stt+di1-1);
    ST_DR(i,1)=sshd5(i,stt+di1-1);

    [M,di2]=max(sshd2(i,stt:edt));
    OT_DR_6H(i,1)=sshd4(i,stt+di2-1);
    ST_DR_6H(i,1)=sshd5(i,stt+di2-1);

    
end

% 
% % storm surge timing
% for i=1:length(ssh1(:,1))
%     
%     [M,mi1]=max(ssh5(i,stt:edt));
%     OT_MT(i,1)=ssh3(i,stt+mi1-1);
%     ST_MT(i,1)=ssh5(i,stt+mi1-1);
% 
%     [M,mi2]=max(ssh5(i,stt:edt));
%     OT_MT_6H(i,1)=ssh4(i,stt+mi2-1);
%     ST_MT_6H(i,1)=ssh5(i,stt+mi2-1);
%     
%     [M,di1]=max(sshd5(i,stt:edt));
%     OT_DR(i,1)=sshd3(i,stt+di1-1);
%     ST_DR(i,1)=sshd5(i,stt+di1-1);
% 
%     [M,di2]=max(sshd5(i,stt:edt));
%     OT_DR_6H(i,1)=sshd4(i,stt+di2-1);
%     ST_DR_6H(i,1)=sshd5(i,stt+di2-1);
% 
%     
% end


h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

figure(1)
clf

h1=subplot(2,3,1);
trisurf(element_index,lon,lat,OT_MT./max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}MT-OT','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h2=subplot(2,3,2);
trisurf(element_index,lon,lat,OT_MT_6H./max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}MT-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h3=subplot(2,3,3);
trisurf(element_index,lon,lat,(OT_MT./max(ssh1(:,stt:edt),[],2))-(OT_MT_6H./max(ssh2(:,stt:edt),[],2)))
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}MT-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
% caxis([-0.3 0.3]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,bluewhitered)


h4=subplot(2,3,4);
trisurf(element_index,lon,lat,OT_DR./max(sshd1(:,stt:edt),[],2))
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-OS','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.8 0.1]);
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h5=subplot(2,3,5);
trisurf(element_index,lon,lat,OT_DR_6H./max(sshd2(:,stt:edt),[],2))
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.8 0.1]);
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)


h6=subplot(2,3,6);
trisurf(element_index,lon,lat,(OT_DR./max(sshd1(:,stt:edt),[],2))-(OT_DR_6H./max(sshd2(:,stt:edt),[],2)))
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.8 0.1]);
% caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,bluewhitered)


figure(1)
clf

h1=subplot(2,3,1);
trisurf(element_index,lon,lat,OT_MT./max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}MT-OT','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h2=subplot(2,3,2);
trisurf(element_index,lon,lat,OT_MT_6H./max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}MT-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h3=subplot(2,3,3);
trisurf(element_index,lon,lat,(OT_MT./max(ssh1(:,stt:edt),[],2))-(OT_MT_6H./max(ssh2(:,stt:edt),[],2)))
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}MT-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.3 0.3]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,bluewhitered)


h4=subplot(2,3,4);
trisurf(element_index,lon,lat,OT_DR./max(sshd1(:,stt:edt),[],2))
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-OS','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.8 0.1]);
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h5=subplot(2,3,5);
trisurf(element_index,lon,lat,OT_DR_6H./max(sshd2(:,stt:edt),[],2))
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.8 0.1]);
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)


h6=subplot(2,3,6);
trisurf(element_index,lon,lat,(OT_DR./max(sshd1(:,stt:edt),[],2))-(OT_DR_6H./max(sshd2(:,stt:edt),[],2)))
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.8 0.1]);
% caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,bluewhitered)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
clf
h1=subplot(2,2,1);
trisurf(element_index,lon,lat,OT_MT./max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}MT-OT','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h2=subplot(2,2,2);
trisurf(element_index,lon,lat,OT_MT_6H./max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}MT-OT6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h3=subplot(2,2,3);
trisurf(element_index,lon,lat,OT_DR./max(sshd1(:,stt:edt),[],2))
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-OS','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
% caxis([-0.8 0.1]);
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h4=subplot(2,2,4);
trisurf(element_index,lon,lat,OT_DR_6H./max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-OS6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clf
h1=subplot(2,2,1);
trisurf(element_index,lon,lat,OT_MT./max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}MT-OT','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h2=subplot(2,2,2);
trisurf(element_index,lon,lat,OT_MT_6H./max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}MT-OT6H','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h3=subplot(2,2,3);
trisurf(element_index,lon,lat,OT_DR./max(sshd1(:,stt:edt),[],2))
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-OS','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.8 0.1]);
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h4=subplot(2,2,4);
trisurf(element_index,lon,lat,OT_DR_6H./max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-OS6H','FontSize',22);
axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dorian %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

figure(2)
clf

stt=25;
edt=24*6;
its=120;
h1=subplot(2,2,1);
trisurf(element_index,lon,lat,OT_DR./max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}DR-OT','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
% xticks(-81.4:0.2:80.1)
% xtickformat('%.1f')
% graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
% yticks(31.2:0.2:32.4)
% ytickformat('%.1f')
% graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h2=subplot(2,2,2);
trisurf(element_index,lon,lat,OT_DR_6H./max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
% axis equal
title('\color{black}DR-OT6H','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h3=subplot(2,2,3);
trisurf(element_index,lon,lat,ST_DR./max(sshd1(:,stt:edt),[],2))
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-ST','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
% caxis([-0.8 0.1]);
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h4=subplot(2,2,4);
trisurf(element_index,lon,lat,ST_DR_6H./max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}DR-ST6H','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]); %Entire view
% axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.45 -81.1 31.3 31.8]);% Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)



h3=subplot(2,2,1);

figure()
trisurf(element_index,lon,lat,max(ssh1(:,stt:edt),[],2)-(OT_MT+ST_MT)-NL_MT)
% trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100)
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
% caxis([-0.8 0.1]);
% caxis([-8 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h4=subplot(2,2,4);
trisurf(element_index,lon,lat,ST_MT_6H./max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST6H','FontSize',22);
% axis([-81.45 -80.35 min_lat max_lat]); %Entire view
axis([-81.3 -80.8 31.8 32.3]); % Sav
% axis([-81.3 -80.8 31 32.8]); % Sapero
caxis([0 1]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
% set(gca,'XTickLabel',[]);
% set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)



%% Ver.2
clf

stt=25;
edt=24*7;

%NL

for its=25:24*7
    
timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');
timestamp2=datestr(refdate2+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

h1=subplot(2,2,1);
trisurf(element_index,lon,lat,ssh1(:,its)-(ssh3(:,its)+ssh5(:,its)))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}Matthew-NL: ',timestamp','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.15 0.15]);
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

h2=subplot(2,2,2);
trisurf(element_index,lon,lat,ssh2(:,its)-(ssh4(:,its)+ssh5(:,its)))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}Matthew-6h-NL: ',timestamp,'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.15 0.15]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)


h3=subplot(2,2,3);
trisurf(element_index,lon,lat,sshd1(:,its)-(sshd3(:,its)+sshd5(:,its)))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}Dorian-NL: ',timestamp2,'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.15 0.15]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h3=subplot(2,2,4);
trisurf(element_index,lon,lat,sshd2(:,its)-(sshd4(:,its)+sshd5(:,its)))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}Dorian-6h-NL: ',timestamp2,'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-0.15 0.15]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Tide_Figures/Figures/NI_%d.png',its));


end


% TWL
for its=25:24*7
    
timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');
timestamp2=datestr(refdate2+((its-1)/24),'yyyy-mm-dd HH:MM:SS');
    
h1=subplot(2,2,1);
trisurf(element_index,lon,lat,ssh1(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}Matthew-TWL: ',timestamp,'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-1.5 2.2]);
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

h2=subplot(2,2,2);
trisurf(element_index,lon,lat,ssh2(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}Matthew-6h-TWL: ',timestamp,'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-1.5 2.2]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)


h3=subplot(2,2,3);
trisurf(element_index,lon,lat,sshd1(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}Dorian-TWL: ',timestamp2,'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-1.5 1.8]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

h3=subplot(2,2,4);
trisurf(element_index,lon,lat,sshd2(:,its))
view(0,90);shading interp;     
colormap(getpmap(7));
colorbar;
% axis equal
title('\color{black}Dorian-6h-TWL: ',timestamp2,'FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([-1.5 1.8]);
box on;
grid on;
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Tide_Figures/Figures/TWL/TWL_%d.png',its));


end


