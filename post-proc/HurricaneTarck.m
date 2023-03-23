clear
clc

load Dorian.txt
load Matthew.txt
file='/Users/kpark350/Ga_tech/Projects/DataSet/Bathymetry/GEBCO/SAB.nc';

lon=ncread(file,'lon');
lat=ncread(file,'lat');
bathy=ncread(file,'elevation');

[LON,LAT]=meshgrid(lon,lat);
LON=LON'; LAT=LAT';

bathy(bathy>=0)=NaN;


%% Track according to intensity.

sz=500;
sz2=18;
h5=[1 0 1];
h4=[1 0 0];
h3=[0.8500 0.3250 0.0980];
h2=[0.9290 0.6940 0.1250];
h1=[1 1 0];

% figure(2)
% clf
fw=0.7;
fh=1;
% h=figure('units','normalized','position',[0 0 0.45 1]);
h=figure('units','normalized','position',[0 0 fw fh]);
set(h, 'Visible', 'on');

clf
p1=subplot(1,3,1);

pcolorjw(LON, LAT, bathy); hold on
plot(Matthew(:,1),Matthew(:,2),'k-','MarkerSize',15,'LineWidth',2);hold on
plot(Dorian(:,1),Dorian(:,2),'k-','MarkerSize',15,'LineWidth',2); 
axis([-82.5 -75.5 25 36]) % axis criterian
graph_handle= gca;
xticks(-82:1:-76)
xtickformat('%.f')
graph_handle.XTickLabel = strcat(graph_handle.XTickLabel, '^{\circ}');
yticks(25:1:36)
ytickformat('%.f')
graph_handle.YTickLabel = strcat(graph_handle.YTickLabel, '^{\circ}');
demcmap([-3000 0]);
colb=colorbar;
title(colb,'Depth (m)')
SAB_coast
rectangle('Position',[-81.4 31.2 1 1.3],'LineStyle','--','EdgeColor','r','LineWidth',3)


%Intensity
scatter(Matthew(1:5,1),Matthew(1:5,2),sz,'filled','s','MarkerFaceColor',h5,...
    'MarkerEdgeColor',h5); hold on
scatter(Matthew(5:8,1),Matthew(5:8,2),sz,'filled','s','MarkerFaceColor',h4,...
    'MarkerEdgeColor',h4); 
scatter(Matthew(8:11,1),Matthew(8:11,2),sz,'filled','s','MarkerFaceColor',h3,...
    'MarkerEdgeColor',h3); 
scatter(Matthew(11:13,1),Matthew(11:13,2),sz,'filled','s','MarkerFaceColor',h2,...
    'MarkerEdgeColor',h2); 
scatter(Matthew(13:19,1),Matthew(13:19,2),sz,'filled','s','MarkerFaceColor',h1,...
    'MarkerEdgeColor',h1); 
scatter(Matthew(19:end,1),Matthew(19:end,2),sz,'filled','s','MarkerFaceColor',h1,...
    'MarkerEdgeColor',h1); 

scatter(Dorian(1:13,1),Dorian(1:13,2),sz,'filled','^','MarkerFaceColor',h5,...
    'MarkerEdgeColor',h5); hold on
scatter(Dorian(13:14,1),Dorian(13:14,2),sz,'filled','^','MarkerFaceColor',h4,...
    'MarkerEdgeColor',h4)
scatter(Dorian(15:19,1),Dorian(15:19,2),sz,'filled','^','MarkerFaceColor',h2,...
    'MarkerEdgeColor',h2)
scatter(Dorian(20:22,1),Dorian(20:22,2),sz,'filled','^','MarkerFaceColor',h3,...
    'MarkerEdgeColor',h3)
scatter(Dorian(23:24,1),Dorian(23:24,2),sz,'filled','^','MarkerFaceColor',h2,...
    'MarkerEdgeColor',h2)
scatter(Dorian(25:27,1),Dorian(25:27,2),sz,'filled','^','MarkerFaceColor',h1,...
    'MarkerEdgeColor',h1)
scatter(Dorian(27:end,1),Dorian(27:end,2),sz,'filled','^','MarkerFaceColor',h1,...
    'MarkerEdgeColor',h1)

%Stations
plot(-80.9,32.036,'kd','MarkerSize',sz2,'markerfacecolor','k','LineWidth',2); %Fort Pulaski
plot(-81.428,30.398,'kd','MarkerSize',sz2,'markerfacecolor','k','LineWidth',2); %Mayport
plot(-80.59333,28.415,'kd','MarkerSize',sz2,'markerfacecolor','k','LineWidth',2); %Wilmington
plot(-79.9233,32.78,'kd','MarkerSize',sz2,'markerfacecolor','k','LineWidth',2); %Charleston
plot(-77.9533,34.226666,'kd','MarkerSize',sz2,'markerfacecolor','k','LineWidth',2); %Wilmington

