%% Test script
%% Shape functions
testShapeFunctions();


function testShapeFunctions()
    % First test for nodal basis:
    v = {[0,0],[1,0],[0,1]}; %vertices
    for i = 0:2
        for j = 0:2
            phi = shapeFunctions(v{j+1},i);
            if (round(phi,10) == 1 && i == j) || round(phi,10) == 0
                continue; 
            end
            error("Not a nodal basis. phi = %f, (i,j) = (%d,%d).",phi,i,j);
        end
    end
    fprintf("The shape functions form a nodal basis! \n");
    % then test that for any x in K, the sum of shape functions = 1:
    steplength = 0.001;
    for x = 0: steplength: 1
        for y = 0: steplength: 1-x
            sum = shapeFunctions([x y], 0) + shapeFunctions([x y], 1) ...
                + shapeFunctions([x y], 2);
            if round(sum,10) ~= 1
                error("Sum of shape functions are not 1, it is %f.",sum);
            end
        end
    end
    fprintf("The sum of shape functions equal 1 for all x in K! \n");
end