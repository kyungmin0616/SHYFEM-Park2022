clc
clear all
close all

tideFP=load('/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/Copy_of_CO-OPS_8670870_MHHW copy.csv');

% cF2M = 0.3048;
% tideFP=tideFP*cF2M;
% 
% 
% timeht=[1:1:length(tideFP)];
% timedt=(timeht/24)+1;

startDate = datenum('05-28-2019');
endDate = datenum('06-02-2019');
timedt = linspace(startDate,endDate,length(tideFP(:,1)));

mtideFP=mean(tideFP);

figure; 
plot(timedt,tideFP-mtideFP,'-r')
graph_handle= gca;
set(graph_handle,'fontsize', 22)
set(graph_handle,'linewidth', 1)
xlabel('days in January','FontSize',22);
ylabel('h (m)','FontSize',22);
   

ncid = netcdf.open(['/Users/kpark350/Ga_tech/Projects/SHYFEM/Output/Savannah_ous0.nc'],'NC_NOWRITE');




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

% tout=3;
% ntimes = length(field{3}.data);
% if tout>ntimes
%     display(['***ERROR: Requested time index exceeds available output times (' num2str(ntimes) ')'])
%     return;
% end


fac = 1.0;

[nn nt]=size(field{10}.data)


% parameters for map
element_index=field{1}.data(1:3,:)';
lon=field{4}.data;
lat=field{2}.data;
bathy=field{7}.data;


min_lon=min(lon)-0.03;
max_lon=max(lon)+0.03;
min_lat=min(lat)-0.03;
max_lat=max(lat)+0.03;


depth=-field{7}.data;

ssh=field{10}.data;

 lat_s = 32.036667;
 lon_s = -80.901667;

dist = (lat' - lat_s).^2+(lon' - lon_s).^2;
[min_dist,index_dist] = min(dist);

sshtime1=squeeze(ssh(index_dist,:));
timedt2 = linspace(startDate,endDate,length(sshtime1));

% timeh=[1:1:length(sshtime1)];
% timed=(timeh/24)+1;


m_sshtime1=mean(sshtime1);

figure; 
plot(timedt2,sshtime1-m_sshtime1,'-r')
graph_handle= gca;
set(graph_handle,'fontsize', 22)
set(graph_handle,'linewidth', 1)
xlabel('days in January','FontSize',22);
ylabel('h (m)','FontSize',22);


figure; 
plot(timedt,tideFP-mtideFP,'-k','linewidth', 2)
hold on 
plot(timedt2,sshtime1-m_sshtime1,'-or','linewidth', 1)
graph_handle= gca;
set(graph_handle,'fontsize', 22)
set(graph_handle,'linewidth', 1)
legend('obs','mod')
datetick('x','mmmdd')
xlabel('Days','FontSize',22);
ylabel('h (m)','FontSize',22);


