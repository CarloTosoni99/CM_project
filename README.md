
# Computational Mathematics for Learning and Data Analysis #

## Non-ML project n.21, Edoardo Federici 616667, Carlo Tosoni 644824, group n.16##

---

### Functions ###

__G = graph_intialization(n, e, s)__ returns a directed graph to define the matrix E.<br/> _n_ :&nbsp; numbers of nodes of the directed graph.<br/>_e_ :&nbsp; number of edges of the directed graph.<br/>_s_ :&nbsp; seed to generate random numbers.

__[D, E, b, c] = system_initialization(G, s)__ returns the matrices D, E, b and c that outline the system of our project.<br/> _G_ :&nbsp; directed graph to compute edge-node adjacency matrix E.<br/> _s_ :&nbsp; seed to generate random numbers.

__[A, s] = system_assembly(D, E, b, c)__ combines the matrices E, D, b and c to form a linear system of the type Ax = s.<br/> _D_ :&nbsp; diagonal matrix of the system.<br/> _E_ :&nbsp; edge-node adjacency matrix of a given directed graph.<br/> _b_ :&nbsp; vector from the linear system Dx+E'y=b.<br/> _c_ :&nbsp; vector from the linear system Ex=c.

__w = matrix_vector_product(A, v)__ returns the product betweem the matrix A and the vector v. The algorithms is designed to be efficient for sparse matrices.<br/> _A_ :&nbsp; matrix, A should be a sparse matrix (stored in the sparse format).<br/> _v_ : &nbsp; vector.

__[Q, H, r] = minres(A, b, n)__ executes the algorithm minres on the system Ax = b as described in the section __(A2)__ of the project. Returns Q an orthonormal basis for the krylov subspace, H the tridiagonal matrix of the coefficients to obtain the vector Aq and r the vector which store the norm of the residual obtained at each step.<br/> _A_ :&nbsp; symmetrix matrix of the linear system Ax=b.<br/> _b_ :&nbsp; vector of the constant terms of the system Ax=b.<br/> _n_ :&nbsp; number of Arnoldi iterations.

__[Q, H] = arnoldi_iter(A, b, n, Q, H)__ computes a single Arnoldi iteration for the function __minres__. It takes the old version of the matrices Q and H and updates them.<br/> _A_ :&nbsp; symmetric matrix of the system Ax = b.<br/> _b_ :&nbsp; vector of the constant terms of the system Ax=b.<br/> _n_ :&nbsp; Number of Arnoldi iteration that the function has to compute.<br/> _Q_ :&nbsp; Old version of the matrix Q.<br/> _H_ :&nbsp; old version of the matrix H.

__[x, r, d] = conjugate_gradient(E, D, b, c, f, n)__ executes the conjugate gradient method on the system described in the section __(A1)__ of the project. It returns the matrix x of the approximated solutions of the system computed at each step, the matrix r of the residuals, on the matrix d of the conjugate vectors.<br/> _E_ :&nbsp; edge-node adjacency matrix of the given directed graph.<br/> _D_ :&nbsp; the diagonal matrix of the system.<br/> _b_ :&nbsp; first vector of the costant terms of the original system (before the reduction).<br/> _c_ :&nbsp; second vector of the costant terms of the original system (before the reduction).<br/> _f_ :&nbsp; function handle to compute the product E\*inv(D)\*E'\*d at each iteration of the conjugate gradient (pass the function __matrices_product__).<br/> _n_ :&nbsp; number of iterations that the algorithm has to compute.

__A = matrices_product(E, D, d)__ returns A which is the product between E\*(D\E')\*d. It is used by the function __conjugate_gradient__<br/> _E_ :&nbsp; edge-node adjacency matrix of the given directed graph.<br/> _D_ :&nbsp; the diagonal matrix of the system.<br/> _d_ :&nbsp; conjugate vector.

__[r2, r3] = compute_norm(E, D, b, c, x, r)__ Computes the norm of the residuals (r2) and the A-norm of the approximated solutions x (computed by the conjugate gradient) with respect to the exact solution of the system (r3). This method is used to understand how fast the conjugate gradient method is converging to the exact solution of the system.<br/> _E_ :&nbsp; edge-node adjacency matrix of the given directed graph.<br/> _D_ :&nbsp; the diagonal matrix of the system.<br/> _b_ :&nbsp; first vector of the costant terms of the original system (before the reduction).<br/> _c_ :&nbsp; second vector of the costant terms of the original system (before the reduction).<br/> _x_ :&nbsp; matrix of the approximated solutions of the system computed by the conjugate gradient.<br/> _r_ :&nbsp; matrix of the residuals computed by the conjugate gradient.

Other functions in the repository have been implemented just for testing and are non relevant for the purposes of the project.

---

### How to execute the algorithms (A1) and (A2) ###

<br/>

- &nbsp;Use the function __graph_initialization__ to compute the directed graph G.

- &nbsp;Use the function __system_initialization__ to compute the matrices D, E, b and c.


#### <br/>Algorithm A1 ####

- &nbsp;create the function handle __f = @matrices_product__.

- &nbsp;execute the function __conjugate_graddient__ (passing the callback function f to the function).

- &nbsp;(optional) execute the function __compute_norm__ to study the convergence of the conjugate gradient.

#### <br/>Algorithm A2 ####

- &nbsp;use the function __system_assembly__ to compute the system into the form Ax = b.

- &nbsp;execute the function __minres__.

<br/>

---

### Issues<br/> ###


1. We have implemented the function __matrix_vector_product__ to compute efficiently the product between a sparse matrix and a vector. However it seems that the operator __\*__ of matlab is much faster.

2. We are not sure if we have correctly implemented the callback to compute the product __E\*inv(D)\*E'\*d__ for the algorithm __(A1)__.

3. The prompt of our project states that the "reduced" linear system of [D E'; E 0][x; y] = [b; c] is __(E\*inv(D)\*E)y = (E\*inv(D))b - c__, while, according to us, it should be __(E\*inv(D)\*E')y = (E\*inv(D))b - c__&nbsp; &nbsp; (with E' istead of E).

4. The matrix (E\*inv(D)\*E') is not always positive-definite, indeed this matrix may have eigenvalues equal to 0. Probably it happens because we need some further assumptions on the directed graph G.

5. We have not understood how to compute efficiently the smallest eigenvalues with Arnoldi.