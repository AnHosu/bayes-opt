functions {
  vector nn_forward (matrix X, matrix w1, vector b1, matrix w2, vector b2, vector w3, real b3) {
    int N = rows(X);
    matrix[N, 10] hidden;         // output of first layer
    matrix[N, 3] hidden2;
    vector[N] output;             // output of second layer
    vector[N] ones = rep_vector(1., N);
    hidden = inv_logit(X * w1 + ones * b1');
    hidden2 = inv_logit(hidden * w2 + ones * b2');
    output = hidden2 * w3 + b3;
    return(output);
  }
}
data {
    int<lower=1> N;               // number of data points
    int<lower=1> K;               // number of predictors
    int<lower=1> M;               // number of points in prediction grid
    matrix[N, K] X;               // predictor matrix
    vector[N] y;                  // response vector
    matrix[M, K] X_pred;          // prediction grid
    real<lower=0> sigma;
}
parameters {
    matrix[K, 10] w1;             // weights for first layer
    vector[10] b1;                // biases for first layer
    matrix[10, 3] w2;               // weights for second layer
    vector[3] b2;                      // bias for second layer
    vector[3] w3;
    real b3;
}
transformed parameters {
  vector[N] output;
  output = nn_forward(X, w1, b1, w2, b2, w3, b3);
}
model {
    // parameter PRIORS!!!
    to_vector(w1) ~ std_normal();
    to_vector(b1) ~ std_normal();
    to_vector(w2) ~ std_normal();
    to_vector(b2) ~ std_normal();
    to_vector(w3) ~ std_normal();
    b3 ~ std_normal();
    y ~ normal(output, sigma);      // likelihood
}
generated quantities {
  vector[M] y_pred;
  y_pred = nn_forward(X_pred, w1, b1, w2, b2, w3, b3);
}
