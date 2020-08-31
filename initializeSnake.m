function [x, y] = initializeSnake(I)

% Show figure

imshow (I);

% Get initial points
[x1, y1] = getpts();

xy (:,1) = x1(:,1);
xy (:,2) = y1(:,1);

%xy (size(xy,1)+1,:) = xy (1,:);

%disp (xy);

xy (size(xy,1)+1,:) = xy(1,:);

%disp (xy);

% Interpolate
t = 1:size(xy,1);
%ts = 1: 0.15: size(xy,1);
ts = linspace (1, size(xy,1),100);
%xys = spline(t,xy,ts);


%x=spline(t,xy(:,1),ts);
%y=spline(t,xy(:,2),ts); 


x = interp1(t,xy(:,1),ts,'spline');
y = interp1(t,xy(:,2),ts,'spline');

%x (1,size(x,2)+1) = x(1,1);
%y (1,size(y,2)+1) = y(1,1);

%disp (x (1,size(x,2)));
%disp (y (1,size(y,2)));

%disp (x);
%disp(y);

[row cols] = size (I);

disp (row);
disp (cols);

% Clamp points to be inside of image

for i = 1:size(x,2)
    if (x(1,i) > row)
        x(1,i) = row-1;
            
    elseif (x(1,i) < 0.0)
        x(1,i) = 1.0;
end

for j = 1:size(y,2)
    if (y(1,j) > cols)
        y(1,j) = cols-1;
            
    elseif (y(1,j) < 0.0)
        y(1,j) = 1.0;
    
    end
end

%disp (x);
%disp (y);

plot (x,y,'b-','LineWidth',2);

end
