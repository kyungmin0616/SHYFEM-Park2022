clear


X = categorical({'Wilmington, NC','Charleston, SC','Fort Pulaski, GA', 'Mayport, FL', 'Trident Pier, FL'})';
X = reordercats(X,{'Wilmington, NC','Charleston, SC','Fort Pulaski, GA', 'Mayport, FL', 'Trident Pier, FL'});
% Y = [1.245 0.612; 1.89 1.081; 2.348 1.222; 1.437 0.935; 1.241 0.644];
% Y = [1.241 1.8 2.348 1.437 1.241];


Y = [1.245 0.612; 1.89 1.081; 2.348 1.222; 1.437 0.935; 1.241 0.644];


h=figure('units','normalized','position',[0 0 0.5 0.8]);
set(h, 'Visible', 'on');
h1=bar(Y);
ylabel('Maximum water level anomailes (m)')
xlabel('NOAA stations')
legend('Matthew','Dorian')
set(gca,'xticklabel',{'Wilmington, NC','Charleston, SC','Fort Pulaski, GA', 'Mayport, FL', 'Trident Pier, FL'});
set(gca,'FontSize',48); 
set(gcf,'color','w')

saveas(h,sprintf('/Users/kpark350/Ga_tech/Paper/DCF/StormSurge_TIde/StomSurge/Figures/Figure_3.png'));
