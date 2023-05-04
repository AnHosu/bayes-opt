functions {
  vector nn_forward (matrix X, matrix w1, vector b1, vector w2, real b2) {
    int N = rows(X);
    matrix[N, 10] hidden;         // output of first layer
    vector[N] output;             // output of second layer
    for (n in 1:N) {
        // first layer
        hidden[n] = X[n] * w1 +  b1';
        hidden[n] = inv_logit(hidden[n]);
        // second layer
        output[n] = dot_product(hidden[n], w2) + b2;
    }
    return(output);
  }
}
data {
    int<lower=1> N;               // number of data points
    int<lower=1> K;               // number of predictors
    matrix[N, K] X;               // predictor matrix
    vector[N] y;                  // response vector
}
parameters {
    matrix[K, 10] w1;             // weights for first layer
    vector[10] b1;                // biases for first layer
    vector[10] w2;               // weights for second layer
    real b2;                      // bias for second layer
}
transformed parameters {
  vector[N] output;
  output = nn_forward(X, w1, b1, w2, b2);
}
model {
    // parameter PRIORS!!!
    to_vector(w1) ~ std_normal();
    to_vector(b1) ~ std_normal();
    to_vector(w2) ~ std_normal();
    b2 ~ std_normal();
    y ~ normal(output, 0.2);      // likelihood
}
