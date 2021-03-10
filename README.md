About DECIDE:
---------------------------------
---------------------------------

DECIDE is a part of a hypothetical anti-ballistic missile system. 
It is a script which determines whether an interceptor should be 
launched based partly on the radar data points it receives as input.

How to use DECIDE.m:
---------------------------------

Simply type DECIDE in the matlab command window. In order for the
script to run, All the input variables must be defined in the workspace as specified below.

(since it is not possible to have void DECIDE() function in MATLAB changing the global variables as inputs and outputs,
  we decided to have a script of DECIDE.m that should be run on a workspace including Inputs) 


Inputs:
---------------------------------

NUMPOINTS   -   an integer which specifies the number of radar data points

POINTS      -   a NUMPOINTSx2 matrix in which each row corresponds to a 
                radar data point: the first column contains the x-coordinates 
                and the second contains the y-coordinates.

PARAMETERS  -   A struc type object which contains relevant parameters
                necessary to check various launch interceptor conditions (LICs).

LCM         -   A 15x15 matrix which specifies the truth connections between
                various pairs of LICs. An entry must be either 1 (AND), 2 (OR) ,or 
                3 (NOTUSED). The position (i, j) connects the (i - 1)th and
                (j - 1)th LIC.

PUV         -   A 15x1 vector which specifies which LICs matter for the launch
                decision to be taken. Each entry should be either 0 or 1. For 
                instance, PUV(i) = 0 means that the (i - 1)th LIC may be ignored.
      
Output:
--------------------------------

LAUNCH      -   Either 0 (no launch) or 1 (launch)


Testing:
---------------------------------
---------------------------------
In order to test the LICs and their respective cases, the test folder is required.
It contains 16 .m files, of which 15 represent the LICs and the last represents
the script containing the test cases. In order to automate the testing process, type

              runtests('DECIDE_test')

in the Matlab command window. The test cases listed will be run against a set of
predetermined inputs and will then be compared with their expected values defined
by the test oracle, the rationale of which is explained for each test case.

Contributors:
---------------------------------
---------------------------------
Hedieh Khosravi:
---------------------------------
- Wrote the functions for the odd-numbered LICs
- Wrote at least one test case for each of the above
- Wrote the remaining part of the DECIDE script

Emil Vladu:
---------------------------------
- Wrote the functions for the even-numbered LICs
- Wrote at least one test case for each of the above
- Wrote the README
