
# Computational Mathematics for Learning and Data Analysis #

## Non-ML project n.21, Edoardo Federici 616667, Carlo Tosoni 644824, group n.16 ##

---

### Functions ###


__G = graph_intialization(n, e, seed, c, wcon_dim)__ returns a directed graph to define the matrix E.<br/>
_n_ : numbers of nodes of the directed graph.<br/>
_e_ : number of edges of the directed graph.<br/>
_seed_ : seed to generate random numbers.<br/>
_c_ : a boolean variable equal to true if the directed graph (or its components) must be weakly connected or false otherwise.<br/>
_wcon_dim_ : how many nodes each component should have (its length specifies the number of components of the graph).<br/>

__[D, E, b, c] = system_initialization(G, eig_val, dim, range, lin_dip, seed, del_row)__ returns the matrices D, E, b and c that outline the system of our project.<br/>
_G_ : directed graph to compute edge-node incidence matrix E.<br/>
_eig_val_ : the eigenvalues of the diagonal matrix D.<br/>
_dim_ : how many times an eigenvalue is a root of the characteristic polynomial.<br/>
_range_ : the range over which the other non user-specified eigenvalues are randomly created (uniformly distribution).<br/>
_lin_deep_ : boolean variable to determine if the system has a solution.<br/>
_s_ : seed to generate random numbers.<br/>
_del_row_ : boolean variable to determine if _c_ has linearly independent rows or is random.<br/>


__[A, s] = system_assembly(D, E, b, c)__ combines the matrices _E_, _D_, _b_ and _c_ to form a linear system of the type _Ax = s_.<br/>
_D_ : diagonal matrix of the system.<br/>
_E_ : edge-node incidence matrix of a given directed graph.<br/>
_b_ : vector from the linear system _Dx+E'y=b_.<br/>
_c_ : vector from the linear system _Ex=c_.<br/>

__[x, r, d] = conjugate_gradient(s, f, n)__ executes the conjugate gradient method on the system described in the section __(A1)__ of the project. It returns the matrix _x_ of the approximated solutions of the system computed at each step, the matrix _r_ of the residuals, on the matrix _d_ of the conjugate vectors.<br/>
_s_ : the vector of the constant terms of our system.<br/>
_f_ : function handle to compute the product _E*inv(D)*E'*d_ at each iteration of the conjugate gradient (pass the argument _f=@(d)matrices\_product(E, D, d)_).<br/>
_n_ :  number of iterations that the algorithm has to compute.<br/>

__s = create_vector_s(E, D, b, c)__ computes the vector of the constant terms of the system _(E*inv(D)*E^{T})y=ED^{-1}b-c_. The parameters of the function are the matrices and the vectors of that system.<br/>
_s_ : the vector of the constant terms of the system.<br/>

__A = matrices_product(E, D, d)__ returns _w_ which is the product between _E*inv(D)*E^{T}*d_. It is used by the function __conjugate_gradient__<br/>
_E_ :  edge-node adjacency matrix of the given directed graph. <br/>
_D_ :  the diagonal matrix of the system.<br/>
_d_ :  conjugate vector.<br/>

__[r2, r3] = compute_norm(E, D, b, c, x, r)__ computes the norm of the residuals (__r2__) and the A-norm of the approximated solutions _x_ (computed by the conjugate gradient) with respect to the exact solution of the system (__r3__). This method is used to understand how fast the conjugate gradient method is converging to the exact solution of the system.<br/>
_E_ :  edge-node incidence matrix of the given directed graph.<br/>
_D_ :  the diagonal matrix of the system.<br/>
_b_ :  first vector of the costant terms of the original system (before the reduction).<br/>
_c_ :  second vector of the costant terms of the original system (before the reduction).<br/>
_x_ :  matrix of the approximated solutions of the system computed by the conjugate gradient.<br/>
_r_ :  matrix of the residuals computed by the conjugate gradient.<br/>

__[x, Q, H, r] = myminres(A, b, n)__ executes the algorithm MINRES (or GMRES if _A_ in non symmetric) on the system _Ax = b_ as described in the section __(A2)__ of the project. Returns _x_ the approximated solution of the system, _Q_ an orthonormal basis for the krylov subspace, _H_ the tridiagonal matrix of the coefficients to obtain the vector _Aq_ and _r_ the vector which store the norm of the residual obtained at each step.<br/>
_A_ :  symmetrix matrix of the linear system _Ax=b_.<br/>
_b_ :  vector of the constant terms of the system _Ax=b_.<br/>
_n_ :  number of Arnoldi iterations.<br/>

__[Q, H] = arnoldi_iter(A, b, n, Q, H)__ computes a single Arnoldi iteration for the function __minres__. It takes the old version of the matrices _Q_ and _H_ and updates them.<br/>
_A_ :  symmetric matrix of the system _Ax = b_. <br/>
_b_ :  vector of the constant terms of the system _Ax=b_.<br/>
_n_ :  number of Arnoldi iteration that the function has to compute.<br/>
_Q_ :  old version of the matrix _Q_.<br/>
_H_ :  old version of the matrix _H_.<br/>

__[B, d, M, precB, precd] = diag_prec(A,s)__ computes a new matrix _B_ and a new vector _d_ that are used to solve a different system. The matrix _B_ is also used to compute a preconditioner, _M_ which then forms a new system _M*Bx=M*d_.<br/>
_A_ : symmetric matrix of the system _Ax = b_.<br/>
_pos_ : how many positions the eigenvalues of _A_ are shifted to the right.<br/>

__[D, E, b, c] = read_from_file()__ reads the matrices _D_, _E_, _b_ and _c_ in format .csv<br/>

---

### How to execute the algorithms (A1) and (A2) ###

<br/>

- &nbsp;Use the function __graph_initialization__ to compute the directed graph G.

- &nbsp;Use the function __system_initialization__ to compute the matrices D, E, b and c.


#### <br/>Algorithm A1 ####

- &nbsp;create the function handle __f = @(d)matrices_product(E, D, d)__.

- &nbsp;create the vector s using the function __create_vector_s__.

- &nbsp;execute the function __conjugate_graddient__ (passing the callback function f to the function).

- &nbsp;(optional) execute the function __compute_norm__ to study the convergence of the conjugate gradient.

#### <br/>Algorithm A2 ####

- &nbsp;use the function __system_assembly__ to compute the system into the form Ax = b.

- &nbsp;execute the function __myminres__.

<br/>