xlabel('Longitude')
ylabel('Latitude')

set(gca,'FontSize',28); 
set(gcf,'color','w');

%%
plot_google_map('apiKey', 'AIzaSyBBAesbF7u5Ikvm0rgFZLQolfogd7c0B_o') 


X = categorical({'Wilmington, NC','Charleston, SC','Fort Pulaski, GA', 'Mayport, FL', 'Trident Pier, FL'})';
X = reordercats(X,{'Wilmington, NC','Charleston, SC','Fort Pulaski, GA', 'Mayport, FL', 'Trident Pier, FL'});
Y = [1.245 0.612; 1.89 1.081; 2.348 1.222; 1.437 0.935; 1.241 0.644];
% Y = [1.241 1.8 2.348 1.437 1.241];

p2=subplot(2,2,2);
bar(Y);
ylabel('Maximum level (m)')
xlabel('NOAA stations')
legend('Matthew','Dorian')
% set(gca,'xticklabel',{'Wilmington, NC','Charleston, SC','Fort Pulaski, GA', 'Mayport, FL', 'Trident Pier, FL'});
set(gca,'xticklabel',{'NC','SC','GA', 'FL1', 'FL2'});

set(gca,'FontSize',22); 
set(gcf,'color','w')
ytickangle(90)

p3=subplot(2,2,4);
rectangle('Position',[-81.4 31.2 1 1.3],'LineStyle','--','EdgeColor','r','LineWidth',3);hold on
plot(-80.9,32.036,'kd','MarkerSize',sz2,'markerfacecolor','k','LineWidth',2); %Fort Pulaski

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





sp_width= 0.3/fw;
sp_height= 0.86/fh;
x_gap=0.155;
y_gap=0.5;

x1 = 0.065;
x2 = x1+sp_width+x_gap;

y1 = 0.095;
y2 = y1+0.55;

csp=0.73;
set(p1,'Position',[x1 y1 sp_width sp_height]) %using position of subplot1 put subplot2next to it.
set(p2,'Position',[x2 y2 sp_width*csp*1.04 sp_height/2.7]) %using position of subplot1 put subplot2next to it.
set(p3,'Position',[x2 y1-0.05 sp_width*csp*1.04 sp_height/1.7]) %using position of subplot1 put subplot2next to it.





saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_1.png'));






%% FOR LEGNED
figure(3)
clf

scatter(Matthew(1:5,1),Matthew(1:5,2),800,'filled','c','MarkerFaceColor',h5,...
    'MarkerEdgeColor',h5); hold on;
scatter(Matthew(1:5,1),Matthew(1:5,2),800,'filled','c','MarkerFaceColor',h4,...
    'MarkerEdgeColor',h4); 
scatter(Matthew(1:5,1),Matthew(1:5,2),800,'filled','c','MarkerFaceColor',h3,...
    'MarkerEdgeColor',h3); 
scatter(Matthew(1:5,1),Matthew(1:5,2),800,'filled','c','MarkerFaceColor',h2,...
    'MarkerEdgeColor',h2); 
scatter(Matthew(1:5,1),Matthew(1:5,2),800,'filled','c','MarkerFaceColor',h1,...
    'MarkerEdgeColor',h1); 

legend('Category 5','Category 4','Category 3','Category 2','Category 1')
set(gca,'FontSize',30); 
legendmarkeradjust(30)



figure(2)
clf
plot(Matthew(:,1),Matthew(:,2),'k-s','MarkerSize',20,'LineWidth',2);hold on
plot(Dorian(:,1),Dorian(:,2),'k-^','MarkerSize',20,'LineWidth',2); 
plot(-80.9,32.036,'kd','MarkerSize',sz2,'markerfacecolor','k','LineWidth',2); %Fort Pulaski
axis([-82.5 -75.5 25 36]) % axis criterian

legend('Matthew','Dorian','NOAA stations')
set(gca,'FontSize',30); 




%% intensity line

plot(Dorian(1:13,1),Dorian(1:13,2),'k--','MarkerSize',17,'LineWidth',4); hold on
plot(Dorian(13:15,1),Dorian(13:15,2),'r--','MarkerSize',17,'LineWidth',4)
plot(Dorian(15:19,1),Dorian(15:19,2),'g--','MarkerSize',17,'LineWidth',4)
plot(Dorian(19:22,1),Dorian(19:22,2),'r--','MarkerSize',17,'LineWidth',4)
plot(Dorian(22:24,1),Dorian(22:24,2),'g--','MarkerSize',17,'LineWidth',4)
plot(Dorian(24:27,1),Dorian(24:27,2),'y--','MarkerSize',17,'LineWidth',4)
plot(Dorian(27:end,1),Dorian(27:end,2),'k--','MarkerSize',17,'LineWidth',4)



plot(Dorian(11:13,1),Dorian(11:13,2),'m--','MarkerSize',17,'LineWidth',4)


