
%% NL when peak occur
stt=24*3;
edt=24*5;

clear NL_MT OT_MT ST_MT NL_MT_6H OT_MT_6H ST_MT_6H NL_DR OT_DR ST_DR NL_DR_6H OT_DR_6H ST_DR_6H

% storm tide timing
for i=1:length(ssh1(:,1))
    
    [M,mi1]=max(ssh1(i,stt:edt));
    NL_MT(i,1)=ssh1(i,stt+mi1-1)-(ssh3(i,stt+mi1-1)+ssh5(i,stt+mi1-1));
    OS_MT(i,1)=ssh3(i,stt+mi1-1);
    OT_MT(i,1)=ssh5(i,stt+mi1-1);
    
    [M,mi2]=max(ssh2(i,stt:edt));
    NL_MT_6H(i,1)=ssh2(i,stt+mi2-1)-(ssh4(i,stt+mi2-1)+ssh5(i,stt+mi2-1));
    OS_MT_6H(i,1)=ssh4(i,stt+mi2-1);
    
    [M,di1]=max(sshd1(i,stt:edt));
    NL_DR(i,1)=sshd1(i,stt+di1-1)-(sshd3(i,stt+di1-1)+sshd5(i,stt+di1-1));
    OS_DR(i,1)=sshd3(i,stt+di1-1);
    OT_DR(i,1)=sshd5(i,stt+di1-1);
    
    [M,di2]=max(sshd2(i,stt:edt));
    NL_DR_6H(i,1)=sshd2(i,stt+di2-1)-(sshd4(i,stt+di2-1)+sshd5(i,stt+di2-1));
    OS_DR_6H(i,1)=sshd4(i,stt+di2-1);
    
end

IV = find(lon>=-81.16 & lon <= -80.84 & lat >=31.94 & lat <=32.26);
IP = find(lon>=-81.4 & lon <= -81.15 & lat >=31.35 & lat <=31.6);


clear t_mt t_mt_6h t_dr t_dr_6h
t_mt=ssh1(IP,48:end);
t_mt_6h=ssh2(IP,48:end);
t_dr=sshd1(IP,48:end);
t_dr_6h=sshd2(IP,48:end);

clear mi1 mi2 di1 di2
for i=1:length(IP)
    
    [M,mi1(i)]=max(t_mt(i,:));
    
    [M,mi2(i)]=max(t_mt_6h(i,:));
    
    [M,di1(i)]=max(t_dr(i,:));

    [M,di2(i)]=max(t_dr_6h(i,:));

    
end


figure(3)
clf
subplot(2,2,1)
hist(mi1)
subplot(2,2,2)
hist(mi2)
subplot(2,2,3)
hist(di1)
subplot(2,2,4)
hist(di2)
% % storm surge timing
% for i=1:length(ssh1(:,1))
%     
%     [M,mi]=max(ssh5(i,stt:edt));
%     NL_MT(i,1)=ssh1(i,stt+mi-1)-(ssh3(i,stt+mi-1)+ssh5(i,stt+mi-1));
%     NL_MT_6H(i,1)=ssh2(i,stt+mi-1)-(ssh4(i,stt+mi-1)+ssh5(i,stt+mi-1));
%     
%     [M,di]=max(sshd5(i,stt:edt));
%     NL_DR(i,1)=sshd1(i,stt+di-1)-(sshd3(i,stt+di-1)+sshd5(i,stt+di-1));
%     NL_DR_6H(i,1)=sshd2(i,stt+di-1)-(sshd4(i,stt+di-1)+sshd5(i,stt+di-1));
%     
% end

