clear
clc

bdn=readtable('boundn_20161005_hm_tides.dat');
bdn2=readtable('boundn_L1tides20161005.dat');

% bdn=readtable('boundn_20190902_hm_tides.dat');
% bdn2=readtable('boundn_L1tides20190902.dat');
% bdn3=readtable('boundn_20190902_12h_tides.dat');

[length b] = size(bdn);

% Making txt file

k=0;

j=0;
for i=3+k:168:length-164+k
     j=j+1;
     ch(j,1)=str2double(table2array(bdn(i,1)));
     ch(j,2)=str2double(table2array(bdn2(i,1)));
%      ch(j,3)=str2double(table2array(bdn(i,1)))-str2double(table2array(bdn2(i,1)))+str2double(table2array(bdn2(i+it,1)));
    
end



% 
% it = 1008;
% j=0;
% for i=3+k:168:length-164-it+k
%      j=j+1;
%      ch(j,3)=str2double(table2array(bdn(i,1)))-str2double(table2array(bdn2(i,1)))+str2double(table2array(bdn2(i+it,1)));
%     
% end
% 
% 
% it = 2016;
% j=0;
% for i=3+k:168:length-164-it+k
%      j=j+1;
%      ch(j,4)=str2double(table2array(bdn(i,1)))-str2double(table2array(bdn2(i,1)))+str2double(table2array(bdn2(i+it,1)));
%     
% end
% 
% it = 3024;
% j=0;
% for i=3+k:168:length-164-it+k
%      j=j+1;
%      ch(j,5)=str2double(table2array(bdn(i,1)))-str2double(table2array(bdn2(i,1)))+str2double(table2array(bdn2(i+it,1)));
%     
% end


clear bdn bdn2
bdn=readtable('boundn_20190902_hm_tides.dat');
bdn2=readtable('boundn_L1tides20190902.dat');
% bdn3=readtable('boundn_20190902_12h_tides.dat');

[length b] = size(bdn);

% Making txt file



j=0;
for i=3+k:168:length-164+k
     j=j+1;
     ch2(j,1)=str2double(table2array(bdn(i,1)));
     ch2(j,2)=str2double(table2array(bdn2(i,1)));
%      ch(j,3)=str2double(table2array(bdn(i,1)))-str2double(table2array(bdn2(i,1)))+str2double(table2array(bdn2(i+it,1)));
    
end

% 
% 
% it = 1008;
% j=0;
% for i=3+k:168:length-164-it+k
%      j=j+1;
%      ch2(j,3)=str2double(table2array(bdn(i,1)))-str2double(table2array(bdn2(i,1)))+str2double(table2array(bdn2(i+it,1)));
%     
% end
% 
% 
% it = 2016;
% j=0;
% for i=3+k:168:length-164-it+k
%      j=j+1;
%      ch2(j,4)=str2double(table2array(bdn(i,1)))-str2double(table2array(bdn2(i,1)))+str2double(table2array(bdn2(i+it,1)));
%     
% end
% 
% it = 3024;
% j=0;
% for i=3+k:168:length-164-it+k
%      j=j+1;
%      ch2(j,5)=str2double(table2array(bdn(i,1)))-str2double(table2array(bdn2(i,1)))+str2double(table2array(bdn2(i+it,1)));
%     
% end


x=1:264;

figure(1)
clf
plot(x/24,ch(:,1)-ch(:,2),'-r','LineWidth',3); hold on
plot(x/24,ch2(:,1)-ch2(:,2),'-b','LineWidth',3);

legend('Matthew','Dorian')
axis([0 7 -0.9 0.9]);
xlabel('Days')
ylabel('SSH (m)')
box on
grid on
set(gcf,'color','w')
set(gca, 'FontSize', 26)



% subplot(2,2,4)
plot(x/24,ch2(:,1)-mean(ch2(:,2)),'-b','LineWidth',3); hold on
plot(x/24,ch2(:,2)-mean(ch2(:,2)),'-.b','LineWidth',3); 
% plot(x/24,ch2(:,3)-mean(ch2(:,2)),'ob','LineWidth',2,'MarkerSize',15);
% plot(x/24,ch2(:,4)-mean(ch2(:,2)),'^b','LineWidth',2,'MarkerSize',15);
% plot(x/24,ch2(:,5)-mean(ch2(:,2)),'xb','LineWidth',2,'MarkerSize',15);

legend('Tide+SSH','Tide','6h ST','12h ST','18h ST')
axis([3 5 -1.5 2.5]);
set(gca, 'FontSize', 18)
xlabel('Days')
ylabel('Water level (m)')
box on
grid on
set(gcf,'color','w')
title('Tide+SSH - Dorian')

% t_bdn2(:,1) = bdn_t(:,1);
% t_bdn2(:,2) = bdn_t(:,2);

% 
% % its=4;
% h=figure;
% set(h, 'Visible', 'on');
% plot(bdn_t(:,1),bdn_t(:,2),'r','linewidth', 3); hold on
% % plot(t_bdn(:,1),t_bdn(:,2),'linewidth', 3)
% plot(t_bdn2(:,1),t_bdn2(:,2),'linewidth', 3)
% 
% graph_handle= gca;
% set(graph_handle,'fontsize', 22)
% set(graph_handle,'linewidth', 1)
% datetick('x','mmmddhh','keeplimits')
% xlabel('Days','FontSize',22);
% ylabel('h (m)','FontSize',22);


% saveas(h,sprintf('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/20161007/Image/temp_%d.png',its));

