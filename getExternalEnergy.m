function [Eext] = getExternalEnergy(I,Wline,Wedge,Wterm)

[row col] = size (I);

% Eline
eline = I;

% Eedge

[Gradmag Graddir] = imgradient(I);

Eedge = -1 * Gradmag;

disp (Eedge)

% Eterm
mask1 = [-1 1];
mask2 = [-1;1];
mask3 = [1 -2 1];
mask4 = [1;-2;1];
mask5 = [1 -1;-1 1];

cx = conv2(I,mask1,'same');
cy = conv2(I,mask2,'same');
cxx = conv2(I,mask3,'same');
cyy = conv2(I,mask4,'same');
cxy = conv2(I,mask5,'same');

%disp (cx);
%disp (cy);


Eterm = (cyy.*(cx.^2) - 2*(cxy.*cx.*cy) + cxx.*(cy.^2)) ./ ((1 + (cx.^2) + (cy.^2)).^(3/2));

%disp (Eterm);

% Eext

Eext = Wline*eline + Wedge*Eedge + Wterm*Eterm;

%disp (Eext);

end
