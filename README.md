# Bayesian Optimisation Tools and Tutorials

This is the repo for my Bayesian optimisation project. For rendered versions of this page and individual sections, visit [my website](https://anhosu.com/project/bayesian-optimisation/).

When trying to optimise valuable industrial processes, like manufacturing, drug development, or supply chains, I often encounter the same challenge. There is little relevant historical data available and it is extremely expensive to conduct experiments on the process.

My go-to tool in these cases is Bayesian optimisation.

Bayesian optimisation is a powerful tool to perform optimisation of opaque, complex processes. Bayesian optimisation uses a probabilistic model as a surrogate for the opaque process. This model is updated with sequential experiments that the model itself helps design. With relatively few experiments, Bayesian optimisation can find good maxima or minima.

The probabilistic model allows us to incorporate our prior knowledge about the process at hand and gives us a head start in the optimisation. However, for the same reason, Bayesian optimisation is sensitive to initial assumptions, and there are a lot of moving parts.

With this project, I aim to introduce and discuss the components of Bayesian optimisation. However, I will focus less on the mathematical intricacies and put more emphasis on the assumptions and implementation of each component.

## Posts on Bayesian Optimisation

**[Bayesian Optimisation from Scratch in R](https://anhosu.com/post/bayesian-opt-r)**

This post introduces and demonstrates all the core components of Bayesian optimisation and implements them from scratch in R. This is a great place to start.


**[Kernel Functions](https://anhosu.com/post/kernels-r/)**

This post contains a comprehensive list and discussion of kernels to use in the Gaussian processes surrogate model, when doing Bayesian optimisation. Accompanying the discussion, are implementations in R. The kernel is the main way to incorporate prior information into a surrogate model, making it an important choice, when setting up Bayesian optimisation.


**[Acquisition Functions](https://anhosu.com/post/acquisition-functions-r/)**

This post discusses acquisition functions, which are used to recommend the next point to sample in the experiment sequence. Acquisition functions are the main means of balancing exploration and exploitation during optimisation. The post lists a number of acquisition functions and implements them in R.


**[Alternative Surrogate Models](https://anhosu.com/post/surrogate-alternatives-r/)**

Gaussian processes are almost the default choice for surrogate models in Bayesian optimisation and they do perform well for many diverse tasks. However, a Gaussian process might not always be the right choice. This post discusses and implements four alternatives to Gaussian processes as surrogate models for Bayesian optimisation. 


**[Initial Designs](https://anhosu.com/post/initial-designs-r/)**

The first step in Bayesian optimisation is the initial experiment design, which provides the base data for a surrogate model. This post discusses the significance of initial experiment designs for Bayesian optimisation, and explores a few examples, including Latin Hypercube Sampling (LHS), while highlighting their advantages and limitations.


**[Testing Bayesian Optimisation](https://anhosu.com/post/test-functions-r/)**

The objective function is usually expensive to evaluate, so before starting Bayesian optimisation on an actual problem, the code and models should be tested. This post discusses a set of functions that can help test and gauge the efficacy of potential surrogate models and optimisation policies.

## License

The content of this project itself is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International license](https://creativecommons.org/licenses/by-sa/4.0/), and the underlying code is licensed under the [GNU General Public License v3.0 license](https://github.com/AnHosu/bayes-opt/blob/2b81cc2c765cf5aa76e62a2da387c3b4ca1695a9/LICENSE).