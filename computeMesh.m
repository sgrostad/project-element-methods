function [elements, vertices] = computeMesh(Kx, Ky)
    hx = 1 / Kx;
    hy = 1 / Ky;
    numElements = 2 * Kx * Ky;
    numVertices = (1+Kx) * (1+Ky);
    elements = zeros(3, numElements); % each column contains the indices to the vertices to the corresponding triangle
    vertices = zeros(2, numVertices); % each column contains the coordinates to each vertice.
    for j = 1:Ky
        for i = 1:Kx
            % create vertices indices
            v0 = (j-1) * (Kx+1) + 1;
            v1 = v0 + 1;
            v2 = v0 + Kx + 1;
            v3 = v3 + 1;
            % create two new elements
            elements(:,v0) = [v0; v1; v3]; 
            elements(:,v1) = [v0; v3; v2];
            % TODO create vertices
        end
    end
end