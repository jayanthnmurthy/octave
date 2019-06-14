% 14.06.2019 -- Jay

% *************** To refer/compare ***************************
addpath('pvlib_functions/');

Location.latitude = 47.9990;
Location.longitude = 7.8421;
Location.altitude = 300;

DN = datenum(2019, 6,1):1/(24*60):datenum(2019, 6, 1, 23, 59, 59); 
Time = pvl_maketimestruct(DN, +1);
%
[SunAz, SunEl, ApparentSunEl, SolarTime]=pvl_ephemeris(Time, Location);

SurfTilt = 29*ones(size(SunAz));
SurfAz = 180*ones(size(SunAz));
SunZen = 90 - SunEl;
% SunAz = [100, 120, 150, 180, 220]';

aoi_tilt_ref = pvl_getaoi(SurfTilt, SurfAz, SunZen, SunAz);
dHr = Time.hour+Time.minute./60+Time.second./3600; % Calculate decimal hours for plotting
figure
plot(dHr,ApparentSunEl)
ylim([0 90])
title('Solar Elevation Angle on June 1, 2019 in Freiburg, DE','FontSize',14)
xlabel('Hour of the Day (hr)')
ylabel('Solar Elevation Angle (deg)')
hold on
% disp('obtained from pv-library:')
% disp(aoi_tilt_ref)
% ************************************************************


% **************** Axis-shifting *****************************
theta_0 = SunZen;
phi_0 = SunAz;
% Tilt vector/surface parameters
theta_t = SurfTilt;
phi_t = SurfAz;

% Get cartesian-coordinates
x0 = sind(theta_0).*cosd(phi_0);
y0 = sind(theta_0).*sind(phi_0);
z0 = cosd(theta_0);
v_0 = [x0 y0 z0]';

xt = sind(theta_t).*cosd(phi_t);
yt = sind(theta_t).*sind(phi_t);
zt = cosd(theta_t);
v_t = [xt yt zt]';

% disp([norm(v_0) norm(v_t)])

% Angle between vectors -- relative (r)
theta_r = acosd(dot(v_0,v_t))';
phi_r = phi_0 - phi_t;
phi_r(phi_r<0) = 360 + phi_r(phi_r<0);


plot(dHr,(90-theta_r))
legend('Horizontal-plane','Tilted-plane')
% disp('Calculated:')
% disp([theta_r phi_r])
% plot(phi_r, theta_r)
% arrow3(zeros(size([v_0 v_t]')),[v_0 v_t]')

% Rotation matrices
% R1 = [...
      % cosd(phi_t), sind(phi_t), 0; ...
     % -sind(phi_t), cosd(phi_t), 0; ...
        % 0        ,      0     , 1 ...
      % ];
% R2 = [...
      % cosd(theta_t), 0, -sind(theta_t); ...
           % 0     , 1,       0     ; ...
      % sind(theta_t), 0,  cosd(theta_t) ...
      % ];
    