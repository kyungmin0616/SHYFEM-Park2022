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

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/TideCase/ampli1_ous_lev0.nc'],'NC_NOWRITE');

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




[nl nn nt]=size(field{9}.data)


% parameters for map
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
ssh=field{10}.data;
% ssh(ssh==-999)=NaN;
% m_ssh = nanmean(ssh,2);

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


 
  for i=1:nn
        if(ssh(i,1) > -5)
        ssh(i,1) = NaN;
        end
  end
 
  
depth=(field{7}.data);

min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;

   
startdate ='2019-06-10 00:00:00';
refdate=datenum(startdate);

il =1; 

for its=1:nt %48, nt
    
timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');

        its

        
    h=figure;
    set(h, 'Visible', 'off');
    trisurf(element_index,lon,lat,ssh(:,its)+5)
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
    saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/TideCase/Image_ap1/temp_%d.png',its));
    
    
%     
%            h=figure;
%            set(h, 'Visible', 'off');
%            %figure;     
%            trisurf(element_index,lon,lat,ssh(:,its)-m_ssh)
%            view(0,90);shading interp;     
%            colormap(jet);colorbar;axis equal
%            title(['\color{red}SP: ',timestamp],'FontSize',22);
%            %title(['\color{blue}FC: ',timestamp],'FontSize',22);
%            xlabel('Longitude (deg)','FontSize',22);
%            ylabel('Latitude (deg)','FontSize',22);
%            axis([min_lon max_lon min_lat max_lat]);
%            %axis([XMIN XMAX YMIN YMAX])
%            caxis([-2 2]);
%            %caxis([14. 17.5]); %Dardanelli
%          %  caxis([8. 17.]); %GOROTOT
%            %caxis([16. 19.]); %Gibilterra
%            %caxis([16.5 20.]); %Sicily
%            %caxis([12.5 19.5]); %Otranto
%            %caxis([17. 21.]); %Egeo
%            %caxis([6. 13.5]); %Azov
%            hcb=colorbar;
%            title(hcb,'h(m)','fontsize', 18)
%            box on;
%            grid on;
%            graph_handle= gca;
%            set(graph_handle,'fontsize', 22)
%            set(graph_handle,'linewidth', 1)   
%            %print(gcf, '-dtiff', 'myfigure.tiff');
%            %saveas(h,sprintf('/Users/ifederico/Desktop/figurerun/FIG3D%d.png',its));        
%            saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/TideCase/Image_ap2/temp_%d.png',its));


end

   