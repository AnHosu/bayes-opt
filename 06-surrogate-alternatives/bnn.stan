functions {
  // forward pass for a neural network with two hidden layers
  vector nn_forward (matrix X,
                     matrix w1,
                     vector b1,
                     matrix w2,
                     vector b2,
                     vector w3,
                     real b3) {
    int N = rows(X);
    matrix[N, 10] hidden;       // output of first layer
    matrix[N, 3] hidden2;       // output of the second layer
    vector[N] output;           // network output
    vector[N] ones = rep_vector(1., N);
    hidden = inv_logit(X * w1 + ones * b1');
    hidden2 = inv_logit(hidden * w2 + ones * b2');
    output = hidden2 * w3 + b3;
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
  real<lower=0> sigma;
}
parameters {
  matrix[D, 10] w1;             // weights for the first layer
  vector[10] b1;                // biases for the first layer
  matrix[10, 3] w2;             // weights for the second layer
  vector[3] b2;                 // biases for the second layer
  vector[3] w3;                 // weigths for the output layer
  real b3;                      // bias for the output layer
}
transformed parameters {
  vector[N] output;
  output = nn_forward(X, w1, b1, w2, b2, w3, b3);
}
model {
  // parameter priors
  to_vector(w1) ~ std_normal();
  to_vector(b1) ~ std_normal();
  to_vector(w2) ~ std_normal();
  to_vector(b2) ~ std_normal();
  to_vector(w3) ~ std_normal();
  b3 ~ std_normal();
  // likelihood
  y ~ normal(output, sigma);
}
generated quantities {
  // predictions
  vector[M] y_pred;
  y_pred = nn_forward(X_pred, w1, b1, w2, b2, w3, b3);
}
