% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%
%       EBSD datalist to produce Polar Figure 
%       Orientations: Euler Angles (Angle1, Angle2, Angle3)
%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Author: Mark Jace, Github:https://github.com/MarkJace/
%
% The file must be the orientation datalist of points.
% The orientation is expressed by Euler Angles (Angle1, Angle2, Angle3),
close all;
clear all;
% Input 
row_start = 1;
row_end = 3;
euler_type = 'ZYZ';
dire = [0,0,1]';

% Read the datalist
fulldata = load('filename.txt');
data = fulldata(:,row_start:row_end);
[len,wid] = size(fulldata);
rotMtx = zeros(3,3,len);

% Initialization
vecList = zeros(len,3);
rhoList = zeros(len,1);
thetaList = zeros(len,1);
pfMtx = zeros(101,101);
mtxPosi = zeros(len,2); 

for index = 1:1:len
    % Euler angles -> rotation matrix -> oriantation vectors
    eul = data(index,:);
    rot(:,:,index) = eul2rotm(eul,euler_type);
    vec = rot(:,:,index)*dire;

    % vectors to polar coordinates
    if vec(3) < 0
        vec = -1*vec;
        vecList(index,:) = vec;
        psi = acos(dot(vec,dire)/norm(vec)/norm(dire));
    else
        vec = vec;
        psi = acos(dot(vec,dire)/norm(vec)/norm(dire));
    end
    rhoList(index) = tan(0.5*psi);
    
    if vec(1) == 0
        if vec(2) >= 0
            thetaList(index) = 0.5*pi;
        else
            thetaList(index) = 1.5*pi;
        end
    elseif vec(1) > 0
        if vec(2) >= 0
            thetaList(index) = atan(abs(vec(2))/abs(vec(1)));
        else
            thetaList(index) = -1*atan(abs(vec(2))/abs(vec(1)));
        end
    elseif vec(1) < 0
        if vec(2) >= 0
            thetaList(index) = pi-atan(abs(vec(2))/abs(vec(1)));
        elseif vec(2) < 0
            thetaList(index) = pi+atan(abs(vec(2))/abs(vec(1)));
        end
    end
    % polar coordinates to a matrix
    [coorX,coorY] = pol2cart(thetaList(index),rhoList(index));   
    mtxX = ceil(coorX*50+51);
    mtxY = ceil(coorY*50+51);
    mtxPosi(index,:) = [mtxX,mtxY]; 
    % account
    pfMtx(mtxX,mtxY) = pfMtx(mtxX,mtxY)+1;

end
% draw the Polar Figure
x1 = 0:0.1:100;
y1 = 0:0.1:100;
y_up = zeros(1,1001);
y_dn = zeros(1,1001);
for index = 1:1:1001
    y_up(index) = 50+sqrt(2500-(x1(index)-50)^2);
    y_dn(index) = 50-sqrt(2500-(x1(index)-50)^2);
end
x0 = 50*ones(1,1001);
y0 = 50*ones(1,1001);

contour(pfMtx');
axis square;
hold on;
plot(x1,y_up,'k');
hold on;
plot(x1,y_dn,'k');
hold on;
plot(x1,y0,'k');
hold on;
plot(x0,y1,'k');
axis off;
text(-10,100,'0001');
text(50,103,'y0');
text(102,50,'x0');


