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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/NCFiles/matthew-ng-wo-tide.nc'],'NC_NOWRITE');



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


startDate=-81.5;
endDate=-80.3;

ASCII_mat(:,1)=lon;
ASCII_mat(:,2)=lat;
ASCII_mat(:,3)=depth;

for i=1:length(lon)-1
    
    dist=lon(i+1,1)-lon(i,1);
    
end



dlmwrite('/Users/kpark350/Downloads/arcgis_shyfem.txt', ASCII_mat, '\t');
%%
rectangle('Position',[-81.4 31.2 1 1.3],'LineStyle','--','EdgeColor','r','LineWidth',3);hold on

plot_google_map('MapType','satellite','MapScale', 1,'AutoAxis',0,'ScaleLocation','s','Refresh',0,'ShowLabels',0);
axis([-81.4 -80.4 31.2 32.5]) % axis criterian

graph_handle= gca;
xticks(-81.4:0.2:80.4)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:.2:32.5)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
% xlabel('Longitude')
% ylabel('Latitude')

set(gca,'FontSize',22); 
set(gcf,'color','w');

contour(z,'showtext', 'on','color','b');
saveas(gcf, 'contour.png');
F = getframe(gca);
imwrite(F.cdata, 'contour.png');

k = kml('image.kml');
k.overlay(-81.5, -80.3, 31.1, 32.5, 'file','contour.png');

%% Bathy
hold on


h= figure('units','normalized','position',[0 0 0.35 1]);
set(h, 'Visible', 'on');

trisurf(element_index,lon,lat,depth+10); hold on
shading interp;     
view(0,90);
caxis([0 32])
set(gca, 'Color', 'none');
export_fig('test2', '-png', '-tif');

logo;
alpha(0.5);
export_fig('test2', '-png', '-tif', '-transparent');


k = kml('image.kml');
k.overlay(-81.5, -80.3, 31.1, 32.5, 'file','test2.png');
k.run;



hcb=colorbar;
title(hcb,'Depth (m)')
rectangle('Position',[-81.4 31.35 0.25 0.22],'LineStyle','--','EdgeColor','r','LineWidth',3)
rectangle('Position',[-81.15 31.93 0.33 0.21],'LineStyle','--','EdgeColor','r','LineWidth',3)


h1=plot(-80.902494, 32.03455,'or','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r');hold on
h2=plot(-81.0069444444444, 32.1030555555556,'or','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r');hold on
h3=plot(-81.1283333333333, 32.1160833333333,'or','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r');hold on
h4=plot(-81.36277778, 31.45333333,'or','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','r');hold on

legend([h1],'Observations','Location','NorthWest')

set(gca,'XLim',[startDate endDate],'XTick',[startDate:0.2:endDate])
set(gca,'YLim',[31.1 32.5],'YTick',[31.1:0.2:32.5])
axis([-81.45 -80.35 min_lat max_lat]);
box on;
graph_handle= gca;
xticks(-81.4:0.2:80.1)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.2:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
xlabel('Longitude')
ylabel('Latitude')

set(graph_handle,'fontsize', 26)
set(graph_handle,'linewidth', 1) 

sp_width= 0.72;
sp_height= 0.88;
x_gap=0.015;
x1 = 0.15;
y1 = 0.085;


set(graph_handle,'Position',[x1 y1 sp_width sp_height])


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure5_a.png'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sapelo Island %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h= figure('units','normalized','position',[0 0 0.36 0.8]);
set(h, 'Visible', 'off');

trisurf(element_index,lon,lat,-depth); hold on
caxis([-22 0])
view(0,90);
% axis([-81.34 -81.16 31.35 31.57])
axis([-81.4 -81.4+0.25 31.35 31.57])

plot(-81.36277778, 31.45333333,'or','MarkerSize',14,'MarkerFaceColor','r','MarkerEdgeColor','r');hold on
rectangle('Position',[-81.4 31.35 0.25 0.22],'LineStyle','--','EdgeColor','r','LineWidth',3)

box on;
graph_handle= gca;
set(graph_handle,'linewidth', 1)  
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0;

sp_width= 0.247*4;
sp_height= 0.248*4;
x_gap=0.015;
x1 = 0.005;
y1 = 0.005;
x_os=0;
y_os=0;

set(graph_handle,'Position',[x1+x_os y1+y_os sp_width sp_height])

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure5_b.png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Tybee Island %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h= figure('units','normalized','position',[0 0 0.4 0.6]);
set(h, 'Visible', 'off');
trisurf(element_index,lon,lat,-depth); hold on
caxis([-22 0])
view(0,90);
% axis([-80.94 -80.83 31.93 32.05])
axis([-81.15 -81.15+0.33 31.93 31.93+0.21])

plot(-80.902494, 32.03455,'or','MarkerSize',14,'MarkerFaceColor','r','MarkerEdgeColor','r');hold on
plot(-81.0069444444444, 32.1030555555556,'or','MarkerSize',14,'MarkerFaceColor','r','MarkerEdgeColor','r');hold on
plot(-81.1283333333333, 32.1160833333333,'or','MarkerSize',14,'MarkerFaceColor','r','MarkerEdgeColor','r');hold on
rectangle('Position',[-81.15 31.93 0.33 0.21],'LineStyle','--','EdgeColor','r','LineWidth',3)

% lat_s = 32.03455;
% lon_s = -80.902494;

box on;
graph_handle= gca;
set(graph_handle,'linewidth', 1)  
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0;
set(graph_handle,'linewidth', 1) 


sp_width= 0.395*2.5;
sp_height= 0.39*2.5;
x_gap=0.015;
x1 = 0.005;
y1 = 0.02;
set(gcf,'color','w')

set(graph_handle,'Position',[x1 y1 sp_width sp_height])

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure5_c.png'));


