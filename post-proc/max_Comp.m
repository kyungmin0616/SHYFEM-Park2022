clear

figure
X = categorical({'Wilmington, NC','Charleston, SC','Fort Pulaski, GA', 'Mayport, FL', 'Trident Pier, FL'});
X = reordercats(X,{'Wilmington, NC','Charleston, SC','Fort Pulaski, GA', 'Mayport, FL', 'Trident Pier, FL'});
Y = [1.245 0.612; 1.89 1.081; 2.348 1.222; 1.437 0.935; 1.241 0.644];
bar(X,Y)

ylabel('Maximum water level anomalies (m)')
xlabel('NOAA stations')

% legend('Matthew','Dorian')
set(gca,'FontSize',30); 
set(gcf,'color','w')



figure
X = categorical({'Wilmington, NC','Charleston, SC','Fort Pulaski, GA', 'Mayport, FL', 'Trident Pier, FL'});
X = reordercats(X,{'Trident Pier, FL', 'Mayport, FL','Fort Pulaski, GA','Charleston, SC','Wilmington, NC'});
Y = [1.245 0.612; 1.89 1.081; 2.348 1.222; 1.437 0.935; 1.241 0.644];
barh(X,Y)

xlabel('Storm surge (m)')
ylabel('Government Stations')

legend('Matthew','Dorian')

MT

1.245
1.89
2.348
1.437
1.241

DR
0.612
1.081
1.222
0.935
0.644
