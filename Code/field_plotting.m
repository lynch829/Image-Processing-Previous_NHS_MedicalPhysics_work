load zaxis_fieldstrength
x = zaxis_fieldstrength(:,1);
y =zaxis_fieldstrength(:,2);
plot(x,y)
xlabel 'distance from the reference point in the bore(cms)'
ylabel ' Magnetic field strength(T)'
title 'Variation of magnetic field strength from the bore along the z axis'
