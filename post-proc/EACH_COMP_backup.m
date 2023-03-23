
%% NL when peak occur

stt=24*3;
edt=24*5;

max_MT=max(ssh1(:,stt:edt),[],2);
max_DR=max(sshd1(:,stt:edt),[],2);
max_MT_6H=max(ssh2(:,stt:edt),[],2);
max_DR_6H=max(sshd2(:,stt:edt),[],2);


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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Contribution of Surge and Tide %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fw=0.35;
fh=1;
% SAV

h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

h1=subplot(4,3,1);
trisurf(element_index,lon,lat,OS_MT./max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for original tide','FontSize',22);
axis([-81.2 -80.8 31.85 32.25]); % Sav
box on;
grid on;
caxis([0 1.2]);
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


h2=subplot(4,3,2);
trisurf(element_index,lon,lat,OS_MT_6H./max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([-81.2 -80.8 31.85 32.25]); % Sav
caxis([0 1.2]);
box on;
grid on;
% hcb=colorbar;
% title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% colormap(graph_handle,bluewhitered)
colormap(graph_handle,turbo)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

h3=subplot(4,3,3);
trisurf(element_index,lon,lat,OT_MT./max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([-81.2 -80.8 31.85 32.25]); % Sav
caxis([0 1.2]);
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


h4=subplot(4,3,4);
trisurf(element_index,lon,lat,OS_DR./max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
% title('\color{black}TSI for original tide','FontSize',22);
axis([-81.2 -80.8 31.85 32.25]); % Sav
box on;
grid on;
caxis([0 1.2]);
graph_handle= gca;
colormap(graph_handle,turbo)
xticks(-81.3:0.25:80.8)
yticks(31.8:0.25:32.3)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot


h5=subplot(4,3,5);
trisurf(element_index,lon,lat,OS_DR_6H./max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
% colormap(parula)
% axis equal
% title('\color{black}TSI for shifted tide','FontSize',22);
axis([-81.2 -80.8 31.85 32.25]); % Sav
box on;
grid on;
caxis([0 1.2]);
% hcb=colorbar;
% title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
colormap(graph_handle,turbo)
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

h6=subplot(4,3,6);
trisurf(element_index,lon,lat,OT_DR./max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
% title('\color{black}Change in TSI','FontSize',22);
axis([-81.2 -80.8 31.85 32.25]); % Sav
box on;
grid on;
caxis([0 1.2]);
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
colormap(graph_handle,turbo)
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
set(gcf,'color','w');
% set(gca,'Color',[0.8, 0.8, 0.8]) % grey for plot

% Sapelo

h7=subplot(4,3,7);
trisurf(element_index,lon,lat,OS_MT./max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
% title('\color{black}MT-ST','FontSize',22);
axis([-81.4 -81.1 31.3 31.6]);% Sapero
box on;
grid on;
caxis([0 1.2]);
graph_handle= gca;
xticks(-81.4:0.15:81.1)
xtickformat('%.2f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(31.3:0.15:31.6)
ytickformat('%.2f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h8=subplot(4,3,8);
trisurf(element_index,lon,lat,OS_MT_6H./max(ssh2(:,stt:edt),[],2))
view(0,90);shading interp;     
% title('\color{black}MT-ST6H','FontSize',22);
axis([-81.4 -81.1 31.3 31.6]);% Sapero
caxis([0 1.2]);
box on;
grid on;
% hcb=colorbar;
% title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h9=subplot(4,3,9);
trisurf(element_index,lon,lat,OT_MT./max(ssh1(:,stt:edt),[],2))
view(0,90);shading interp;     
% title('\color{black}Diff.','FontSize',22);
axis([-81.4 -81.1 31.3 31.6]);% Sapero
caxis([0 1.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)


h10=subplot(4,3,10);
trisurf(element_index,lon,lat,OS_DR./max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
% title('\color{black}MT-ST','FontSize',22);
axis([-81.4 -81.1 31.3 31.6]);% Sapero
box on;
grid on;
caxis([0 1.2]);
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
view(0,90);shading interp;     
% set(gcf,'color','y');
colormap(graph_handle,turbo)

h11=subplot(4,3,11);
trisurf(element_index,lon,lat,OS_DR_6H./max(sshd2(:,stt:edt),[],2))
view(0,90);shading interp;     
% title('\color{black}MT-ST6H','FontSize',22);
axis([-81.4 -81.1 31.3 31.6]);% Sapero
caxis([0 1.2]);
box on;
grid on;
% hcb=colorbar;
% title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)

h12=subplot(4,3,12);
trisurf(element_index,lon,lat,OT_DR./max(sshd1(:,stt:edt),[],2))
view(0,90);shading interp;     
% title('\color{black}Diff.','FontSize',22);
axis([-81.4 -81.1 31.3 31.6]);% Sapero
caxis([0 1.2]);
box on;
grid on;
hcb=colorbar;
title(hcb,'cm','fontsize', 18)
graph_handle= gca;
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
set(graph_handle,'fontsize', 18)
set(graph_handle,'linewidth', 1)
colormap(graph_handle,turbo)
set(gcf,'color','w');
% set(gca,'Color',[0.5, 0.5, 0.5])


sp_width= 0.09/fw;
sp_height= 0.2/fh;
x_gap=0.015;
y_gap=0.05;
x1 = 0.09;
x2 = x1+sp_width+x_gap;
x3 = x2+sp_width+x_gap;
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

saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/SenExp/Figures_StormTide/Figures/Figure_4.png',1));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSI vs  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IV = find(lon>=-81.16 & lon <= -80.84 & lat >=31.94 & lat <=32.26);
IP = find(lon>=-81.4 & lon <= -81.1 & lat >=31.3 & lat <=31.6);

axis([-81.16 -80.84 31.94 32.26]); % Sav

%% Tide + Storm surge vs TSI

%Matthew

figure(1)
clf
% subplot(2,1,1)
% scatter(max_MT(IV),NL_MT(IV)); hold on
% scatter(max_MT_6H(IV),NL_MT_6H(IV))
% scatter(max_DR(IV),NL_DR(IV))
% scatter(max_DR_6H(IV),NL_DR_6H(IV))

% subplot(2,1,1)
% scatter(OS_MT(IV)+OT_MT(IV),NL_MT(IV)); hold on
% scatter(OS_MT_6H(IV)+OT_MT(IV),NL_MT_6H(IV))
% scatter(OS_DR(IV)+OT_DR(IV),NL_DR(IV))
% scatter(OS_DR_6H(IV)+OT_DR(IV),NL_DR_6H(IV))

% subplot(2,1,1)
scatter(OS_MT+OT_MT,NL_MT); hold on
scatter(OS_MT_6H+OT_MT,NL_MT_6H)
scatter(OS_DR+OT_DR,NL_DR)
scatter(OS_DR_6H+OT_DR,NL_DR_6H)


figure(1)
clf
% subplot(2,1,1)
scatter(OT_MT(IV),NL_MT(IV)); hold on
scatter(OT_MT(IV),NL_MT_6H(IV))
scatter(OT_DR(IV),NL_DR(IV))
scatter(OT_DR(IV),NL_DR_6H(IV))

% xlim([1.3 2.05])
legend('MT-ST','MT-ST6H')
xlabel('Tide + Storm Surge (m)')
ylabel('TSI (m)')
title('Savannah')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)


subplot(2,1,1)
scatter(OS_MT(IV)+OT_MT(IV),NL_MT(IV)); hold on
scatter(OS_MT_6H(IV)+OT_MT(IV),NL_MT_6H(IV))
% xlim([1.3 2.05])
legend('MT-ST','MT-ST6H')
xlabel('Tide + Storm Surge (m)')
ylabel('TSI (m)')
title('Savannah')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
scatter(OS_MT(IP)+OT_MT(IP),NL_MT(IP)); hold on
scatter(OS_MT_6H(IP)+OT_MT(IP),NL_MT_6H(IP))
xlim([1 2.3])
legend('MT-ST','MT-ST6H')
xlabel('Tide + Storm Surge (m)')
ylabel('TSI (m)')
title('Sapelo Island')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)


% Dorian

figure(3)
clf
subplot(2,1,1)
scatter(OS_DR(IV)+OT_DR(IV),NL_DR(IV)); hold on
scatter(OS_DR_6H(IV)+OT_DR(IV),NL_DR_6H(IV))
xlim([1.3 2.05])
legend('DR-ST','DR-ST6H')
xlabel('Tide + Storm Surge (m)')
ylabel('TSI (m)')
title('Savannah')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
scatter(OS_DR(IP)+OT_DR(IP),NL_DR(IP)); hold on
scatter(OS_DR_6H(IP)+OT_DR(IP),NL_DR_6H(IP))
xlim([1.4 2.35])
legend('DR-ST','DR-ST6H')
xlabel('Tide + Storm Surge (m)')
ylabel('TSI (m)')
title('Sapelo Island')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

%% Tide vs TSI

%Matthew

figure(1)
clf
subplot(2,1,1)
scatter(OT_MT(IV),NL_MT(IV)); hold on
scatter(OT_MT(IV),NL_MT_6H(IV))
% xlim([1.3 2.05])
legend('MT-ST','MT-ST6H')
xlabel('Tide (m)')
ylabel('TSI (m)')
title('Savannah')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
scatter(OT_MT(IP),NL_MT(IP)); hold on
scatter(OT_MT(IP),NL_MT_6H(IP))
% xlim([1 2.3])
legend('MT-ST','MT-ST6H')
xlabel('Tide (m)')
ylabel('TSI (m)')
title('Sapelo Island')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)


% Dorian

figure(1)
clf
subplot(2,1,1)
scatter(OT_DR(IV),NL_DR(IV)); hold on
scatter(OT_DR(IV),NL_DR_6H(IV))
% xlim([1.3 2.05])
legend('DR-ST','DR-ST6H')
xlabel('Tide (m)')
ylabel('TSI (m)')
title('Savannah')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
scatter(OT_DR(IP),NL_DR(IP)); hold on
scatter(OT_DR(IP),NL_DR_6H(IP))
% xlim([1.4 2.35])
legend('DR-ST','DR-ST6H')
xlabel('Tide (m)')
ylabel('TSI (m)')
title('Sapelo Island')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

%% Storm surge vs TSI

%Matthew

figure(1)
clf
subplot(2,1,1)
scatter(OS_MT(IV),NL_MT(IV)); hold on
scatter(OS_MT_6H(IV),NL_MT_6H(IV))
% xlim([1.3 2.05])
legend('MT-ST','MT-ST6H')
xlabel('Storm Surge (m)')
ylabel('TSI (m)')
title('Savannah')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
scatter(OS_MT(IP),NL_MT(IP)); hold on
scatter(OS_MT_6H(IP),NL_MT_6H(IP))
% xlim([1 2.3])
legend('MT-ST','MT-ST6H')
xlabel('Storm Surge (m)')
ylabel('TSI (m)')
title('Sapelo Island')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)


% Dorian

figure(1)
clf
subplot(2,1,1)
scatter(OS_DR(IV),NL_DR(IV)); hold on
scatter(OS_DR_6H(IV),NL_DR_6H(IV))
% xlim([1.3 2.05])
legend('DR-ST','DR-ST6H')
xlabel('Storm Surge (m)')
ylabel('TSI (m)')
title('Savannah')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)

subplot(2,1,2)
scatter(OS_DR(IP),NL_DR(IP)); hold on
scatter(OS_DR_6H(IP),NL_DR_6H(IP))
% xlim([1.4 2.35])
legend('DR-ST','DR-ST6H')
xlabel('Storm Surge (m)')
ylabel('TSI (m)')
title('Sapelo Island')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 28)


%% Histogram for SAV and SAP


%%%%% storm surge 

% SAV

figure(1)
clf

subplot(2,2,1)
histogram2(OS_MT(IV),NL_MT(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-SO (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,2)
histogram2(OS_MT_6H(IV),NL_MT_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-SO6H (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])


subplot(2,2,3)
histogram2(OS_DR(IV),NL_DR(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,4)
histogram2(OS_DR_6H(IV),NL_DR_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO6H (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])
colormap(turbo)
set(gcf,'color','w')

%SAP

figure(1)
clf

subplot(2,2,1)
histogram2(OS_MT(IP),NL_MT(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-SO (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,2)
histogram2(OS_MT_6H(IP),NL_MT_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO6H (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])


subplot(2,2,3)
histogram2(OS_DR(IP),NL_DR(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,4)
histogram2(OS_DR_6H(IP),NL_DR_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO6H (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])
colormap(turbo)
set(gcf,'color','w')

%%%%% Tide

%SAV


figure(1)
clf

subplot(2,2,1)
histogram2(OT_MT(IV),NL_MT(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-TO (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,2)
histogram2(OT_MT(IV),NL_MT_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-TO (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)


subplot(2,2,3)
histogram2(OT_DR(IV),NL_DR(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-TO (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,4)
histogram2(OT_DR(IV),NL_DR_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-TO (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
set(gcf,'color','w')
colormap(turbo)


%SAP


figure(1)
clf

subplot(2,2,1)
histogram2(OT_MT(IP),NL_MT(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-TO (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,2)
histogram2(OT_MT(IP),NL_MT_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-TO (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)


subplot(2,2,3)
histogram2(OT_DR(IP),NL_DR(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-TO (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,4)
histogram2(OT_DR(IP),NL_DR_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-TO (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
set(gcf,'color','w')
colormap(turbo)


%%%%% Tide + storm surge

%SAV


figure(1)
clf

subplot(2,2,1)
histogram2(OT_MT(IV)+OS_MT(IV),NL_MT(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-ST (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,2)
histogram2(OT_MT(IV)+OS_MT_6H(IV),NL_MT_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-ST6H (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)


subplot(2,2,3)
histogram2(OT_DR(IV)+OS_DR(IV),NL_DR(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-ST (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,4)
histogram2(OT_DR(IV)+OS_DR_6H(IV),NL_DR_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-ST6H (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
set(gcf,'color','w')
colormap(turbo)


%SAP


figure(1)
clf

subplot(2,2,1)
histogram2(OT_MT(IP)+OS_MT(IP),NL_MT(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-ST (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,2)
histogram2(OT_MT(IP)+OS_MT_6H(IP),NL_MT_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-ST6H (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)


subplot(2,2,3)
histogram2(OT_DR(IP)+OS_DR(IP),NL_DR(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-ST (m)')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,4)
histogram2(OT_DR(IP)+OS_DR_6H(IP),NL_DR_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-ST6H (m)')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
set(gcf,'color','w')
colormap(turbo)


%% Histogram for SAV and SAP (Contribution of each component vs TSI)


%%%%% storm surge 

% SAV

figure(1)
clf

subplot(2,2,1)
histogram2(OS_MT(IV)./max_MT(IV),NL_MT(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-SO / MT-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,2)
histogram2(OS_MT_6H(IV)./max_MT_6H(IV),NL_MT_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-SO6H / MT-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])


subplot(2,2,3)
histogram2(OS_DR(IV)./max_DR(IV),NL_DR(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO / DR-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,4)
histogram2(OS_DR_6H(IV)./max_DR_6H(IV),NL_DR_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO6H / DR-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])
colormap(turbo)
set(gcf,'color','w')

%SAP

figure(1)
clf

subplot(2,2,1)
histogram2(OS_MT(IP)./max_MT(IP),NL_MT(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-SO / MT-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,2)
histogram2(OS_MT_6H(IP)./max_MT_6H(IP),NL_MT_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-SO6H / MT-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])


subplot(2,2,3)
histogram2(OS_DR(IP)./max_DR(IP),NL_DR(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO / DR-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,4)
histogram2(OS_DR_6H(IP)./max_DR_6H(IP),NL_DR_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO6H / DR-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])
colormap(turbo)
set(gcf,'color','w')

%%%%% Tide

%SAV


figure(1)
clf

subplot(2,2,1)
histogram2(OT_MT(IV)./max_MT(IV),NL_MT(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-TO / MT-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,2)
histogram2(OT_MT(IV)./max_MT_6H(IV),NL_MT_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-TO / MT-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)


subplot(2,2,3)
histogram2(OT_DR(IV)./max_DR(IV),NL_DR(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-TO / DR-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,4)
histogram2(OT_DR(IV)./max_DR_6H(IV),NL_DR_6H(IV),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-TO / DR-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
set(gcf,'color','w')
colormap(turbo)


%SAP


figure(2)
clf

subplot(2,2,1)
histogram2(OT_MT(IP)./max_MT(IP),NL_MT(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-TO / MT-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,2)
histogram2(OT_MT(IP)./max_MT_6H(IP),NL_MT_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-TO / MT-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)


subplot(2,2,3)
histogram2(OT_DR(IP)./max_DR(IP),NL_DR(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-TO / DR-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,4)
histogram2(OT_DR(IP)./max_DR_6H(IP),NL_DR_6H(IP),'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-TO / DR-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
set(gcf,'color','w')
colormap(turbo)

%% Histogram for Entire (Contribution of each component vs TSI)

% storm surge

binx=0.02;
biny=0.02;

figure(1)
clf

subplot(2,2,1)
histogram2(OS_MT./max_MT,NL_MT,'BinWidth',[binx biny],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-SO / MT-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,2)
histogram2(OS_MT_6H./max_MT_6H,NL_MT_6H,'BinWidth',[binx biny],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('MT-SO6H / MT-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])


subplot(2,2,3)
histogram2(OS_DR./max_DR,NL_DR,'BinWidth',[binx biny],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO / DR-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,4)
histogram2(OS_DR_6H./max_DR_6H,NL_DR_6H,'BinWidth',[binx biny],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','probability','EdgeColor','none')
xlabel('DR-SO6H / DR-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])
colormap(turbo)
set(gcf,'color','w')


% Tide

figure(2)
clf

subplot(2,2,1)
histogram2(OT_MT./max_MT,NL_MT,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('MT-TO / MT-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,2)
histogram2(OT_MT./max_MT_6H,NL_MT_6H,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('MT-TO / MT-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)


subplot(2,2,3)
histogram2(OT_DR./max_DR,NL_DR,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('DR-TO / DR-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,4)
histogram2(OT_DR./max_DR_6H,NL_DR_6H,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('DR-TO / DR-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
set(gcf,'color','w')
colormap(turbo)


%% Histogram for Entire 

%Storm surge

figure(1)
clf

subplot(2,2,1)
histogram2(OS_MT,NL_MT,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('MT-SO')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,2)
histogram2(OS_MT_6H,NL_MT_6H,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('MT-SO6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])


subplot(2,2,3)
histogram2(OS_DR,NL_DR,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('DR-SO')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])

subplot(2,2,4)
histogram2(OS_DR_6H,NL_MT_6H,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('DR-SO6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
% caxis([0 300])
colormap(turbo)


% Tide

figure(2)
clf

subplot(2,2,1)
histogram2(OT_MT,NL_MT,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('MT-TO')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,2)
histogram2(OT_MT,NL_MT_6H,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('MT-TO')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)


subplot(2,2,3)
histogram2(OT_DR,NL_DR,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('DR-TO / DR-ST')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,4)
histogram2(OT_DR,NL_DR_6H,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('DR-TO / DR-ST6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
set(gcf,'color','w')
colormap(turbo)


% Tide + Storm surge
figure(3)
clf

subplot(2,2,1)
histogram2(OT_MT+OS_MT,NL_MT,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('MT-TO + MT-SO')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,2)
histogram2(OT_MT+OS_MT_6H,NL_MT_6H,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('MT-TO+ MT-SO6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)


subplot(2,2,3)
histogram2(OT_DR+OS_DR,NL_DR,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('DR-TO + DR_SO')
ylabel('TSI (m)')
colorbar
set(gca,'fontsize', 18)

subplot(2,2,4)
histogram2(OT_DR+OS_DR_6H,NL_DR_6H,'BinWidth',[0.01 0.01],'DisplayStyle','tile','ShowEmptyBins','on','Normalization','pdf')
xlabel('DR-TO + DR_SO6H')
ylabel('TSI-6H (m)')
colorbar
set(gca,'fontsize', 18)
set(gcf,'color','w')
colormap(turbo)




