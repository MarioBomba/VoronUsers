; tpost0.g
; called after tool 0 has been selected

; Wait for set temperatures to be reached
M116 P0

; Apply the filament-specific config.g, i.e. /filaments/[filament name]/config.g
M703
