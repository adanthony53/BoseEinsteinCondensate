clear all; close all; clc

L = 4*pi;
n = 16;
temp = linspace(-L/2,L/2,n+1);
x = temp(1:n);
y = temp(1:n);
z = temp(1:n);
[X,Y,Z] = meshgrid(x,y,z);

kx = (2*pi/L)*[0:(n/2-1) (-n/2):-1];
kx(1) = 10^-6;
ky = kx;
kz = kx;
[KX,KY,KZ] = meshgrid(kx,ky,kz);
K = KX.^2 + KY.^2 + KZ.^2;

tspan = 0:0.5:4;

A = 1;
B = -A;

init1 = cos(X).*cos(Y).*cos(Z);
finit1 = fftn(init1);
finit1_vec = reshape(finit1, n^3, 1);

init2 = sin(X).*sin(Y).*sin(Z);
finit2 = fftn(init2);
finit2_vec = reshape(finit2, n^3, 1);


tic
[t1,fw1] = ode45(@(t1,fw1) rhs(t1,fw1,X,Y,Z,K,n,A,B),tspan,finit1_vec);
toc

tic
[t2,fw2] = ode45(@(t2,fw2) rhs(t2,fw2,X,Y,Z,K,n,A,B),tspan,finit2_vec);
toc
% 
% A1 = real(fw1);
% A2 = imag(fw1);
% A3 = real(fw2);
% A4 = imag(fw2);
% 
% save('A1.dat','A1','-ascii');
% save('A2.dat','A2','-ascii');
% save('A3.dat','A3','-ascii');
% save('A4.dat','A4','-ascii');

% plotting 
for j=1:length(t1)
    fw1end = reshape(fw1(j,:), [n,n,n]);
    w1end = ifftn(fw1end);
    figure
    isosurface(real(w1end));
end

% for j=1:length(t2)
%     fw2end = reshape(fw2(j,:), [n,n,n]);
%     w2end = ifftn(fw2end);
%     figure
%     isosurface(real(w2end));
% end
