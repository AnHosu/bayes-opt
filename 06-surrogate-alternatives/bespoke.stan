functions {
  vector bespoke_model(vector X, real alpha, real beta) {
    return(X .* sin(X * alpha) + beta);
  }
}
data {
  int<lower=1> N;               // number of data points
  int<lower=1> M;               // number of points in prediction grid
  vector[N] X;               // matrix of covariates
  vector[N] y;                  // vector of observed responses
  vector[M] X_pred;          // matrix of covariates for prediction grid
  real<lower=0> sigma_rate;
}
parameters {
  real<lower=0> alpha;
  real beta;
  real<lower=0> sigma;
}
transformed parameters {
  vector[N] mu;
  mu = bespoke_model(X, alpha, beta);
}
model {
  alpha ~ normal(6, 2);
  beta ~ normal(5, 2);
  sigma ~ exponential(sigma_rate);
  y ~ normal(mu, sigma);
}
generated quantities {
  // predictions
  vector[M] y_pred;
  y_pred = bespoke_model(X_pred, alpha, beta);
}
