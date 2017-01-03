% Magnetic field strength variation from the centre of the bore(114 cms above the ground) along the z axis and at 90 degrees  

close all
clear all

load zaxis_fieldstrength
figure(1)
plot(zaxis_fieldstrength(1:30,1),zaxis_fieldstrength(1:30,2), 'o')
xlabel 'distance from the reference point in the bore(cms)'
ylabel ' Magnetic field strength(T)'

hold on
[P,S,MU] = polyfit(zaxis_fieldstrength(1:30,1),zaxis_fieldstrength(1:30,2),9);

[Y,DELTA] = polyval(P,zaxis_fieldstrength(1:30,1),S,MU);
plot(zaxis_fieldstrength(1:30,1),Y, 'r-');
legend ('Acquired data' , ' fitted polynomial');

figure(2)
gradient = polyder(P);
gradient_new = polyval(gradient,zaxis_fieldstrength(1:30,1),S,MU);
plot(zaxis_fieldstrength(1:30,1),abs(gradient_new), 'g-');
xlabel 'Spatial field gradient'
ylabel ' Magnetic field strength(T)'
legend('Field gradient')


% Repeat

figure(3) 
plot(zaxis_fieldstrength(:,3),zaxis_fieldstrength(:,4), 'o')
xlabel 'distance from the reference point in the bore(cms)'
ylabel ' Magnetic field strength(T)'
legend('Acquired data','Fitted polynomial')

hold on
[P,S,MU] = polyfit(zaxis_fieldstrength(1:30,3),zaxis_fieldstrength(1:30,4),9);

[Y,DELTA] = polyval(P,zaxis_fieldstrength(1:30,3),S,MU);
plot(zaxis_fieldstrength(1:30,3),Y, 'r-');    

figure(4)
gradient = polyder(P);
gradient_new = polyval(gradient,zaxis_fieldstrength(1:30,3),S,MU);
plot(zaxis_fieldstrength(1:30,3),abs(gradient_new), 'g-');
legend('Field gradient')


%% 
% Magnetic field strenght variation along the z axis at height 94 cms from
% the ground 

clear all
close all
load zaxis_94
plot(zaxis_94(1:30,1),zaxis_94(1:30,2),'.')
xlabel 'distance from the reference point in the bore(cms)'
ylabel ' Magnetic field strength(T)'

hold on 

[P,S,MU] = polyfit(zaxis_94(1:30,1),zaxis_94(1:30,2),9);

[Y,DELTA] = polyval(P,zaxis_94(1:30,1),S,MU);
plot(zaxis_94(1:30,1),Y, 'r-');

gradient = polyder(P);
gradient_new = polyval(gradient,zaxis_94(1:30,1),S,MU);
plot(zaxis_94(1:30,1),abs(gradient_new), 'g-');
legend('Acquired data','Fitted polynomial', 'Field gradient')




%%

% Magnetic field strength variation along the z axis with couch lowered 
%(57 cms from the ground)

clear all
close all

load zaxis_couchlowered
plot(zaxis_couchlowered(:,1),zaxis_couchlowered(:,2))
xlabel 'distance from the reference point in the bore(cms)'
ylabel ' Magnetic field strength(T)'

hold on
[P,S,MU] = polyfit(zaxis_couchlowered(:,1),zaxis_couchlowered(:,2),9);

[Y,DELTA] = polyval(P,zaxis_couchlowered(:,1),S,MU);
plot(zaxis_couchlowered(:,1),Y, 'r-');    
hold on 
gradient = polyder(P);
gradient_new = polyval(gradient,zaxis_couchlowered(:,1),S,MU);
plot(zaxis_couchlowered(:,1),abs(gradient_new), 'g-');

legend('Acquired data','Fitted polynomial', 'Field gradient')

%% forty five degrees at height of 114 cms above ground (centre of the bore) 

clear all
close all
load field_plotting_fortyfive
figure(1)
plot(field_plotting_fortyfive(:,1),field_plotting_fortyfive(:,2))
xlabel 'distance from the reference point in the bore(cms)'
ylabel ' Magnetic field strength(T)'
hold on
[P,S,MU] = polyfit(field_plotting_fortyfive(:,1),field_plotting_fortyfive(:,2),6);

[Y,DELTA] = polyval(P,field_plotting_fortyfive(:,1),S,MU);
plot(field_plotting_fortyfive(:,1),Y, 'r-');
hold on 
gradient = polyder(P);
gradient_new = polyval(gradient,field_plotting_fortyfive(:,1),S,MU);
plot(field_plotting_fortyfive(:,1),abs(gradient_new), 'g-');
legend('Acquired data','Fitted polynomial', 'Field gradient')

% Repeat 

load field_plotting_fortyfive
figure(2)
plot(field_plotting_fortyfive(1:25,3),field_plotting_fortyfive(1:25,4))
xlabel 'distance from the reference point in the bore(cms)'
ylabel ' Magnetic field strength(T)'

hold on
[P,S,MU] = polyfit(field_plotting_fortyfive(1:25,3),field_plotting_fortyfive(1:25,4),9);

[Y,DELTA] = polyval(P,field_plotting_fortyfive(1:25,3),S,MU);
plot(field_plotting_fortyfive(1:25,3),Y, 'r-');
hold on 
gradient = polyder(P);
gradient_new = polyval(gradient,field_plotting_fortyfive(1:25,3),S,MU);
plot(field_plotting_fortyfive(1:25,3),abs(gradient_new), 'g-');
legend('Acquired data','Fitted polynomial', 'Field gradient')

%%

% Forty five degrees at 94 cms above ground

clear all
close all
load fortyfive_deg_normal_couch_position
x = fortyfive_deg_normal_couch_position(:,1);
y = fortyfive_deg_normal_couch_position(:,2);
plot(x,y)
xlabel 'distance from the reference point in the bore(cms)'
ylabel ' Magnetic field strength(T)'

hold on

[P,S,MU] = polyfit(x,y,9);

[Y,DELTA] = polyval(P,x,S,MU);
plot(x,Y, 'r-');
hold on 
gradient = polyder(P);
gradient_new = polyval(gradient,x,S,MU);
plot(x,abs(gradient_new), 'g-');
legend('Acquired data','Fitted polynomial', 'Field gradient')

%% Espree %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Along the z axis (normal couch position)

clear all
close all
load Espree_zaxis
figure(1)
x = Espree_zaxis(:,1);
y = Espree_zaxis(:,2);
plot(x,y,'.')
xlabel 'distance from the reference point in the bore(cms)'
ylabel ' Magnetic field strength(T)'
hold on

[P,S,MU] = polyfit(x,y,9);

[Y,DELTA] = polyval(P,x,S,MU);
plot(x,Y, 'r-');


gradient = polyder(P);
gradient_new = polyval(gradient,x,S,MU);
figure (2)
plot(x,abs(gradient_new), 'g-');
hold on

Force = abs(gradient_new).*Y; % Relative force = B*dB/dx
plot(x,Force, 'm')
legend('Acquired data','Fitted polynomial', 'Field gradient','Relative Force')