IV = find(lon>=-81.16 & lon <= -80.84 & lat >=31.94 & lat <=32.26);
IP = find(lon>=-81.4 & lon <= -81.1 & lat >=31.3 & lat <=31.6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Both view (SAV AND SAP) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v_lons=-81.16;
v_lone=-80.84;
v_lats=31.94;
v_late=32.26;
p_lons=-81.4;
p_lone=-81.15;
p_lats=31.35;
p_late=31.6;

fw=0.4;
fh=1;
% SAV

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf
h1=subplot(4,3,1);
trisurf(element_index,lon,lat,NL_MT*100)
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for original tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
% caxis([-15 2]);
caxis([-20 0]);
graph_handle= gca;
colormap(graph_handle,parula)
xticks(-81.2:0.2:80.8)
xtickformat('%.2f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.85:0.2:32.25)
ytickformat('%.2f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% view(0,90);shading interp;     
% set(gcf,'color','y');
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h2=subplot(4,3,2);
trisurf(element_index,lon,lat,NL_MT_6H*100)
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
caxis([-20 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% colormap(graph_handle,bluewhitered)
colormap(graph_handle,parula)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

h3=subplot(4,3,3);
% trisurf(element_index,lon,lat,NL_MT_6H*100-NL_MT*100)
% trisurf(element_index,lon,lat,((NL_MT_6H-NL_MT)./abs(NL_MT))*100)
% trisurf(element_index,lon,lat,((abs(NL_MT_6H)-abs(NL_MT))./abs(NL_MT))*100)
trisurf(element_index,lon,lat,((abs(NL_MT_6H)-abs(NL_MT))*100))
view(0,90);shading interp;     
% axis equal
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-7 4]); % difference in cm
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,BWR2)
% colormap(graph_handle,parula)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h4=subplot(4,3,4);
trisurf(element_index,lon,lat,NL_DR*100)
view(0,90);shading interp;     
% title('\color{black}TSI for original tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-25 0]);
graph_handle= gca;
colormap(graph_handle,parula)
xticks(-81.3:0.25:80.8)
yticks(31.8:0.25:32.3)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h5=subplot(4,3,5);
trisurf(element_index,lon,lat,NL_DR_6H*100)
view(0,90);shading interp;     
% colormap(parula)
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-25 0]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,parula)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

h6=subplot(4,3,6);
trisurf(element_index,lon,lat,(abs(NL_DR_6H)-abs(NL_DR))*100)
view(0,90);shading interp;     
% title('\color{black}Change in TSI','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-12 4]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
colormap(graph_handle,BWR2)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

% Sapelo

h7=subplot(4,3,7);
trisurf(element_index,lon,lat,NL_MT*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
box on;
grid on;
caxis([-20 0]);
graph_handle= gca;
xticks(-81.4:0.15:81.1)
xtickformat('%.2f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.3:0.15:31.6)
ytickformat('%.2f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,parula)

h8=subplot(4,3,8);
trisurf(element_index,lon,lat,NL_MT_6H*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST6H','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-20 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,parula)

h9=subplot(4,3,9);
trisurf(element_index,lon,lat,(abs(NL_MT_6H)-abs(NL_MT))*100)
view(0,90);shading interp;     
% title('\color{black}Diff.','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-5 8]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,BWR2)


h10=subplot(4,3,10);
trisurf(element_index,lon,lat,NL_DR*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
box on;
grid on;
caxis([-20 0]);
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
view(0,90);shading interp;     
% set(gcf,'color','y');
colormap(graph_handle,parula)

h11=subplot(4,3,11);
trisurf(element_index,lon,lat,NL_DR_6H*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST6H','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-20 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,parula)

h12=subplot(4,3,12);
trisurf(element_index,lon,lat,(abs(NL_DR_6H)-abs(NL_DR))*100)
view(0,90);shading interp;     
% title('\color{black}Diff.','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-5 7]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,BWR2)
set(gcf,'color','w');
% set(gca,'Color',[0.5, 0.5, 0.5])


sp_width= 0.09/fw;
sp_height= 0.2/fh;
x_gap=0.015;
y_gap=0.05;
x1 = 0.09;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.08;
y1 = 0.79;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;
y4 = y3-sp_height-y_gap;


x_os=0;
y_os=-0.02;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h4,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x3+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h7,'Position',[x1+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x2+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h9,'Position',[x3+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h10,'Position',[x1+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h11,'Position',[x2+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h12,'Position',[x3+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Figures_StormTide/Figures/Figure_3.png',1));


%%


fw=0.4;
fh=1;
% SAV

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'off');

h1=subplot(4,3,1);
trisurf(element_index,lon,lat,NL_MT./max_MT*100)
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for original tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
% caxis([-15 2]);
caxis([-15 0]);
graph_handle= gca;
colormap(graph_handle,parula)
xticks(-81.2:0.2:80.8)
xtickformat('%.2f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.85:0.2:32.25)
ytickformat('%.2f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% view(0,90);shading interp;     
% set(gcf,'color','y');
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h2=subplot(4,3,2);
trisurf(element_index,lon,lat,NL_MT_6H./max_MT_6H*100)
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
caxis([-15 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% colormap(graph_handle,bluewhitered)
colormap(graph_handle,parula)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

h3=subplot(4,3,3);
% trisurf(element_index,lon,lat,NL_MT_6H*100-NL_MT*100)
% trisurf(element_index,lon,lat,((NL_MT_6H-NL_MT)./abs(NL_MT))*100)
% trisurf(element_index,lon,lat,((abs(NL_MT_6H)-abs(NL_MT))./abs(NL_MT))*100)
trisurf(element_index,lon,lat,((abs(NL_MT_6H)-abs(NL_MT))*100))
view(0,90);shading interp;     
% axis equal
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
% caxis([-7 4]); % difference in cm
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,BWR2)
% colormap(graph_handle,parula)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h4=subplot(4,3,4);
trisurf(element_index,lon,lat,NL_DR./max_DR*100)
view(0,90);shading interp;     
% title('\color{black}TSI for original tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-15 0]);
graph_handle= gca;
colormap(graph_handle,parula)
xticks(-81.3:0.25:80.8)
yticks(31.8:0.25:32.3)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h5=subplot(4,3,5);
trisurf(element_index,lon,lat,NL_DR_6H./max_DR_6H*100)
view(0,90);shading interp;     
% colormap(parula)
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-15 0]);
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,parula)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

h6=subplot(4,3,6);
trisurf(element_index,lon,lat,(abs(NL_DR_6H)-abs(NL_DR))*100)
view(0,90);shading interp;     
% title('\color{black}Change in TSI','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
% caxis([-12 4]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
colormap(graph_handle,BWR2)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

% Sapelo

h7=subplot(4,3,7);
trisurf(element_index,lon,lat,NL_MT./max_MT*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
box on;
grid on;
caxis([-15 0]);
graph_handle= gca;
xticks(-81.4:0.15:81.1)
xtickformat('%.2f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.3:0.15:31.6)
ytickformat('%.2f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,parula)

h8=subplot(4,3,8);
trisurf(element_index,lon,lat,NL_MT_6H./max_MT_6H*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST6H','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-15 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,parula)

h9=subplot(4,3,9);
trisurf(element_index,lon,lat,(abs(NL_MT_6H)-abs(NL_MT))*100)
view(0,90);shading interp;     
% title('\color{black}Diff.','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
% caxis([-5 8]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,BWR2)


h10=subplot(4,3,10);
trisurf(element_index,lon,lat,NL_DR./max_DR*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
box on;
grid on;
caxis([-15 0]);
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
view(0,90);shading interp;     
% set(gcf,'color','y');
colormap(graph_handle,parula)

h11=subplot(4,3,11);
trisurf(element_index,lon,lat,NL_DR_6H./max_DR_6H*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST6H','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-15 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'%','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,parula)

h12=subplot(4,3,12);
trisurf(element_index,lon,lat,(abs(NL_DR_6H)-abs(NL_DR))*100)
view(0,90);shading interp;     
% title('\color{black}Diff.','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
% caxis([-5 7]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,BWR2)
set(gcf,'color','w');
% set(gca,'Color',[0.5, 0.5, 0.5])


sp_width= 0.09/fw;
sp_height= 0.2/fh;
x_gap=0.015;
y_gap=0.05;
x1 = 0.09;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.08;
y1 = 0.79;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;
y4 = y3-sp_height-y_gap;


x_os=0;
y_os=-0.02;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h4,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x3+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h7,'Position',[x1+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x2+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h9,'Position',[x3+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h10,'Position',[x1+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h11,'Position',[x2+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h12,'Position',[x3+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Figures_StormTide/Figures/Figure_3_perct.png',1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Both view (SAV AND SAP) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v_lons=-81.16;
v_lone=-80.84;
v_lats=31.94;
v_late=32.26;
p_lons=-81.4;
p_lone=-81.15;
p_lats=31.35;
p_late=31.6;

fw=0.4;
fh=1;
% SAV

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf
h1=subplot(4,3,1);
trisurf(element_index,lon,lat,NL_MT*100)
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for original tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
% caxis([-15 2]);
caxis([-20 0]);
graph_handle= gca;
colormap(graph_handle,parula)
xticks(-81.2:0.2:80.8)
xtickformat('%.2f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.85:0.2:32.25)
ytickformat('%.2f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% view(0,90);shading interp;     
% set(gcf,'color','y');
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h2=subplot(4,3,2);
trisurf(element_index,lon,lat,NL_MT_6H*100)
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
caxis([-20 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% colormap(graph_handle,bluewhitered)
colormap(graph_handle,parula)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

h3=subplot(4,3,3);
% trisurf(element_index,lon,lat,NL_MT_6H*100-NL_MT*100)
% trisurf(element_index,lon,lat,((NL_MT_6H-NL_MT)./abs(NL_MT))*100)
% trisurf(element_index,lon,lat,((abs(NL_MT_6H)-abs(NL_MT))./abs(NL_MT))*100)
trisurf(element_index,lon,lat,((abs(NL_MT_6H)-abs(NL_MT))*100))
view(0,90);shading interp;     
% axis equal
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-7 4]); % difference in cm
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,BWR2)
% colormap(graph_handle,parula)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h4=subplot(4,3,4);
trisurf(element_index,lon,lat,NL_DR*100)
view(0,90);shading interp;     
% title('\color{black}TSI for original tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-25 0]);
graph_handle= gca;
colormap(graph_handle,parula)
xticks(-81.3:0.25:80.8)
yticks(31.8:0.25:32.3)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h5=subplot(4,3,5);
trisurf(element_index,lon,lat,NL_DR_6H*100)
view(0,90);shading interp;     
% colormap(parula)
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-25 0]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,parula)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

h6=subplot(4,3,6);
trisurf(element_index,lon,lat,(abs(NL_DR_6H)-abs(NL_DR))*100)
view(0,90);shading interp;     
% title('\color{black}Change in TSI','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
caxis([-12 4]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
colormap(graph_handle,BWR2)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

% Sapelo

h7=subplot(4,3,7);
trisurf(element_index,lon,lat,NL_MT*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
box on;
grid on;
caxis([-20 0]);
graph_handle= gca;
xticks(-81.4:0.15:81.1)
xtickformat('%.2f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.3:0.15:31.6)
ytickformat('%.2f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,parula)

h8=subplot(4,3,8);
trisurf(element_index,lon,lat,NL_MT_6H*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST6H','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-20 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,parula)

h9=subplot(4,3,9);
trisurf(element_index,lon,lat,(abs(NL_MT_6H)-abs(NL_MT))*100)
view(0,90);shading interp;     
% title('\color{black}Diff.','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-5 8]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,BWR2)


h10=subplot(4,3,10);
trisurf(element_index,lon,lat,NL_DR*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
box on;
grid on;
caxis([-20 0]);
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
view(0,90);shading interp;     
% set(gcf,'color','y');
colormap(graph_handle,parula)

h11=subplot(4,3,11);
trisurf(element_index,lon,lat,NL_DR_6H*100)
view(0,90);shading interp;     
% title('\color{black}MT-ST6H','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-20 0]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,parula)

h12=subplot(4,3,12);
trisurf(element_index,lon,lat,(abs(NL_DR_6H)-abs(NL_DR))*100)
view(0,90);shading interp;     
% title('\color{black}Diff.','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
caxis([-5 7]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,BWR2)
set(gcf,'color','w');
% set(gca,'Color',[0.5, 0.5, 0.5])


sp_width= 0.09/fw;
sp_height= 0.2/fh;
x_gap=0.015;
y_gap=0.05;
x1 = 0.09;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.08;
y1 = 0.79;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;
y4 = y3-sp_height-y_gap;


x_os=0;
y_os=-0.02;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h4,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x3+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h7,'Position',[x1+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x2+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h9,'Position',[x3+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h10,'Position',[x1+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h11,'Position',[x2+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h12,'Position',[x3+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Both view (SAV AND SAP) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v_lons=-81.16;
v_lone=-80.84;
v_lats=31.94;
v_late=32.26;
p_lons=-81.4;
p_lone=-81.15;
p_lats=31.35;
p_late=31.6;

fw=0.4;
fh=1;
% SAV

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf
h1=subplot(2,2,1);
trisurf(element_index,lon,lat,NL_MT*100-NL_DR*100)
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for original tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
box on;
grid on;
% caxis([-15 2]);
caxis([-1 10]);
graph_handle= gca;
colormap(graph_handle,turbo)
xticks(-81.2:0.2:80.8)
xtickformat('%.2f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.85:0.2:32.25)
ytickformat('%.2f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% view(0,90);shading interp;     
% set(gcf,'color','y');
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot
colorbar

h2=subplot(2,2,2);
trisurf(element_index,lon,lat,NL_MT_6H*100-NL_DR_6H*100)
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([v_lons v_lone v_lats v_late]); % Sav
caxis([-1 10]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% colormap(graph_handle,bluewhitered)
colormap(graph_handle,turbo)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot
colorbar


h3=subplot(2,2,3);
trisurf(element_index,lon,lat,NL_MT*100-NL_DR*100)
view(0,90);shading interp;     
% title('\color{black}TSI for original tide','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
box on;
grid on;
caxis([-1 10]);
graph_handle= gca;
colormap(graph_handle,turbo)
xticks(-81.3:0.25:80.8)
yticks(31.8:0.25:32.3)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot
colorbar

h4=subplot(2,2,4);
trisurf(element_index,lon,lat,NL_MT_6H*100-NL_DR_6H*100)
view(0,90);shading interp;     
% colormap(parula)
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([p_lons p_lone p_lats p_late]); % Sap
box on;
grid on;
caxis([-1 10]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,turbo)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot
colorbar

sp_width= 0.09/fw;
sp_height= 0.2/fh;
x_gap=0.015;
y_gap=0.05;
x1 = 0.09;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap+0.08;
y1 = 0.79;
y2 = y1-sp_height-y_gap;
y3 = y2-sp_height-y_gap;
y4 = y3-sp_height-y_gap;


x_os=0;
y_os=-0.02;

set(h1,'Position',[x1+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h2,'Position',[x2+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h3,'Position',[x3+x_os y1+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h4,'Position',[x1+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h5,'Position',[x2+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h6,'Position',[x3+x_os y2+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h7,'Position',[x1+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h8,'Position',[x2+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h9,'Position',[x3+x_os y3+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

set(h10,'Position',[x1+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h11,'Position',[x2+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(h12,'Position',[x3+x_os y4+y_os sp_width sp_height]) %using position of subplot1 put subplot2next to it.

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Figures_StormTide/Figures/Figure_3.png',1));

