function [Ainv] = getInternalEnergyMatrix(nPoints, alpha, beta, gamma)

%disp (nPoints);
%disp (nPoints.size(2))

%disp (alpha);

%disp (gamma);

b(1)=beta;
b(2)=-1*(alpha+4*beta);
b(3)=(2*alpha+6*beta);
b(4)=b(2);
b(5)=b(1);
 
A_mat=b(1)*circshift(eye(nPoints),2);
A_mat=A_mat+b(2)*circshift(eye(nPoints),1);
A_mat=A_mat+b(3)*circshift(eye(nPoints),0);
A_mat=A_mat+b(4)*circshift(eye(nPoints),-1);
A_mat=A_mat+b(5)*circshift(eye(nPoints),-2);

Ainv=inv(A_mat + gamma.* eye(nPoints));


end
