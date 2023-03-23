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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/dorian-rd0.nc'],'NC_NOWRITE');


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




[nl nn nt]=size(field{9}.data)


% parameters for map
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;

% bathy=field{9}.data;

min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;



  XMIN = -81;
  YMIN =  32;
  XMAX =  -80.8;
  YMAX =  32.2;
   
% startdate ='2016-10-05 00:00:00';
% refdate=datenum(startdate);
refdate = datenum('2019-09-01 00:00:00');

% u_velocity=field{8}.data; 
% v_velocity=field{9}.data;
ssh=field{10}.data;
% uv_velocity = (u_velocity.*u_velocity + v_velocity.*v_velocity).^0.5;
% uv_velocity(uv_velocity==0)=-9999;


%   for i=1:nn
%         if(ssh(i,1) > -5)
%         ssh(i,1) = NaN;
%         end
%   end
%  
%  for i=1:nn
%      for j=2:nt
%         if(uv_velocity(1,i,j) == -9999)
%         ssh(i,j) = NaN;
%         end
%      end
%  end

%  
% ncid2 = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/20161005/switchv2e_nos0.nc'],'NC_NOWRITE');
% 
% % Get information about the contents of the file.
% [numdims, numvars, numglobalatts, unlimdimID] = netcdf.inq(ncid2);
% 
% for ii = 0:(numvars-1)
%    % Get information about the variables in the file.
%    [varname, xtype, dimids, numatts] = netcdf.inqVar(ncid2,ii);
%    field{ii+1}.name = varname;
% 
%    % Get variable IDs
%    varid = netcdf.inqVarID(ncid2,varname);
% 
%    % Get the value of all variables
%    field{ii+1}.data = netcdf.getVar(ncid2,varid);
%    
% end
% 
% 
% temp=field{6}.data;
% temp(temp == 0) = NaN;
%  for i=1:nn
%      for j=2:nt
%         if(uv_velocity(1,i,j) == -9999)
%         temp(1,i,j) = NaN;
%         end
%      end
%  end
% 
% salt=field{5}.data;
% salt(salt == 0) = NaN;
% for i=1:nn
%      for j=2:nt
%         if(uv_velocity(1,i,j) == -9999)
%         salt(1,i,j) = NaN;
%         end
%      end
%  end
%  
%  
 
 
il =1; 
for its=1:1:nt %48, nt
    
timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

   
           h=figure;
           set(h, 'Visible', 'off');
           trisurf(element_index,lon,lat,ssh(:,its))
           view(0,90);shading interp;     
           colormap(jet);colorbar;axis equal
           title(['\color{black}: ',timestamp],'FontSize',22);
           %title(['\color{blue}FC: ',timestamp],'FontSize',22);
           xlabel('Longitude (deg)','FontSize',22);
           ylabel('Latitude (deg)','FontSize',22);
%            axis([min_lon max_lon min_lat max_lat]);
           axis([-81.2 -80.8 32 32.3]);

%            caxis([-1.5 1.5]);
           hcb=colorbar;
           title(hcb,'h (m)','fontsize', 18)
           box on;
           grid on;
           graph_handle= gca;
           set(graph_handle,'fontsize', 22)
           set(graph_handle,'linewidth', 1)   
           saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/check/SSHref_%d.png',its));
   
%            h=figure;
%            set(h, 'Visible', 'off');
%            trisurf(element_index,lon,lat,temp(1,:,its))
%            view(0,90);shading interp;     
%            colormap(jet);colorbar;axis equal
%            title(['\color{black}: ',timestamp],'FontSize',22);
%            %title(['\color{blue}FC: ',timestamp],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
%            axis([min_lon max_lon min_lat max_lat]);
%            caxis([20 27]);
%            hcb=colorbar;
%            title(hcb,'degC','fontsize', 18)
%            box on;
%            grid on;
%            graph_handle= gca;
%            set(graph_handle,'fontsize', 22)
%            set(graph_handle,'linewidth', 1)   
%            saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/20161006/Image/SST_%d.png',its));
%    
%            h=figure;
%            set(h, 'Visible', 'off');
%            trisurf(element_index,lon,lat,salt(1,:,its))
%            view(0,90);shading interp;     
%            colormap(jet);colorbar;axis equal
%            title(['\color{black}: ',timestamp],'FontSize',22);
%            %title(['\color{blue}FC: ',timestamp],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
%            axis([min_lon max_lon min_lat max_lat]);
%            caxis([5 37]);
%            hcb=colorbar;
%            title(hcb,'psu','fontsize', 18)
%            box on;
%            grid on;
%            graph_handle= gca;
%            set(graph_handle,'fontsize', 22)
%            set(graph_handle,'linewidth', 1)   
%            saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/20161006/Image/SSS_%d.png',its));

end

   