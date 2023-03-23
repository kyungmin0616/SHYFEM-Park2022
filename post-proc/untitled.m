clear
clc

nc_name = '/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/TideCase/ampli3_ous_lev0.nc';


LON0 = ncread(nc_name, 'longitude');
LAT0 = ncread(nc_name, 'latitude');
DEPTH =ncread(nc_name, 'depth');
SSH=ncread(nc_name, 'water_level');

[LON,LAT]=meshgrid(LON0,LAT0);
LON=LON'; LAT=LAT';


[no na nd nt]=size(SSH)

startdate ='2019-05-28 00:00:00';
refdate=datenum(startdate);

il =1;

for its=1:nt 
    
timestamp=datestr(refdate+((its-1)/24),'yyyy-mm-dd HH:MM:SS');


        its

   
           figure(1);
           clf
           pcolorjw(LON, LAT, SSH(:,:,1,its));
           hold on; 
           colormap(jet);  
           colorbar
%            axis equal
           title(['\color{red} ',timestamp],'FontSize',22);
           xlabel('Longitude (deg)','FontSize',22);
           ylabel('Latitude (deg)','FontSize',22);
           axis([min(LON0) max(LON0) min(LAT0) max(LAT0)]);
%            title(hcb,'m','fontsize', 18)
           caxis([0 4])   
           tic,pause(0.1),toc

end
 
