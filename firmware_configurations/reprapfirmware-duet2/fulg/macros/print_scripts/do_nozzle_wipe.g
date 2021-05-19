; assumes we are homed

M98 P"/macros/print_scripts/goto_bucket.g"

G1 Z4
G91 ; relative

G1 X-15 F20000
G1 X+30
G1 X-30
G1 X+30
G1 X-30
G1 X+30
G1 X-15

G90 ; absolute

G1 Z5