plot(Matthew(1:5,1),Matthew(1:5,2),'k-','MarkerSize',17,'LineWidth',4); hold on
plot(Matthew(5:8,1),Matthew(5:8,2),'m-','MarkerSize',17,'LineWidth',4); 
plot(Matthew(8:11,1),Matthew(8:11,2),'r-','MarkerSize',17,'LineWidth',4); 
plot(Matthew(11:14,1),Matthew(11:14,2),'g-','MarkerSize',17,'LineWidth',4); 
plot(Matthew(14:19,1),Matthew(14:19,2),'y-','MarkerSize',17,'LineWidth',4); 
plot(Matthew(19:end,1),Matthew(19:end,2),'k-','MarkerSize',17,'LineWidth',4); 






%% River discharge stations
% figure(1)
% clf

plot(-78.3,34.4,'bo','MarkerSize',9,'markerfacecolor','b','LineWidth',2); %Cape Fear, Kelly(NC), 02105769
plot(-79.2,33.7,'bo','MarkerSize',9,'markerfacecolor','b','LineWidth',2); %Pee Dee, Bucksport(SC), 02135200
plot(-80.4,33,'bo','MarkerSize',9,'markerfacecolor','b','LineWidth',2); %Edisto, Givhans(SC), 02175000
plot(-81.3,32.5,'bo','MarkerSize',9,'markerfacecolor','b','LineWidth',2); %Savannah, Cylo(GA), 02198500
plot(-81.8,31.7,'bo','MarkerSize',9,'markerfacecolor','b','LineWidth',2); %Altamaha, Doctortown(GA), 02226000
plot(-81.38,29.008,'bo','MarkerSize',9,'markerfacecolor','b','LineWidth',2); %ST. Johns, De Land(FL), 02236000
plot(-81.9,30.1,'bo','MarkerSize',9,'markerfacecolor','b','LineWidth',2); %North Fork, Middleburg(FL), 02246000

% plot(-80.316,25.75,'bo','MarkerSize',9,'markerfacecolor','k','LineWidth',2); %Tamiami Canal, Coral Gables(FL), 02289500
% plot(-77.4,35.6,'ko','MarkerSize',9,'markerfacecolor','k','LineWidth',2);hold on %Tar, Greenville(NC), 02084000
% plot(-77.3,35.3,'bo','MarkerSize',9,'markerfacecolor','b','LineWidth',2); hold on %Neuse, Fort Barnwell(NC), 02091814
% plot(-80.783,27.566,'bo','MarkerSize',9,'markerfacecolor','b','LineWidth',2); %Ft drum creek, FT DRUM(FL), 02231342
% plot(-81.4,32.2,'ko','MarkerSize',9,'markerfacecolor','k','LineWidth',2); %Ogeechee, Eden(GA), 02202500
% plot(-80.3,33.4,'ko','MarkerSize',9,'markerfacecolor','k','LineWidth',2); %Santee, Ferguson(SC), 02170000

% SAB_coast
% axis([-84 -74 24 36]) % axis criterian

%% prec stations
% figure(1)
% clf

plot(-78.28,34.4,'ro','MarkerSize',9,'markerfacecolor','r','LineWidth',2); hold on % KELLY, NC
% plot(-80.36,25.56,'ro','MarkerSize',9,'markerfacecolor','k','LineWidth',2); % GOULDS, FL
plot(-81.03,28.7,'ro','MarkerSize',9,'markerfacecolor','r','LineWidth',2); % rr GENEVA,FL
plot(-81.65,30.73,'ro','MarkerSize',9,'markerfacecolor','r','LineWidth',2); % rr KINGSLAND, GA
plot(-79.78,33.11,'ro','MarkerSize',9,'markerfacecolor','r','LineWidth',2); % HUGER, SC
plot(-81.15,32.23,'ro','MarkerSize',9,'markerfacecolor','r','LineWidth',2); % rr PORT WENTWORTH, GA

% plot(-76.2,35.5,'ko','MarkerSize',9,'markerfacecolor','k','LineWidth',2); % FAIRFIELD NC
% plot(-76.215,35.491,'ro','MarkerSize',9,'markerfacecolor','k','LineWidth',2); hold on %
% plot(-81.35,31.45,'ko','MarkerSize',9,'markerfacecolor','k','LineWidth',2); % MERIDIAN,GA
% plot(-81.005,32.1,'ro','MarkerSize',9,'markerfacecolor','k','LineWidth',2); % 
% plot(-78.71,33.95,'ko','MarkerSize',9,'markerfacecolor','k','LineWidth',2); % LONGS, SC
% plot(-79.78,33.11,'ro','MarkerSize',9,'markerfacecolor','k','LineWidth',2); %

% 
% SAB_coast
% axis([-84 -74 24 36]) % axis criterian
set(gca,'fontsize',10);  

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/OSM/HurrTrack.png'));




