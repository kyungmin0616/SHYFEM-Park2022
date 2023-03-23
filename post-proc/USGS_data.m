
function [out]= NOAA_tide(st_yr,end_yr,stationID,product,datum)

         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         % st_yr = Start year of the data                                                           %
         % end_yr = End year of the data                                                            %
         % StationID = NOAA station ID [for example '8724580' (Need to use as char)]				%
		 % product = product typle (e.g., water_level, predictions                                  %                                                       %									
         % datum = vertical datum (e.g., 'MSL', 'NAVD', 'MLLW', 'MHHW'                              %                                                  %
         %                                                                                          %
         %                                                                                          %	
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
         
Year=st_yr:1:end_yr; % define all the year withing the start and end year limit
xout=[];
for i=1:length(Year)
    for j=1:12
     st_date = datestr([Year(i),j,1,0,0,0],'yyyymmdd');
     end_date = datestr([Year(i),j,eomday(Year(i),j),23,59,59],'yyyymmdd');   
     
     disp(['Downloding a month data from ',st_date,' ...']);

	  url=['https://api.tidesandcurrents.noaa.gov/api/prod/datagetter?begin_date=',st_date,'&end_date=',end_date,'&station=',stationID,'&product=',product,'&datum=',datum,'&units=metric&time_zone=gmt&format=CSV'];
     url=['https://waterservices.usgs.gov/nwis/dv/?format=waterml,1.1&sites=06090800&period=P60D'];

     S=webread(url);
	 xout=[xout;S];
    end
end

out(:,1)=datenum(xout.DateTime);
out(:,2)=table2array(xout(:,2));

% 
% %%
% disp(['Now arranging data for you, please wait... ']);
% c = table2cell(out); % need to change the table to cell as unfortunately tabe datetime is not a string to apply datevec
% for i=1:length(c);
% d_vec(i,:)=datevec(c{i,1});
% wl(i,1)=c{i,2};
% end;
% final_out=[d_vec(:,1:4),wl];
% %%
% % write data to csv file
% T = array2table(final_out,'VariableNames',{'Year','Month','Day','Time','WL'});% covert to table to write in csv file
% output_file_name=strcat(stationID,'_',int2str(st_yr),'_',int2str(end_yr),'.csv');
% writetable(T,output_file_name);
% %%
%                                     %%%%%%%%%%%%%% END %%%%%%%%%%%%%%%%%%%%

