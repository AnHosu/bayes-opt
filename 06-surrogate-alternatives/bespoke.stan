data {
  int<lower=1> N;               // number of data points
  int<lower=1> D;               // number of dimensions
  int<lower=1> M;               // number of points in prediction grid
  matrix[N, D] X;               // matrix of covariates
  vector[N] y;                  // vector of observed responses
  matrix[M, D] X_pred;          // matrix of covariates for prediction grid
  real<lower=0> sigma_rate;
}
parameters {
  real alpha;
  real beta;
  vector[D] weights;
  real<lower=0> sigma;
}
transformed parameters {
  vector[N] mu;
  mu = alpha * sin(X * weights) + beta;
}
model {
  alpha ~ std_normal();
  beta ~ std_normal();
  weights ~ std_normal();
  sigma ~ exponential(sigma_rate);
  y ~ normal(mu, sigma);
}
generated quantities {
  // predictions
  vector[M] y_pred;
  y_pred = alpha * sin(X_pred * weights) + beta;
}
