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

[nl nn nt]=size(field{9}.data)




% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide-wo-hydro.nc'],'NC_NOWRITE');

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


% Netcdf file
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-oc-0-at-0.nc'],'NC_NOWRITE');

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


% Netcdf file
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


ssh4=field{10}.data;
return

%%
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-ssh-sp-fz.nc'],'NC_NOWRITE');
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
% 
% 
% ssh5=field{10}.data;
% 
% 
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-6h-tide-wo-ssh-sp-fz.nc'],'NC_NOWRITE');
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
% 
% 
% ssh6=field{10}.data;
% 
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-12h-tide-wo-ssh-sp-fz.nc'],'NC_NOWRITE');
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
% 
% 
% ssh7=field{10}.data;
% 
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-18h-tide-wo-ssh-sp-fz.nc'],'NC_NOWRITE');
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
% 
% 
% ssh8=field{10}.data;
% 
% % Netcdf file
% ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-wo-tide.nc'],'NC_NOWRITE');
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
% 
% 
% ssh9=field{10}.data;


refdate = datenum('2016-10-04 00:00:00');

%% Dorian

clear
clc

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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/dorian-wo-ssh-sp-fz.nc'],'NC_NOWRITE');

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
ssh3=field{10}.data;

refdate = datenum('2019-09-01 00:00:00');


%% Plotting

for its=49:1:168 %48, nt
            
    
    its
    timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');


    h=figure('units','normalized','position',[0 0 0.5 1]);
    set(h, 'Visible', 'off');
    trisurf(element_index,lon,lat,ssh(:,its)-(ssh2(:,its)+ssh3(:,its)))
    view(0,90);shading interp;     
    colormap(getpmap(7));
    %            colorbar;axis equal
    title(['\color{black}NL residual: ',timestamp],'FontSize',22);
    %            xlabel('Longitude (deg)','FontSize',22);
    %            ylabel('Latitude (deg)','FontSize',22);
    axis([min_lon max_lon min_lat max_lat]);
    %            axis([-81.2 -80.8 32 32.3]);
    caxis([-0.3 0.30001]);
    hcb=colorbar;
    title(hcb,'m','fontsize', 12)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 18)
    set(graph_handle,'linewidth', 1)


    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NLinter/2DMAP/D_fig_%d.png',its));

end

nl_ssh=ssh-(ssh5+ssh9);
nl_ssh2=ssh2-(ssh6+ssh9);
nl_ssh3=ssh3-(ssh7+ssh9);
nl_ssh4=ssh4-(ssh8+ssh9);

%% Minimum nl


h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

clf
subplot(1,4,1)
trisurf(element_index,lon,lat,min(nl_ssh(:,49:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
% title('Minimum nonlinear interaction value','FontSize',22);
% xlabel('Longitude (deg)','FontSize',22);
% ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
% axis([-81.2 -80.8 32 32.3]);
caxis([-0.3 0.300001]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

subplot(1,4,2)
trisurf(element_index,lon,lat,min(nl_ssh2(:,49:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
% title('Minimum nonlinear interaction value','FontSize',22);
% xlabel('Longitude (deg)','FontSize',22);
% ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
% axis([-81.2 -80.8 32 32.3]);
caxis([-0.3 0.300001]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

subplot(1,4,3)
trisurf(element_index,lon,lat,min(nl_ssh3(:,49:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
% title('Minimum nonlinear interaction value','FontSize',22);
% xlabel('Longitude (deg)','FontSize',22);
% ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
% axis([-81.2 -80.8 32 32.3]);
caxis([-0.3 0.300001]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

subplot(1,4,4)
trisurf(element_index,lon,lat,min(nl_ssh4(:,49:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
% title('Minimum nonlinear interaction value','FontSize',22);
% xlabel('Longitude (deg)','FontSize',22);
% ylabel('Latitude (deg)','FontSize',22);
axis([min_lon max_lon min_lat max_lat]);
% axis([-81.2 -80.8 32 32.3]);
caxis([-0.3 0.300001]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');



%% Maximim nl


h=figure('units','normalized','position',[0 0 1 1]);
set(h, 'Visible', 'on');

clf
subplot(1,4,1)
trisurf(element_index,lon,lat,max(nl_ssh(:,49:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
% title('Minimum nonlinear interaction value','FontSize',22);
% xlabel('Longitude (deg)','FontSize',22);
% ylabel('Latitude (deg)','FontSize',22);
% axis([min_lon max_lon min_lat max_lat]);
% axis([-81.2 -80.8 32 32.3]);
axis([-81.4 -80.8 31.4 32.2]);
caxis([-0.3 0.300001]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

subplot(1,4,2)
trisurf(element_index,lon,lat,max(nl_ssh2(:,49:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
% title('Minimum nonlinear interaction value','FontSize',22);
% xlabel('Longitude (deg)','FontSize',22);
% ylabel('Latitude (deg)','FontSize',22);
% axis([min_lon max_lon min_lat max_lat]);
% axis([-81.2 -80.8 32 32.3]);
axis([-81.4 -80.8 31.4 32.2]);

caxis([-0.3 0.300001]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

subplot(1,4,3)
trisurf(element_index,lon,lat,max(nl_ssh3(:,49:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
% title('Minimum nonlinear interaction value','FontSize',22);
% xlabel('Longitude (deg)','FontSize',22);
% ylabel('Latitude (deg)','FontSize',22);
% axis([min_lon max_lon min_lat max_lat]);
% axis([-81.2 -80.8 32 32.3]);
axis([-81.4 -80.8 31.4 32.2]);
caxis([-0.3 0.300001]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');

subplot(1,4,4)
trisurf(element_index,lon,lat,max(nl_ssh4(:,49:168),[],2))
view(0,90);shading interp;     
colormap(getpmap(7));
%            colorbar;axis equal
% title('Minimum nonlinear interaction value','FontSize',22);
% xlabel('Longitude (deg)','FontSize',22);
% ylabel('Latitude (deg)','FontSize',22);
% axis([min_lon max_lon min_lat max_lat]);
% axis([-81.2 -80.8 32 32.3]);
axis([-81.4 -80.8 31.4 32.2]);
caxis([-0.3 0.300001]);
hcb=colorbar;
title(hcb,'m','fontsize', 12)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
