# VariableStep-AllanVariance
The Allan variance is a method of representing different noise terms imposed by the stochastic fluctuations as a
function of averaging time. Unfortunately, existing implementations indicate that with the length of the analyzed datasets
increasing, the computation time grows very fast. This paper presents an optimized variable step Allan variance method by
changing the step length of the cluster sequence. In order to verify its validity, a series of 2-hour static data collected from
Microelectromechanical Systems (MEMS) sensors are identified by the optimized algorithm and the classical one, and also
applied to Dynamic Allan Variance (DAVAR) to track time-varying stability of sensors. Experiment results demonstrate that
proposed algorithm could significantly speed up the estimation process of Allan variance while ensuring the accuracy of the
analysis results, and enable the Allan variance becomes more efficient in practical applications.
AllanVariance.m*********Original Code of Optimized AllanVariance*****
test.m *****************Fitting Code*********************************
data.xlsx***********2-h static x-axis data from MEMS gyo************* 
