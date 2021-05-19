; raise Z before moving if needed
if {move.axes[2].homed && (move.axes[2].userPosition < 5)}
  G91
  G1 Z5 F9000
  G90

; go to bucket
G90
G1 X76 Y321 F18000