# CORDIC algorithm implementation using FPGA
### History:
CORDIC stands for COordinate Rotation DIgital Computer. In 1959, Jack E. Volder came up with this algorithm which is used for solving the trigonometric relationships involved in plane coordinate rotation and conversion from rectangular to polar coordinates. Later on, Walther proposed the unified algorithm for various coordinate systems i.e., circular, linear and hyperbolic.
### Modes:
CORDIC has two modes of operation Vectoring and Rotation. This code uses Rotation mode to get the sine and cosine value of the angle. 

### Inputting the value :

Input the 4-bit data. As 2<sup>4</sup>= 16 combinations are possible so resolution of 360°/16= 22.5° is available (table) and accordingly the angle is chosen from the table mentioned below and the sine and cosine value of the same is obtained at the end of iterations.

### Table:

| 4 bit data    | Angle values  |
| ------------- | ------------- |
|     0000      |  0°/360°      |
|     0001      |   22.5°       |
|     0010      |   45°         |
|     0011      |   67.5°       |
|     0100      |   90°         |
|     0101      |   112.5°      |
|     0110      |   135°        |
|     0111      |   157.5°      |
|     1000      | 180°          |
|     1001      | 202.5°       |
|     1010      | 225°       |
|     1011      | 247.5°       |
|     1100      | 270°       |
|     1101      | 292.5°       |
|     1110      | 315°       |
|     1111      | 337.5°       |
### Features:

The angle coverage by CORDIC algorithm is [0°-90°], and cannot cover [0°-360°], which limits the calculation range of the algorithm. The angles which lie on second, third, fourth quadrant can be converted to first quadrant by flipping the angles. Then using the iterative CORDIC operations to evaluate sin, cos magnitude values. Further with the use of 2’s compliment the perfect sign is provided to the magnitude value of angle of respective quadrants. This design produces high throughput and less latency for continuous bits of input.
 The worst-case error of sin, cos values obtained from above implementation is 2.32 x 10<sup>-5</sup> units.

### Formatting the output:

From the simulation results, the value obtained for cos_op is **70712** then it means cos(angle)=**0.70712**. 


### Simulation results:
#### cos and sin value of 45° as 4-bit input is 0010
![cos and sin value of 45° as 4-bit input is 0010](https://imgur.com/Q8QgElk.png)

#### cos and sin value of 292.5° as 4-bit input is 1101
![cos and sin value of 292.5° as 4-bit input is 1101](https://imgur.com/gdIsSnF.png)

### References:
[CORDIC v6.0 LogiCORE IP Product Guide](https://www.xilinx.com/support/documentation/ip_documentation/cordic/v6_0/pg105-cordic.pdf)
