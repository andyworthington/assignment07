clear;close all;clc;
I1 = imread('toys.jpg');
I2 = imread('toy.jpg');

% Generate points of interest structures
Ipts1 = OpenSurf(I1);
Ipts2 = OpenSurf(I2);

% Grab just the descriptor vectors
for indexMode = 1:length(Ipts1)
    D1(:,indexMode) = Ipts1(indexMode).descriptor;
end

for j = 1:length(Ipts2)
    D2(:,j) = Ipts2(j).descriptor;
end

% Compare two images
BaseLength = length(Ipts1);
SubLength = length(Ipts2);

for i = 1:BaseLength
    subtract = ( repmat(D1(:,i), [1 SubLength]) - D2).^2;
    distance = sum(subtract);
    [SubValue(i) SubIndex(i)] = min(distance);
end

% Sort matches
[value, index] = sort(SubValue);
% index = index(1:40);


% index = index(1:20);

% Associate index values
BaseIndex = index;
SubIndex = SubIndex(index);

% Generate positions of points
Pos1 = [ [Ipts1(BaseIndex).y]', [Ipts1(BaseIndex).x]' ];
Pos2 = [ [Ipts2(SubIndex).y]', [Ipts2(SubIndex).x]'];

diffX = Pos2(:,2) - Pos1(:,2);
diffY = Pos2(:,1) - Pos1(:,1);

angles = atan2d(diffY, diffX);
angles = round(angles);
angle = mode(angles);

indexMode = find(angles > angle -1 & angles < angle + 1);

%% Need to sort and filter these lines by length

% Plot points on both images
I = cat(2,I1,I2);
figure, imshow(I); hold on;
plot( [Pos1(indexMode,2) Pos2(indexMode,2) + size(I1,2)]', [Pos1(indexMode,1) Pos2(indexMode,1)]', ...
    's-','linewidth',2);
% plot( [Pos1(:,2) Pos2(:,2) + size(I1,2)]', [Pos1(:,1) Pos2(:,1)]', ...
%     's-','linewidth',2);

%% Base and Sub
I3 = imread('base.jpg');
I4 = imread('sub.jpg');

% Generate points of interest structures
Ipts1 = OpenSurf(I3);
Ipts2 = OpenSurf(I4);

% Grab just the descriptor vectors
for indexMode = 1:length(Ipts1)
    D3(:,indexMode) = Ipts1(indexMode).descriptor;
end

for j = 1:length(Ipts2)
    D4(:,j) = Ipts2(j).descriptor;
end

% Compare two images
BaseLength = length(Ipts1);
SubLength = length(Ipts2);

for i = 1:BaseLength
    subtract = ( repmat(D3(:,i), [1 SubLength]) - D4).^2;
    distance = sum(subtract);
    [SubValue(i) SubIndex(i)] = min(distance);
end

% Sort matches
[value, index] = sort(SubValue);
% index = index(1:10);


% index = index(1:20);

% Associate index values
BaseIndex = index;
SubIndex = SubIndex(index);

% Generate positions of points
Pos1 = [ [Ipts1(BaseIndex).y]', [Ipts1(BaseIndex).x]' ];
Pos2 = [ [Ipts2(SubIndex).y]', [Ipts2(SubIndex).x]'];

diffX = Pos2(:,2) - Pos1(:,2);
diffY = Pos2(:,1) - Pos1(:,1);

angles = atan2d(diffY, diffX);
angles = round(angles);
angle = mode(angles);

indexMode = find((angles > angle -1) & (angles < angle + 1));

%% Need to sort and filter these lines by length

% Plot points on both images
I = cat(2,I3,I4);
figure, imshow(I); hold on;
plot( [Pos1(indexMode,2) Pos2(indexMode,2) + size(I3,2)]', [Pos1(indexMode,1) Pos2(indexMode,1)]', ...
    's-','linewidth',2);
% plot( [Pos1(:,2) Pos2(:,2) + size(I3,2)]', [Pos1(:,1) Pos2(:,1)]', ...
%     's-','linewidth',2);