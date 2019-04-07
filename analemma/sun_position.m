addpath('functions/');

inputs;

% day_start = datenum(2018, 1, 1, 00, 0, 0);
% day_end = datenum(2018, 1, 1, 23, 59, 59);
% DN = day_start:(1)/(24*60):day_end;

% datenum
DN = day_start:day_end;


Time = pvl_maketimestruct(DN, -7);
[SunAz, SunEl, ApparentSunEl, SolarTime]=pvl_ephemeris(Time, Location);


% [SunAz1, SunEl1, ApparentSunEl1]=pvl_spa(Time, Location);


sun_header = {'yy', 'mm', 'dd', 'HH', 'MM', 'ss', 'datenum', 'Sun_Azimuth', 'ApparentSunEl'}; 
sun_data = [datevec(DN') DN' SunAz ApparentSunEl];

current_time = strftime("%Y%m%d_%H%M%S", localtime(time()));
filename = ['sunpos_' current_time '.dat'];

% if not(isdir(path_results))
	% mkdir(path_results);
% end

outfile = [path_results filename];

% fid = fopen(outfile, 'w');
% if fid == -1; error('Cannot open file: %s', outfile); end
% fprintf(fid, ['Lat\t',num2str(Location.latitude), '\n']);
% fprintf(fid, ['Lon\t',num2str(Location.longitude), '\n']);
% fprintf(fid, ['Alt\t',num2str(Location.altitude), '\n\n']);
% fprintf(fid, '%s\t', sun_header{:});
% Fmt = [repmat('%g\t', size(sun_data, 2)), '\n'];
% fprintf(fid, Fmt, transpose(sun_data));
% fprintf(fid, '\n');
% fclose(fid);
% dlmwrite(outfile,sun_data,'delimiter','\t','-append');

figure
plot(SunAz,ApparentSunEl)

% dHr = Time.hour+Time.minute./60+Time.second./3600; % Calculate decimal hours for plotting
% figure
% plot(dHr,ApparentSunEl)
% figure
% plot(SunAz, dHr)
% hold all
% plot(SolarTime,SunAz)
% legend('ephemeris','spa')
% title('Solar Elevation Angle on Jan 1, 2012 in Albuquerque, NM','FontSize',14)
% xlabel('Hour of the Day (hr)')
% ylabel('Solar Elevation Angle (deg)')
% dif = ApparentSunEl1-ApparentSunEl;

% figure
% hist(dif,100)
% title({'Differences Between pvl\_ephemeris and pvl\_spa';'Albuquerque, NM Jan 1, 2012)'},'FontSize',14)
% xlabel('Sun Elevation Differences (degrees)')
% ylabel('frequency')
