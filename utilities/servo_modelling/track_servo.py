# based off Adrian Rosebrock's Ball Tracking Code
# https://www.pyimagesearch.com/2015/09/14/ball-tracking-with-opencv/


from math import atan2
from imutils.video import VideoStream
import argparse
import cv2
import imutils
import time
import pandas as pd

# axis of servo location
# set values for each test
servo_center = (595, 970)

# initialize dataframe for output
df = pd.DataFrame()

# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-v", "--video",
    help="path to the (optional) video file")
ap.add_argument("-b", "--buffer", type=int, default=64,
    help="max buffer size")
args = vars(ap.parse_args())

# define the lower and upper boundaries of the "red"
# ball in the HSV color space, then initialize the
redLower = (127, 50, 50)
redUpper = (255, 255, 255)

# if a video path was not supplied, grab the reference
# to the webcam
if not args.get("video", False):
    vs = VideoStream(src=0).start()
# otherwise, grab a reference to the video file
else:
    vs = cv2.VideoCapture(args["video"])
    fps = vs.get(cv2.CAP_PROP_FPS)
    timestamps = [vs.get(cv2.CAP_PROP_POS_MSEC)]
    calc_timestamps = [0.0]
# allow the camera or video file to warm up
time.sleep(2.0)

# keep looping
while True:
    # grab the current frame
    frame = vs.read()
    # handle the frame from VideoCapture or VideoStream
    frame = frame[1] if args.get("video", False) else frame
    # if we are viewing a video and we did not grab a frame,
    # then we have reached the end of the video
    if frame is None:
        break
    # resize the frame, blur it, and convert it to the HSV
    # color space
    # frame = imutils.resize(frame, width=600)
    blurred = cv2.GaussianBlur(frame, (71, 71), 0)
    hsv = cv2.cvtColor(blurred, cv2.COLOR_BGR2HSV)
    
    # res = cv2.bitwise_and(frame, frame, mask=mask)
    # construct a mask for the color "green", then perform
    # a series of dilations and erosions to remove any small
    # blobs left in the mask
    mask = cv2.inRange(hsv, redLower, redUpper)
    mask = cv2.erode(mask, None, iterations=2)
    mask = cv2.dilate(mask, None, iterations=2)
    
 
 # find contours in the mask and initialize the current
    # (x, y) center of the ball
    cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,
        cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    center = None
    # only proceed if at least one contour was found
    if len(cnts) > 0:
        # find the largest contour in the mask, then use
        # it to compute the minimum enclosing circle and
        # centroid
        c = max(cnts, key=cv2.contourArea)
        ((x, y), radius) = cv2.minEnclosingCircle(c)
        M = cv2.moments(c)
        center = (int(M["m10"] / M["m00"]), int(M["m01"] / M["m00"]))
        # only proceed if the radius meets a minimum size
        if radius > 5:
            # draw the circle and centroid on the frame,
            # then update the list of tracked points
            cv2.circle(frame, (int(x), int(y)), int(radius),
                (0, 255, 255), 2)
            cv2.circle(frame, center, 5, (0, 0, 255), -1)
            
            # draw line between points
            cv2.line(frame, servo_center, center, (0, 0, 255), 5)
            
            # calculate timestamp
            timestamps.append(vs.get(cv2.CAP_PROP_POS_MSEC))
            calc_timestamps.append(calc_timestamps[-1] + 1000/fps)
            
            # calculate servo angle theta
            dx = center[0] - servo_center[0]
            dy = center[1] - servo_center[1]
            theta = atan2(dy, dx)
            
            # add row of data to frame
            df = pd.concat([df, pd.DataFrame({"timestamp": calc_timestamps[-1], "x": [x], "y": [y], "theta": theta})])
            
    # draw servo center
    frame = cv2.circle(frame, servo_center, 20, (0,0,255))
    # show the frame to our screen
    cv2.imshow("Frame", frame)
    key = cv2.waitKey(1) & 0xFF
    # if the 'q' key is pressed, stop the loop
    if key == ord("q"):
        break
# if we are not using a video file, stop the camera video stream
if not args.get("video", False):
    vs.stop()
# otherwise, release the camera
else:
    vs.release()
# close all windows
cv2.destroyAllWindows()

# output csv
df.to_csv("output.csv")