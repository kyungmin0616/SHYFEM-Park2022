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
refdate = datenum('2019-09-01 00:00:00');

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
element_index=field{1}.data(1:3,:)';
ssh2=field{10}.data;


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
ssh3=field{10}.data;
   
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
ssh4=field{10}.data;


%% Plotting

for its=24:1:144 %48, nt
    its=104
            timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');
        its
         
           h=figure('units','normalized','position',[0 0 1 0.3]);
           set(h, 'Visible', 'on');

           
           subplot(1,4,1)
           trisurf(element_index,lon,lat,ssh(:,its))
           view(0,90);shading interp;     
           colormap(getpmap(7));
%            colorbar;axis equal
           title(['\color{black}Ref.: ',timestamp],'FontSize',22);
           %title(['\color{blue}FC: ',timestamp],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
%            axis([min_lon max_lon min_lat max_lat]);
           axis([-81.2 -80.8 32 32.3]);
           caxis([-1.5 2.7]);
%            hcb=colorbar;
%            title(hcb,'h (m)','fontsize', 12)
           box on;
           grid on;
           graph_handle= gca;
           set(graph_handle,'fontsize', 18)
           set(graph_handle,'linewidth', 1)

    
           subplot(1,4,2)
           trisurf(element_index,lon,lat,ssh2(:,its))
           view(0,90);shading interp;     
           colormap(getpmap(7));
%            colorbar;axis equal
           title(['\color{black}6h ST: ',timestamp],'FontSize',22);
           %title(['\color{blue}FC: ',timestamp],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
%            axis([min_lon max_lon min_lat max_lat]);
           axis([-81.2 -80.8 32 32.3]);
           caxis([-1.5 2.7]);
%            hcb=colorbar;
%            title(hcb,'h (m)','fontsize', 12)
           box on;
           grid on;
           graph_handle= gca;
           set(graph_handle,'fontsize', 18)
           set(graph_handle,'linewidth', 1)
           
           subplot(1,4,3)
           trisurf(element_index,lon,lat,ssh3(:,its))
           view(0,90);shading interp;     
           colormap(getpmap(7));
%            colorbar;axis equal
           title(['\color{black}12h ST: ',timestamp],'FontSize',22);
           %title(['\color{blue}FC: ',timestamp],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
%            axis([min_lon max_lon min_lat max_lat]);
           axis([-81.2 -80.8 32 32.3]);
           caxis([-1.5 2.7]);
%            hcb=colorbar;
%            title(hcb,'h (m)','fontsize', 12)
           box on;
           grid on;
           graph_handle= gca;
           set(graph_handle,'fontsize', 18)
           set(graph_handle,'linewidth', 1)
           
           subplot(1,4,4)
           trisurf(element_index,lon,lat,ssh4(:,its))
           view(0,90);shading interp;     
           colormap(getpmap(7));
%            colorbar;axis equal
           title(['\color{black}18h ST: ',timestamp],'FontSize',22);
           %title(['\color{blue}FC: ',timestamp],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
%            axis([min_lon max_lon min_lat max_lat]);
           axis([-81.2 -80.8 32 32.3]);
           caxis([-1.5 2.7]);
%            hcb=colorbar;
%            title(hcb,'h (m)','fontsize', 12)
           box on;
           grid on;
           graph_handle= gca;
           set(graph_handle,'fontsize', 18)
           set(graph_handle,'linewidth', 1)
  
           
           saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/TideCase/tide_%d.png',its));

end
