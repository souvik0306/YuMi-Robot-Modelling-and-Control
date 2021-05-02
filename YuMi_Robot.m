clc 
clear all
%loads the robot
%the coordinates mentioned are the most suitable for
%getting a complete look at the model
robot = loadrobot('abbYumi', 'Gravity', [0 0 -9.81]);
iviz = interactiveRigidBodyTree(robot);
ax = gca;
%builds a collision object for the robotic arm
plane = collisionBox(1.5,1.5,0.05);
plane.Pose = trvec2tform([0.25 0 -0.025]);
show(plane,'Parent', ax);

leftShelf = collisionBox(0.25,0.1,0.2);
leftShelf.Pose = trvec2tform([0.3 -.65 0.1]);
[~, patchObj] = show(leftShelf,'Parent',ax);
patchObj.FaceColor = [0 0 1];

rightShelf = collisionBox(0.25,0.1,0.2);
rightShelf.Pose = trvec2tform([0.3 .65 0.1]);
[~, patchObj] = show(rightShelf,'Parent',ax);
patchObj.FaceColor = [0 0 1];

leftWidget = collisionCylinder(0.01, 0.07);
leftWidget.Pose = trvec2tform([0.3 -0.65 0.225]);
[~, patchObj] = show(leftWidget,'Parent',ax);
patchObj.FaceColor = [1 0 0];

rightWidget = collisionBox(0.03, 0.02, 0.07);
rightWidget.Pose = trvec2tform([0.3 0.65 0.225]);
[~, patchObj] = show(rightWidget,'Parent',ax);
patchObj.FaceColor = [1 0 0];

centerTable = collisionBox(0.5,0.3,0.05);
centerTable.Pose = trvec2tform([0.75 0 0.025]);
[~, patchObj] = show(centerTable,'Parent',ax);
patchObj.FaceColor = [0 1 0];


