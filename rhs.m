function dwdt = rhs(t,fw_vec,X,Y,Z,K,n,A,B)
% 3D tensor f-space
fw = reshape(fw_vec, [n,n,n]);
% 3D tensor normal space
w = ifftn(fw);


rhs = 1i*(0.5*-K.*fw - ...
          fftn((abs(w).^2).*w) + ...
          fftn((A*(sin(X).^2)+B).* ...
               (A*(sin(Y).^2)+B).* ...
               (A*(sin(Z).^2)+B).*w));

dwdt = reshape(rhs, n^3, 1);
end




