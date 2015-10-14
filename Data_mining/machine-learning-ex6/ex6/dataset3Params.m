function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%


error=ones(5);
step=1;
min_error=1;
sum_error_diff=1;
while (abs(min_error)> 0.01 & step<10 & abs(sum_error_diff/25)>0.005 )

[C_matrix,sigma_matrix] = Matrix(C,sigma,step);

for i = 1:5
for j = 1:5

model=svmTrain(X, y, C_matrix(i,j), @(x1, x2) gaussianKernel(x1, x2, sigma_matrix(i,j)));
predictions = svmPredict(model, Xval);
error(i,j)=mean(double(predictions ~= yval));
endfor
endfor

error
[rowvalue,rowind]=min(error);
[colvalue,colind]=min(min(error));


colindex=colind;
rowindex=rowind(colind);
C=C_matrix(rowindex,colindex);
sigma=sigma_matrix(rowindex,colindex);
step=step+1
sum_error_diff=sum(sum(error-min_error))
min_error=colvalue

endwhile



% =========================================================================

end

function [C_matrix,sigma_matrix] =Matrix(C,sigma,step)

fold=(1/2)^step;
C_base=[-2,-1,0,1,2;-2,-1,0,1,2;-2,-1,0,1,2;-2,-1,0,1,2;-2,-1,0,1,2;];
sigma_base=C_base';
C_matrix=C+C*fold*C_base;
sigma_matrix=sigma+sigma*fold*sigma_base;
end

