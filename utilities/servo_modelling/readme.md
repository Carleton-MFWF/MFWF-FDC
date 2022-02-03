# Servo Modelling


## Experiment

- Program arduino servo to some sort of periodic motion. Example: Square wave
- place a circular colored object at the end of servo arm. Example: coloured header pin.
- place camera so that servo is centred in view and that it is has no movement.
- Record video of servo's motion for a few cycles starting with servo in zero position.

## Processing
### Install Requirements
- Have python installed
- Set up virtual environment `python -m venv venv`
- Once environment is activated run `pip install -r requirements.txt`

### Find Range on target object
- take one of video frames to use as calibration image
- run `range.py -f HSV -i <imagename.jpg>`
- adjust values until only your target object is white

### Run servo arm tracking script
- run `track_servo.py -v <path to video file>`
- output should appear in a window drawing the located object and angle arm.
- will output to `output.csv`
