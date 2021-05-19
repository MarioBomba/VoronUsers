M83  ; set extruder to relative mode
G21  ; set units to mm

; start bay cooling fan
M106 P2 S.25

T0  ; select tool 0

G92 E0.0  ; reset extruder position
M220 S100 ; reset speed multiplier

; level the gantry while everything is hot
G32

; Wipe off any residue from the nozzle
M98 P"/macros/print_scripts/do_nozzle_wipe.g"

; Final Z height adjust
M98 P"/macros/print_scripts/goto_z_switch.g"
G1 Z2 F6000
G28 Z

; Load previously probed bed mesh (optional, use only if you know your bed is warped)
G29 S1

M98 P"/macros/print_scripts/goto_bed_center.g"
