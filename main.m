clear all;

% Parameters (play around with different images and different parameters)
N = 200;     % For Square, Circle, Shape (0.2, 1.0, 0.5, 0.01, 1.0, 1.0, 1.0, 1.0) (Brain also partially)
alpha = 0.2; %0.5, 0.2, 0.5, 0.15, 0.5, 1.0, 0.7, 1.0
beta = 1.0;  %0.5
gamma = 0.5;
kappa = 0.01;
Wline = 1.0;   
Wedge = 1.1; %2.0
Wterm = 1.0;
sigma = 0.5;

% Load image
I = imread('images/dental.png'); %brain.png %circle.jpg
imshow (I);
hold on;

if (ndims(I) == 3)
    I = rgb2gray(I);
end

% Initialize the snake
[x, y] = initializeSnake(I);

% Calculate external energy
I_smooth = double(imgaussfilt(I, sigma));
Eext = getExternalEnergy(I_smooth,Wline,Wedge,Wterm);

% Calculate matrix A^-1 for the iteration
Ainv = getInternalEnergyMatrix(size(x,2), alpha, beta, gamma);

% Iterate and update positions
displaySteps = floor(N/10);

%Taken transpose to maintain consistency 

[xrow xcol] = size(x);

fprintf ("Rows of x : %i\n", xrow);
fprintf ("Cols of x : %i\n", xcol);

[yrow ycol] = size (y);

fprintf ("Rows of y : %i\n", yrow);
fprintf ("Cols of y : %i\n", ycol);

x = x';
y = y';

[xrow xcol] = size (x);

fprintf ("Rows of x : %i\n", xrow);
fprintf ("Cols of x : %i\n", xcol);

for i=1:N
    % Iterate
    [x,y] = iterate(Ainv, x, y, Eext, gamma, kappa);

    % Plot intermediate result
    imshow(I); 
    hold on;
    plot([x ; x(1)], [y ; y(1)], 'r');
        
    % Display step
    if(mod(i,displaySteps)==0)
        fprintf('%d/%d iterations\n',i,N);
    end
    
    pause(0.0001)
end
 
if(displaySteps ~= N)
    fprintf('%d/%d iterations\n',N,N);
end