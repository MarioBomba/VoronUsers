; raise Z before moving if needed
if {move.axes[2].homed && (move.axes[2].userPosition < 5)}
  G91
  G1 Z5 F9000
  G90

; goto Z switch
G1 X208.2 Y320.0 F6000