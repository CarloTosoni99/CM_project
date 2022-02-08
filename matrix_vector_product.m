function w = matrix_vector_product(A, v)
% This method is used to compute matrix-vector products for sparse matrices
% it allows to decrease the complexity from o(m^2) to o(dm). Where d is the
% average number of nonzero values per row

[i, j, val] = find(A);
w = zeros(size(A,1),1);
for h = 1:length(i)
    w(i(h)) = w(i(h)) + (val(h)*v(j(h)));
end
