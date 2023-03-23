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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-ref.nc'],'NC_NOWRITE');



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

% h= figure;
%set(h, 'Visible', 'off');

figure(1)
clf
trisurf(element_index,lon,lat,-depth); hold on

view(0,90);shading interp;     
colormap(jet);colorbar;axis equal
% title('Bathymetry (m) ','FontSize',16);
xlabel('Longitude ','FontSize',22)
ylabel('Latitude ','FontSize',22)
caxis([-25 0])
axis([min_lon max_lon min_lat max_lat])
hcb=colorbar;
title(hcb,'(m)','fontsize', 14)
box on;
grid on;
graph_handle= gca;
set(graph_handle,'fontsize', 22)
set(graph_handle,'linewidth', 1)   
saveas(h,sprintf('/Users/ifederico/Desktop/sealev0/bathy.png'));










u_velocity=field{8}.data; 
v_velocity=field{9}.data;
ssh=field{10}.data;

uv_velocity = (u_velocity.*u_velocity + v_velocity.*v_velocity).^0.5;

uv_velocity(uv_velocity==0)=-9999;
%uv_velocity(uv_velocity < 0.001)=-9999;
  for i=1:nn
        if(ssh(i,1) > -5)
        ssh(i,1) = NaN;
        end
  end
 
 for i=1:nn
     for j=2:nt
        if(uv_velocity(1,i,j) == -9999)
        ssh(i,j) = NaN;
        end
     end
 end


    
startdate ='2019-01-01 00:00:00';
refdate=datenum(startdate);
 
for it=1:25 %nt
    
timestamp=datestr(refdate+((it-1)/24),'yyyy-mm-dd HH:MM:SS');
    
%     h= figure;
%     trisurf(element_index,lon,lat,uv_velocity(1,:,it))
%     view(0,90);shading interp     
%     colormap(jet);colorbar;axis equal
%     title('uv (m/s) ','FontSize',22);
%     xlabel('Longitude ','FontSize',22)
%     ylabel('Latitude ','FontSize',22)
%        %caxis([-25. 5.])
%        %axis([XMIN XMAX YMIN YMAX])
%     axis([min_lon max_lon min_lat max_lat])
%     graph_handle= gca;
%     set(graph_handle,'fontsize', 22)
%     set(graph_handle,'linewidth', 1)

    h=figure;
    set(h, 'Visible', 'off');
    trisurf(element_index,lon,lat,ssh(:,it)+5)
    view(0,90);shading interp;     
    colormap(jet);colorbar;axis equal
    title(['\color{red} ',timestamp],'FontSize',22);
    xlabel('Longitude ','FontSize',22)
    ylabel('Latitude ','FontSize',22)
    caxis([-2. 2])
    axis([min_lon max_lon min_lat max_lat])
    hcb=colorbar;
    title(hcb,'h (m)','fontsize', 14)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 22)
    set(graph_handle,'linewidth', 1)   
    saveas(h,sprintf('/Users/ifederico/Desktop/sealev0/ampli3_%d.png',it));
end



for it=1:25 %nt
timestamp=datestr(refdate+((it-1)/24),'yyyy-mm-dd HH:MM:SS');
    
    h=figure;
    set(h, 'Visible', 'off');
    trisurf(element_index,lon,lat,ssh(:,it)+5)
    view(0,90);shading interp;     
    colormap(jet);colorbar;axis equal
    title(['\color{red} ',timestamp],'FontSize',22);
    xlabel('Longitude ','FontSize',22)
    ylabel('Latitude ','FontSize',22)
    caxis([-2. 2.])
    axis([-81.2 -80.8 31.85 32.3])
    hcb=colorbar;
    title(hcb,'h (m)','fontsize', 14)
    box on;
    grid on;
    graph_handle= gca;
    set(graph_handle,'fontsize', 22)
    set(graph_handle,'linewidth', 1)   
    saveas(h,sprintf('/Users/ifederico/Desktop/sealev0/ampli3s_%d.png',it));
end


   
