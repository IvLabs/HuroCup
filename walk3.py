#!/usr/bin/env python
# license removed for brevity
## Date of attempt1: 12|07|2016 
## STATIC WALKING ##
## INPUT FROM EXCEL SHEET, ANGLES PRECALCULATED IN MATLAB ##
## frequency = 40Hz (=2X20Hz(20Hz is the assumed bandwidth for the motor, So the nyquist criteria is applied to get a minimal sampling frequency of 40Hz between two consecutive angles to a motor)) ##

import rospy
from std_msgs.msg import String
import serial
import herkulex
import time 
import xlrd

herkulex.connect('/dev/ttyUSB0',115200)
## MOTOR_ID ##
#biped
l_hip_roll    = herkulex.servo(4)
l_hip_pitch   = herkulex.servo(2)
l_knee_pitch  = herkulex.servo(10)
l_ankle_pitch = herkulex.servo(5)
l_ankle_roll  = herkulex.servo(7)
r_hip_roll    = herkulex.servo(12)
r_hip_pitch   = herkulex.servo(8)
r_knee_pitch  = herkulex.servo(1)
r_ankle_pitch = herkulex.servo(11)
r_ankle_roll  = herkulex.servo(6)
#torso
l_hand_pitch  = herkulex.servo(13)
l_hand_roll   = herkulex.servo(14)
l_hand_yaw    = herkulex.servo(15)
r_hand_pitch  = herkulex.servo(16)
r_hand_roll   = herkulex.servo(17)
r_hand_yaw    = herkulex.servo(18)
# ZERO_OFFSET ##
zero_offset = [-9, 0, 1, 4, 3, 9, 7, 1, 0, -5]
#l_hip_roll_id ,l_hip_pitch_id ,l_knee_pitch_id ,l_ankle_pitch_id, l_ankle_roll_id,
#r_hip_roll_id , r_hip_pitch_id, r_knee_pitch_id, r_ankle_pitch_id, r_ankle_roll_id  
## CORRECT ACCORDING TO ZERO-OFFSET ##
file_location = "/home/sakshi/catkin_ws/src/walk/angles1.xlsx"
workbook = xlrd.open_workbook(file_location)
x = workbook.sheet_by_index(0)
angles = [[0]*10 for k in range(260)]#declared a matrix of dimension 260*10
for i in range (0, 260):
 for j in range (0, 10):
  angles[i][j] = x.cell_value(i, j) + zero_offset[j]
## MOTOR_TORQUE_ON ##
#biped
l_hip_roll.torque_on()
l_hip_pitch.torque_on()
l_knee_pitch.torque_on()
l_ankle_pitch.torque_on()
l_ankle_roll.torque_on()
r_hip_roll.torque_on()
r_hip_pitch.torque_on() 
r_knee_pitch.torque_on()
r_ankle_pitch.torque_on()
r_ankle_roll.torque_on()

#torso
l_hand_pitch.torque_on()  
l_hand_roll.torque_on()   
l_hand_yaw.torque_on()   
r_hand_pitch.torque_on() 
r_hand_roll.torque_on()  
r_hand_yaw.torque_on()   

#setting torso motors to 0 position
herkulex.servo(13).set_servo_angle(0,2,4)
herkulex.servo(14).set_servo_angle(0,2,4)
herkulex.servo(15).set_servo_angle(0,2,4)
herkulex.servo(16).set_servo_angle(0,2,4)
herkulex.servo(17).set_servo_angle(0,2,4)
herkulex.servo(18).set_servo_angle(0,2,4)

def talker():
 while 1:
  if (r_ankle_pitch.get_servo_status()!=0):
    r_knee_pitch.torque_off()
  elif (r_ankle_roll.get_servo_status()!=0):
    r_knee_pitch.torque_off()
  elif (r_knee_pitch.get_servo_status()!=0):
    r_knee_pitch.torque_off()
  elif (r_hip_roll.get_servo_status()!=0):
    r_hip_roll.torque_off()
  elif (r_hip_pitch.get_servo_status()!=0):
    r_hip_pitch.torque_off()
  elif (l_hip_roll.get_servo_status()!=0):
    l_hip_roll.torque_off()
  elif (l_hip_pitch.get_servo_status()!=0):
    l_hip_pitch.torque_off()
  elif (l_knee_pitch.get_servo_status()!=0):
    l_knee_pitch.torque_off()
  elif (l_ankle_roll.get_servo_status()!=0):
    l_ankle_roll.torque_off()
  elif (l_ankle_pitch.get_servo_status()!=0):
    l_ankle_pitch.torque_off()
  motor_id = [4, 2, 10, 5, 7, 12, 8, 1, 11, 6] 

#l_hip_roll_id ,l_hip_pitch_id ,l_knee_pitch_id ,l_ankle_pitch_id, l_ankle_roll_id,
#r_hip_roll_id , r_hip_pitch_id, r_knee_pitch_id, r_ankle_pitch_id, r_ankle_roll_id  
###########################################
  for c in range (0, 5):#for five steps
   time.sleep(0.056)
   for x in range (0, 260):
     for y in range (0, 10):
      herkulex.servo(motor_id[y]).set_servo_angle(angles[x][y],2,4)
      print("angle received by")
      print (motor_id[y])
      time.sleep(0.0007)
      time.sleep(0.013)
   if c == 4:
     break
###########################################  
  herkulex.close()
if __name__ == '__main__':
    try:
       talker()
    except rospy.ROSInterruptException:
       pass
