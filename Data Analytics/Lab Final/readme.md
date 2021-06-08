## Laboratory excercise - Your own mini-project

1. Select your own dataset and phenomena you want to model.
2. Propose two types of model of that phenomena (for example two distributions, different predictor, 1 vs 2 predictors, different prior types etc.)
3. Determine parameters and formulate priors for them - priors need to be justified!
4. Perform prior predictive checks, adjust priors if necessary.
6. Create the models for fitting
7. Generated quantities of the model should include ```log_lik``` table, consisting of values of logarithms of elements of likelyhood for each of datapoints.
8. Fit the model and perform posterior predictive checks
9. Compare models using arviz ```compare``` method with leave-one-out cross validation as criterion
