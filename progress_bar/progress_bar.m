
% jay@20190406 14:45

n = 150;

% Initialize progress bar with optinal parameters:
upd = textprogressbar(n, 'barlength', 20, ...
                         'updatestep', 10, ...
                         'startmsg', 'Waiting... ',...
                         'endmsg', ' Yay!', ...
                         'showbar', true, ...
                         'showremtime', true, ...
                         'showactualnum', true, ...
                         'barsymbol', '+', ...
                         'emptybarsymbol', '-');
for i = 1:n
   pause(0.05);
   upd.update(i);
end