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
ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/switchv2_ous0.nc'],'NC_NOWRITE');



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

%% Bathy

h= figure('units','normalized','position',[0 0 0.7 1]);
set(h, 'Visible', 'on');

clf

trisurf(element_index,lon,lat,-depth,'FaceAlpha','0'); hold on
view(0,90);


shading interp;    

% colormap(jet);
% colorbar;
demcmap([-3000 0]);
colb=colorbar;

rectangle('Position',[-81.42 31.8 0.72 0.47],'LineStyle','--','EdgeColor','k','LineWidth',3)
% axis equal
xlabel('Longitude ','FontSize',22)
ylabel('Latitude ','FontSize',22)
% axis([min_lon max_lon min_lat max_lat])
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/10:endDate])
set(gca,'XLim',[startDate endDate],'XTick',[startDate:0.2:endDate])
set(gca,'YLim',[31.1 32.5],'YTick',[31.1:0.2:32.5])
caxis([-25 0])
hcb=colorbar;
box on;
% grid on;
graph_handle= gca;
title(hcb,'Depth (m)','fontsize', 34)
set(graph_handle,'fontsize', 38)
set(graph_handle,'linewidth', 1)   
saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/fig_4_a.png'));


h= figure('units','normalized','position',[0 0 0.7 1]);
set(h, 'Visible', 'on');

h= figure('units','normalized','position',[0 0 0.7 1]);
set(h, 'Visible', 'off');

clf
trisurf(element_index,lon,lat,-depth); hold on
view(0,90);
shading interp;     
colormap(jet);
colorbar;
% axis equal
% xlabel('Longitude ','FontSize',22)
% ylabel('Latitude ','FontSize',22)
% axis([min_lon max_lon min_lat max_lat])
% set(gca,'XLim',[startDate endDate],'XTick',[startDate:(endDate-startDate)/10:endDate])
axis([-81.42 -80.7 31.8 32.27])
caxis([-15 0])
hcb=colorbar;
box on;
% grid on;
graph_handle= gca;
title(hcb,'Depth (m)','fontsize', 34)
set(graph_handle,'fontsize', 38)
set(graph_handle,'linewidth', 1) 
saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/fig_4_a_1.png'));



%% Grid

% trisurf(element_index,lon,lat,-depth,'FaceColor','white'); hold on

h= figure('units','normalized','position',[0 0 0.35 1]);
set(h, 'Visible', 'off');
clf

trisurf(element_index,lon,lat,-depth); hold on
view(0,90);
caxis([-22 0])
hcb=colorbar;
title(hcb,'Depth (m)')
rectangle('Position',[-81.34 31.35 0.18 0.22],'LineStyle','--','EdgeColor','r','LineWidth',3)
rectangle('Position',[-80.94 31.93 0.11 0.12],'LineStyle','--','EdgeColor','r','LineWidth',3)

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

set(graph_handle,'fontsize', 28)
set(graph_handle,'linewidth', 1) 

sp_width= 0.75;
sp_height= 0.91;
x_gap=0.015;
x1 = 0.12;
y1 = 0.05;
x_os=0;
y_os=0;

set(graph_handle,'Position',[x1+x_os y1+y_os sp_width sp_height])


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/fig_5_a.png'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sapelo Island %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


rectangle('Position',[-81.34 31.35 0.18 0.22],'LineStyle','--','EdgeColor','r','LineWidth',3)


h= figure('units','normalized','position',[0 0 0.35 1]);
set(h, 'Visible', 'off');

clf
trisurf(element_index,lon,lat,-depth); hold on
caxis([-22 0])
view(0,90);
axis([-81.34 -81.16 31.35 31.57])

box on;
graph_handle= gca;
set(graph_handle,'linewidth', 1)  
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
ax = gca;
ax.GridLineStyle = '--';
ax.GridAlpha = 0;

sp_width= 0.18*4;
sp_height= 0.22*4;
x_gap=0.015;
x1 = 0.05;
y1 = 0.02;
x_os=0;
y_os=0;

set(graph_handle,'Position',[x1+x_os y1+y_os sp_width sp_height])

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/fig_5_b2.png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Tybee Island %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rectangle('Position',[-80.94 31.93 0.11 0.12],'LineStyle','--','EdgeColor','r','LineWidth',3)

h= figure('units','normalized','position',[0 0 0.35 1]);
set(h, 'Visible', 'off');
plot(-80.902494, 32.03455,'or','MarkerSize',20,'MarkerFaceColor','r','MarkerEdgeColor','r');hold on
trisurf(element_index,lon,lat,-depth);
caxis([-22 0])
view(0,90);
axis([-80.94 -80.83 31.93 32.05])

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


sp_width= 0.11*4;
sp_height= 0.12*4;
x_gap=0.015;
x1 = 0.05;
y1 = 0.02;
x_os=0;
y_os=0;
set(gcf,'color','w')

set(graph_handle,'Position',[x1+x_os y1+y_os sp_width sp_height])

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/Figures/fig_5_d2.png'));


