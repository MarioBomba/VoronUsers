M83  ; set extruder to relative mode
G21  ; set units to mm

; record the set temperatures and set the global variables, then disable heating
M98 P"/macros/print_scripts/get_temps.g"
G10 P0 R0 S0
M140 S0

; home and move to bed center for heatsoak
G28
M98 P"/macros/print_scripts/goto_bed_center.g"

; turn the bed heating back on and wait for target temperature
M190 S{global.bed_temp}

; (temp) start bay cooling fan at 25%
M106 P2 S.25

; pre-heat everything for 30 minutes
if exists(global.heatsoak_daemon)
  set global.heatsoak_timeout = state.upTime + 1800
  set global.heatsoak_daemon = 1
else
  global heatsoak_timeout = state.upTime + 1800
  global heatsoak_daemon = 1
M291 R"Heatsoak in progress..." P"Click OK to skip" S2 ; uses daemon.g to implement an automatic timeout
set global.heatsoak_timeout = 0
set global.heatsoak_daemon = 0

; test
echo "Z switch temperature after heatsoak:" ^ sensors.analog[6].lastReading ^ "C"

G92 E0.0  ; reset extruder position
M220 S100 ; reset speed multiplier

; turn the hotend heater back on
G10 P0 R0 S{global.hotend_temp}
M116

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
