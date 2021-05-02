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

