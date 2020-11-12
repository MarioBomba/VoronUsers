M83  ; set extruder to relative mode
G21  ; set units to mm

T0  ; select tool 0

G92 E0.0  ; reset extruder position
M220 S100 ; reset speed multiplier

; level the gantry while everything is hot
G32

; Wipe off any residue from the nozzle
M98 P"/macros/print_scripts/do_nozzle_wipe.g"

; Final Z height adjust
M98 P"/macros/print_scripts/do_z_switch_probe.g"

G1 Z5
M98 P"/macros/print_scripts/goto_bed_center.g"
