function [newX, newY] = iterate(Ainv, x, y, Eext, gamma, kappa)

% Get fx and fy

mask1 = [-1 1];
mask2 = [-1;1];

fx = conv2(Eext,mask1,'same');
fy = conv2(Eext,mask2,'same');

%[fx fy] = imgradientxy()
% Iterate

%fprintf ("Size of Ainv : %i\n", size(Ainv));
%fprintf ("Size of gamma : %i\n", size(gamma));
%fprintf ("Size of x : %i\n", size(x));

%fprintf ("Size of kappa : %i\n", size(kappa));

xs = gamma.*x - kappa.*interp2 (fx,x,y);
ys = gamma.*y - kappa.*interp2 (fy,x,y);

[rows cols] = size(xs);

[rows1 cols1] = size (Ainv);

disp (rows);
disp (cols);

%disp (rows1);
%disp (cols1);

newX = Ainv*xs;
newY = Ainv*ys;

disp (newX);
%disp (newY);

% Clamp to image size
[row cols] = size (Eext);

disp (row);
disp (cols);

for i = 1:size(newX,1)
    if (newX(i,1) > row)
        newX(i,1) = row-1;
            
    elseif (newX(i,1) < 0.0)
        newX(i,1) = 1.0;
    end
end

for j = 1:size(newY,1)
    if (newY(j,1) > cols)
        newY(j,1) = cols-1;
            
    elseif (newY(j,1) < 0.0)
        newY(j,1) = 1.0;
    
    end

end

end
