clc 
clear all
%loads the robot
%the coordinates mentioned are the most suitable for
%getting a complete look at the model
robot = loadrobot('abbYumi', 'Gravity', [0 0 -9.81]);
iviz = interactiveRigidBodyTree(robot);
ax = gca;
%builds collision objecta around the robot
plane = collisionBox(1.5,1.5,0.05);
plane.Pose = trvec2tform([0.25 0 -0.025]);
show(plane,'Parent', ax);

leftShelf = collisionBox(0.25,0.1,0.2);
leftShelf.Pose = trvec2tform([0.3 -.65 0.1]);
[~, patchObj] = show(leftShelf,'Parent',ax);
%color is roken down in RGB components with 1x1 denoting
%Red, 1x2 denoting Green and 1x3 denoting Blue
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
iviz.MarkerBodyName = "gripper_r_base";
iviz.MarkerBodyName = "yumi_link_2_r";
iviz.MarkerControlMethod = "JointControl";

load abbYumiSaveTrajectoryWaypts.mat
removeConfigurations(iviz) % Clear stored configurations
% Start at a valid starting configuration
iviz.Configuration = startingConfig;
addConfiguration(iviz)
% Specify the entire set of waypoints
iviz.StoredConfigurations = [startingConfig, ...
 graspApproachConfig, ...
 graspPoseConfig, ...
 graspDepartConfig, ...
 placeApproachConfig, ...
 placeConfig, ...
 placeDepartConfig, ...
 startingConfig];

numSamples = 100*size(iviz.StoredConfigurations, 2) + 1;
[q,~,~, tvec] = trapveltraj(iviz.StoredConfigurations,numSamples,'EndTime',7);
iviz.ShowMarker = false;
showFigure(iviz)
rateCtrlObj = rateControl(numSamples/(max(tvec) + tvec(4)));
for i = 1:numSamples
 iviz.Configuration = q(:,i);
 waitfor(rateCtrlObj);
end
load abbSavedConfigs.mat configSequence
% Define initial state
q0 = configSequence(:,1); % Position
dq0 = zeros(size(q0)); % Velocity
ddq0 = zeros(size(q0)); % Acceleration
simout = sim('modelWithSimplifiedSystemDynamics.slx');

% Visualize the motion using the interactiveRigidBodyTree object.
iviz.ShowMarker = false;
iviz.showFigure;
rateCtrlObj = rateControl(length(simout.tout)/(max(simout.tout)));
for i = 1:length(simout.tout)
    iviz.Configuration = simout.yout{1}.Values.Data(i,:);
    waitfor(rateCtrlObj);
end











