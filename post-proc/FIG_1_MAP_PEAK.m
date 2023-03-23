close all

%% Google map

load /Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/GoogleMap/ggmap_entire.mat
clf
figure(1)
axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)

%% Peak Level

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% W/ Difference %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fw=0.55;
fh=1;
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');


stt=24*3;
edt=24*5;
adj_diff=50;

h1=subplot(2,3,1);

axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;

trisurf(element_index,lon,lat,max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([1.35 2.7]);
box on;
grid on;
% hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
xticks(-81.4:0.2:80.1)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.2:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,getpmap(7))
% 

h2=subplot(2,3,2);

axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;

trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
title('\color{black}MT-ST6H','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([1.35 2.7]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,getpmap(7))

h3=subplot(2,3,3);

axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;

trisurf(element_index,lon,lat,(max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))./max(ssh1(:,stt:edt),[],2)*100+adj_diff)
% trisurf(element_index,lon,lat,max(ssh2(:,stt:edt),[],2)-max(ssh1(:,stt:edt),[],2))
% 
view(0,90);shading interp;     
% axis equal
title('\color{black}Change in peak level','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
% caxis([-30 35]);
box on;
grid on;
hcb=colorbar;
% hcb.Ticks=[-30 -20 -10 0 10 20 30 35];
title(hcb,'%','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h4=subplot(2,3,4);

axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;

trisurf(element_index,lon,lat,max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
title('\color{black}DR-ST','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([1.35 2.7]);
box on;
grid on;
% hcb=colorbar;
% title(hcb,'m','fontsize', 18)
graph_handle= gca;
xticks(-81.4:0.2:80.1)
xtickformat('%.1f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.2:0.2:32.4)
ytickformat('%.1f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,getpmap(7))

h5=subplot(2,3,5);

axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;

trisurf(element_index,lon,lat,max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
title('\color{black}DR-ST6H','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
caxis([1.35 2.7]);
box on;
grid on;
hcb=colorbar;
title(hcb,'m','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,getpmap(7))

h6=subplot(2,3,6);

axHandle = gca;
hold(axHandle, 'on');
h = image(lonVec,latVec,imag,'Parent', axHandle);
set(axHandle,'YDir','Normal')
set(h,'tag','gmap')
set(h,'AlphaData',1)
hold on;

trisurf(element_index,lon,lat,(max(sshd2(:,stt:edt),[],2)-max(sshd1(:,stt:edt),[],2))./max(sshd1(:,stt:edt),[],2)*100+adj_diff);hold on
view(0,90); shading interp;     
title('\color{black}Change in peak level','FontSize',22);
axis([-81.45 -80.35 min_lat max_lat]);
% caxis([-10 15]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,turbo)

sp_width= 0.15/fw;
sp_height= 0.43/fh;
x_gap=0.015;
x1 = 0.05;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.05;
y1 = 0.55;
y2 = 0.05;
x_os=0;
y_os=-0.02;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h4,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x3+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.


saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StormTide/Figures/Figure_1.png',1));



