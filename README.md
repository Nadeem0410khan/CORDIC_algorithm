# CORDIC algorithm implementation using FPGA
### History:
CORDIC stands for COordinate Rotation DIgital Computer. In 1959, Jack E. Volder came up with this algorithm which is used for solving the trigonometric relationships involved in plane coordinate rotation and conversion from rectangular to polar coordinates. Later on, Walther proposed the unified algorithm for various coordinate systems i.e., circular, linear and hyperbolic.
### Modes:
CORDIC has two modes of operation Vectoring and Rotation. This code uses Rotation mode to get the sine and cosine value of the angle. 

### Inputting the value :

Input the 4-bit data. As 2<sup>4</sup>= 16 combinations are possible so resolution of 360°/16= 22.5° is available (table) and accordingly the angle is chosen from the table mentioned below and the sine and cosine value of the same is obtained at the end of iterations.



| 4 bit data | Angle values |
|   0000<br /><br />|   0°/360° | 
|   0001<br /><br />  |    22.5°  |





4 bit data	Angle values
0000	0o/360
0001	22.5o
0010	45o
0011	67.5o
0100	90o
0101	112.5o
0110	135o
0111	157.5o
1000	180o
1001	202.5o
1010	225o
1011	247.5o
1100	270o
1101	292.5o
1110	315o
1111	337.5o360°

### Features:

The angle coverage by CORDIC algorithm is (0°-90°), and cannot cover (0°-360°), which limits the calculation range of the algorithm. The angles which lie on second, third, fourth quadrant can be converted to first quadrant by flipping the angles. Then using the iterative CORDIC operations to evaluate sin, cos magnitude values. Further with the use of 2’s compliment the perfect sign is provided to the magnitude value of angle of respective quadrants. This design produces high throughput and less latency for continuous bits of input.
 The worst-case error of sin, cos values obtained from above implementation is 2.32 x 10<sup>-5</sup> units.

### Formatting the output:

From the simulation results, the value obtained for cos_op is 70712 then it means cos(angle)=0.70712. 


