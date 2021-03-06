function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%




%J = (1/m) * sum(-y'*log(sigmoid(X*theta)) .- (1.-y)'*log(1.- sigmoid(X*theta))) + (lambda/(2*m))*sum(theta(2:end,:).^2);



%    for l= 1:rows(X)
%    c=Theta1*X(l,:)';
%
%    for i= 1:rows(c)
%    c(i,1)= sigmoid(c(i,1));
%    end
%
%    c = [ones(size(c)(2), 1)';c];
%
%         d= Theta2*c;
%
%         for i= 1:rows(d)
%         d(i,1)= sigmoid(d(i,1));
%         end
%
%         [max_values,p(l, 1)] =max(d, [], 1);
%
%    end
         

X = [ones(m, 1) X]; %Adding a column of ones
          big_delta_2 = [zeros(rows(Theta2), columns(Theta2))];
          big_delta_1 = [zeros(rows(Theta1), columns(Theta1))];
          
          
for l= 1:rows(X)
c=Theta1*X(l,:)';
z_2 = Theta1*X(l,:)';
          
          
for i= 1:rows(c)
    c(i,1)= sigmoid(c(i,1));
    end

c = [ones(size(c)(2), 1)';c];      %Adding a row of ones
z_2 = [ones(size(z_2)(2), 1)';z_2];
     
d= Theta2*c;
       

for i= 1:rows(d)
    d(i,1)= sigmoid(d(i,1));
    end

     
 
       delta_3 = [zeros(num_labels,1)];
     delta_2 = [zeros(rows(Theta2),1)];
     
for k= 1:num_labels
     y_matrix = [zeros(num_labels,1)];
     y_matrix(y(l))=1;
     
     J= J + [-y_matrix(k) * log(d(k)) - (1-y_matrix((k)))*log(1-d(k))];
       delta_3(k) = d(k) - y_matrix(k);
     
    
     
     end
     
     delta_2 = (Theta2'* delta_3).*sigmoidGradient(z_2);
                big_delta_2 = big_delta_2 + delta_3*(c');
                big_delta_1 = big_delta_1 + delta_2(2:end)*(X(l,:));
                
                
       
     

end
                                                     
                                                     
       
     J= J/m;
                                                     
                                                     Theta1_grad = big_delta_1/m;
                                                     Theta2_grad = big_delta_2/m;
                                                     
                                                     Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + Theta1(:, 2:end)*(lambda/m);
                                                     Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + Theta2(:, 2:end)*(lambda/m);
                                                     
                                                     
     
     
     r1= 0;
     r2 =0;
     
     for i = 1:rows(Theta1)
     for j = 2:columns(Theta1)
     r1 = r1 + Theta1(i,j)^2;
     end
     end
     
     for i = 1:rows(Theta2)
     for j = 2:columns(Theta2)
     r2 = r2 + Theta2(i,j)^2;
     end
     end
     
     J= J + (lambda/(2*m))*(r1 + r2);


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
