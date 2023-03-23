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


%ncid = netcdf.open(['/Users/ifederico/Desktop/Sav01sshjx_nos0.nc'],'NC_NOWRITE');
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/Savannah_nos.nc'],'NC_NOWRITE');

%ncid = netcdf.open(['/Users/ifederico/Desktop/ser_nos.nc'],'NC_NOWRITE');


% il = 1;    % select layer_id for map plot
% ik = 70500; % select node_id for profile plot
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
end;

% tout=3;
% ntimes = length(field{3}.data);
% if tout>ntimes
%     display(['***ERROR: Requested time index exceeds available output times (' num2str(ntimes) ')'])
%     return;
% end


fac = 1.0;

[nl nn nt]=size(field{6}.data)


% parameters for map
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
bathy=field{9}.data;



min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;


depth=-field{9}.data;


h= figure;
   trisurf(element_index,lon,lat,-bathy)
   %%
   view(0,90);shading interp;     
   colormap(jet);colorbar;axis equal
   title('Bathymetry (m) ','FontSize',22);
   xlabel('Longitude ','FontSize',22)
   ylabel('Latitude ','FontSize',22)


   


 its=1;
 il=1;
%for its=1:nt;
%for il=1:10 %nl
for its=1:3:nt
%for its=670:670 

    its
tempmap=field{6}.data(il,:,its);
tempmap(tempmap == 0) = NaN;
saltmap=field{5}.data(il,:,its);
saltmap(saltmap == 0) = NaN;
   
   h=figure;
   set(h, 'Visible', 'off');
   %figure;                                                             
   trisurf(element_index,lon,lat,tempmap)
   view(0,90);shading interp;     
   colormap(jet);colorbar;axis equal
   title('Temperature (deg-C) ','FontSize',22);
   xlabel('Longitude (deg)','FontSize',22);
   ylabel('Latitude (deg)','FontSize',22);
   axis([min_lon max_lon min_lat max_lat]);
   %axis([XMIN XMAX YMIN YMAX])
   caxis([13 21]);
   %caxis([14. 17.5]); %Dardanelli
   %caxis([19. 26.]); %GOROTOT
   %caxis([16. 19.]); %Gibilterra
   %caxis([16.5 20.]); %Sicily
   %caxis([13. 18.5]); %Otranto
   %caxis([17. 21.]); %Egeo
   %caxis([6. 13.5]); %Azov
   box on;
   grid on;
   graph_handle= gca;
   set(graph_handle,'fontsize', 22)
   set(graph_handle,'linewidth', 1)   
   %print(gcf, '-dtiff', 'myfigure.tiff');
   %saveas(h,sprintf('/Users/ifederico/Desktop/figurerun/FIG3D%d.png',its));
   saveas(h,sprintf('/Users/ifederico/Desktop/SavH/temp_%d.png',its));


%    h=figure;
%   set(h, 'Visible', 'off');
%    %figure;                                                             
%    trisurf(element_index,lon,lat,saltmap)
%    view(0,90);shading interp;     
%    colormap(jet);colorbar;axis equal
%    title('Salinity  ','FontSize',22);
%    xlabel('Longitude (deg)','FontSize',22)
%    ylabel('Latitude (deg)','FontSize',22)
%    %axis([XMIN XMAX YMIN YMAX])
%    %axis([min_lon max_lon min_lat max_lat])
%    caxis([32 35.5]);
%    %caxis([7. 17.]); %Maramara and straits
%    %caxis([8. 15.]); %Dardanelli
%    %caxis([15 27.]); %Bosforo
%    %caxis([16. 19.]); %Gibilterra
%    %caxis([16. 19.]); %Sicily
%    %caxis([13. 18.5]); %Otranto
%    %caxis([15. 18.]); %Egeo
%    %caxis([3. 9.]); %Azov
%    box on;
%    grid on;
%    %print(gcf, '-dtiff', 'myfigure.tiff');
%    graph_handle= gca;
%    set(graph_handle,'fontsize', 22)
%    set(graph_handle,'linewidth', 1)  
%    
%       saveas(h,sprintf('/Users/ifederico/Desktop/Sav0/saltSav_%d.png',its));

end

  return
tempmap1=field{6}.data(il,:,1);
tempmap2=field{6}.data(il,:,4);



difftemp = tempmap2 - tempmap1;
 figure;                                                             
   trisurf(element_index,lon,lat,difftemp)
   view(0,90);shading interp;     
   colormap(jet);colorbar;axis equal
   title('Temperature (deg-C) ');
   xlabel('Longitude (deg)')
   ylabel('Latitude (deg)')
   box on;
   grid on;
   caxis([-1 1]);

return
%for it=1:nt

% parameters for profiles
Tprof=field{6}.data(:,ik,1);
Tprof(Tprof == 0) = NaN;

tjk = ~isnan(Tprof);
kk=0
for i=1:length(Tprof)
   if(tjk(i) == 1)
    kk=kk+1;   
    Tprof1(kk)=Tprof(i);
    depth1(kk)=depth(i);
   end
end
   
   
figure;
plot(Tprof1,depth1,'o-r','LineWidth',1, 'MarkerSize',10)
% hold on
% plot(uvModMossaMM1,-levels1,'s-b','LineWidth',1, 'MarkerSize',10)
box on
grid on
%axis([14.6 14.67 -70 0])
ylabel('depth (m)','FontSize',30);
xlabel('Temperature (deg-C)','FontSize',30);
%legend('obs','SANIFS results')
%legend('Obs','SANIFS')
graph_handle= gca;
set(graph_handle,'fontsize', 30)
set(graph_handle,'linewidth', 1)
%title('MREA2014, Mar Grande, 01-10/10/2014 ','Fontsize',30)

%end
   