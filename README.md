# EBSD-DataList-to-produce-Polar-Figure
This program is used to analyze EBSD data list and draw its corresponding Polar Figure.
The input file must be a list of points data in EBSD (experimental or simulation results)
Its format must be:  all points are listed in lines in files as the form of table, including the orientation information. 
for example, the format of belowing data is [point No.] [x location] [y location] [angle1] [angle2] [angle3]
1    1    1     1.215    0.713   0.158    
2    1    2     0.575    0.756   0.572
3    1    3     0.842    1.102   0.713
4    1    4     0.733    0.541   1.712
The input data cannot include any chars.

The orientations can be expressed as Euler Angles or Quaternions.

eul_ang.m : use Euler Angles to express orientations.
quaternoin.m : use Quaternions to express orientations.



