; raise Z before moving if needed
if {move.axes[2].homed && (move.axes[2].userPosition < 5)}
  G91
  G1 Z5 F9000
  G90

; goto Z switch
G1 X207.5 Y311.0 F6000