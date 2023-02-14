"Constants file for the field geometry defined by Statsbomb data"

# Field dimensions:
# 120 x 80 yards, goals at [(0, 36)-(0,44)], [(120, 36)-(120, 44)]
# Penalty spots at (12, 40), (108, 40)
# The box D's are defined by a circle of radius 12 centered at the penalty spots
# The 18-yard box(es) is a rectangle with corner points: [(0, 18), (0, 62), (18, 62), (18, 18)],
#                                                      [(120, 18), (120, 62), (102, 62), (102, 18)]
# The 6-yard box(es) is a rectangle with corner points: [(0, 26), (0, 38), (6, 38), (6, 26)],
#                                                      [(120, 26), (120, 38), (114, 38), (114, 26)]

MIN_Y = 0
MAX_Y = 80
MIN_X = 0
MAX_X = 120

GOAL_SIZE = 8
GOAL_HEIGHT = 3 # Just for the plotting code to use visually
BOX_WIDTH_18YRD = 44
BOX_HEIGHT_18YRD = 18

BOX_WIDTH_6YRD = 20
BOX_HEIGHT_6YRD = 6

D_RADIUS = 12
DEFAULT_CIRCLE_PTS = 100  # How many points to use while drawing the D circles
CENTRE_CIRCLE_RADIUS = 10

MAX_X_HALF_PITCH = 60
