function g = sigmoid(z)
%SIGMOID Compute sigmoid function
%   g = SIGMOID(z) computes the sigmoid of z.

% You need to return the following variables correctly 
g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the sigmoid of each value of z (z can be a matrix,
%               vector or scalar).

%col = columns(g);
%row = rows(g);

col = 1;
row = 1;

while row <= rows(g)
    while col <= columns(g)
        g(row, col) = 1/(1+e^-(z(row, col)));
        col = col + 1;
        end;
    col = 1;
    row = row+1;
end


% =============================================================

end
