clear
clc

TL=load('grdBCswitch-1.dat');

files = dir('/Users/kpark350/Ga_tech/Projects/SAB/Hurricane/HYCOM');

lon=ncread('/Users/kpark350/Ga_tech/Projects/SAB/Hurricane/HYCOM/HYCOM_SAB_20161006.nc', 'lon');
lat=ncread('/Users/kpark350/Ga_tech/Projects/SAB/Hurricane/HYCOM/HYCOM_SAB_20161006.nc', 'lat');

[LON, LAT] = meshgrid(lon,lat);

LON = LON';
LAT = LAT';


for i=1:7
    
    HY.(['date',num2str(i)])= ncread([files(1).folder '/' files(i+10).name],'surf_el');
    TP.(['date',num2str(i)])= ncread([files(1).folder '/' files(i+10).name],'surf_el');
    
end

% From 20161004!

for i=1:7


for j=1:165
    
    l=0;
    
    for k=1:8
        
    F = griddedInterpolant(LON,LAT,HY.(['date',num2str(i)])(:,:,k));
    pt{j}.(['date',num2str(i)])(k,1) = l;
    pt{j}.(['date',num2str(i)])(k,2) = F(TL(j,4),TL(j,5));
    l=l+3;
    
    end

end


end


for i=1:7
    
    for j=1:165
        
    for k=1:24
        
    pt_bc{j}.(['date',num2str(i)])(k,1)=k-1;

    end
    end
end

for i=1:7
    
    for j=1:165
        
pt_bc{j}.(['date',num2str(i)])(:,2) = interp1(pt{j}.(['date',num2str(i)])(:,1), pt{j}.(['date',num2str(i)])(:,2), pt_bc{j}.(['date',num2str(i)])(:,1),'cubic','extrap');
    
    end
end



for i =1:165
ssh.(['pt',num2str(i)])=[pt_bc{1,i}.date2(:,2); pt_bc{1,i}.date3(:,2); pt_bc{1,i}.date4(:,2); pt_bc{1,i}.date5(:,2);pt_bc{1,i}.date6(:,2);pt_bc{1,i}.date7(:,2);];
end


start = datenum(2016, 10, 05, 0, 0, 0);
offset = datenum(0, 0, 0, 1, 0, 0);
time_vec = start + (0:120)*offset;

bc_time = datestr(time_vec, 'yyyymmdd HHMMSS');

datestr(time_vec)



% Making txt file

fileprova = fopen('boundn_L1hycom_cubic.dat', 'wt');


    
    for j=1:120
    fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 165, 1, 1, 1);
    fprintf(fileprova, '\n');
    fprintf(fileprova, '%s', bc_time(j,:));
    fprintf(fileprova, '\n');
    fprintf(fileprova, ' %s', 'water level [m]');
    fprintf(fileprova, '\n');
    
    for k=1:165
    fprintf(fileprova, '%1.12f',  ssh.(['pt',num2str(k)])(j,1));%%%
    fprintf(fileprova, '\n');
    end
    end


    fprintf(fileprova, '%d %d %d %d %d %d %d', 0, 2, 957839, 165, 1, 1, 1);
    fprintf(fileprova, '\n');
    fprintf(fileprova, '%s', bc_time(121,:));
    fprintf(fileprova, '\n');
    fprintf(fileprova, ' %s', 'water level [m]');
    fprintf(fileprova, '\n');
    
    for k=1:165
    fprintf(fileprova, '%1.12f',  ssh.(['pt',num2str(k)])(121,1)); %%%
    fprintf(fileprova, '\n');
    end
