function s = create_vector_s(E, D, b, c)

% This simple function is used to create the vector s for the algorithm for
% the conjugate gradient method of our system (A1)

s = E*(D\b) - c;