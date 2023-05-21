functions {
  // forward pass for a neural network with two hidden layers
  vector nn_forward (matrix X,
                     matrix w1,
                     vector b1,
                     vector w2,
                     real b2,
                     int n_hidden) {
    int N = rows(X);
    matrix[N, n_hidden] hidden; // output of first layer
    vector[N] output;           // network output
    vector[N] ones = rep_vector(1., N);
    hidden = inv_logit(X * w1 + ones * b1');
    output = hidden * w2 + b2;
    return(output);
  }
}
data {
  int<lower=1> N;               // number of data points
  int<lower=1> D;               // number of dimensions
  int<lower=1> M;               // number of points in prediction grid
  matrix[N, D] X;               // matrix of covariates
  vector[N] y;                  // vector of observed responses
  matrix[M, D] X_pred;          // matrix of covariates for prediction grid
  real<lower=0> sigma;          // observation noise
  int<lower=0> n_hidden;        // number of hidden units in the NN
}
parameters {
  matrix[D, n_hidden] w1;       // weights for the first layer
  vector[n_hidden] b1;          // biases for the first layer
  vector[n_hidden] w2;          // weigths for the output layer
  real b2;                      // bias for the output layer
}
transformed parameters {
  vector[N] output;
  output = nn_forward(X, w1, b1, w2, b2, n_hidden);
}
model {
  // parameter priors
  to_vector(w1) ~ normal(0, 3);
  to_vector(b1) ~ normal(0, 3);
  to_vector(w2) ~ normal(0, 3);
  b2 ~ normal(0, 3);
  // likelihood
  y ~ normal(output, sigma);
}
generated quantities {
  // predictions
  vector[M] y_pred;
  y_pred = nn_forward(X_pred, w1, b1, w2, b2, n_hidden);
}
