%% Test script
clear all
close all
clc
%% Tests
testShapeFunctions();
testAffineMapping();
%% Shape functions
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

%% Affine mapping

function testAffineMapping()
    v0 = [1; 0];
    v1 = [3; 1];
    v2 = [3; 2];
    i = 1;
    step = 0.01;
    xMapped = zeros(1,5146);
    yMapped = zeros(1,5146);
    for x = 0:step:1
        for y = 0:step:1-x
            mapped = getAffineMapping(v0,v1,v2,[x;y],false);
            xMapped(i) = mapped(1);
            yMapped(i) = mapped(2);
            i = i + 1;
        end
    end
    figure
    plot(xMapped,yMapped,"*b");
    hold on
    xHat = zeros(1,5146);
    yHat = zeros(1,5146);
    for i = 1:length(xMapped)
        nonMapped = getAffineMapping(v0,v1,v2,[xMapped(i); yMapped(i)],true);
        xHat(i) = nonMapped(1);
        yHat(i) = nonMapped(2);
    end
    plot(xHat,yHat,"*r")
    legend("Mapped to K_0","Reference element")
end