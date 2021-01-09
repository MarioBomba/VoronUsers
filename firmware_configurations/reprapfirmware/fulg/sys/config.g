; Configuration file for Duet2 (firmware version 3.1.1 or newer)
; executed by the firmware on start-up

; General preferences
M111 S0                 ; Debugging off
G21                     ; Work in millimetres
G90                     ; Send absolute coordinates...
M83                     ; ...but relative extruder moves

M669 K1                 ; Select CoreXY mode
;M575 P1 B57600 S1       ; Comms parameters for PanelDue
M564 S1 H1              ; Forbid axis movements when not homed
M918 P2 R6 C30 E4 F200000  ; Fysetc 12864 display

; Network
M550 PVoron V2.015      ; Set machine name
M552 S1                 ; Enable network
M586 P0 S1              ; Enable HTTP (for DWC)
M586 P1 S1              ; Enable FTP (for remote backups)
M586 P2 S0              ; Disable Telnet

; --- Z Drive map ---
;     _______
;    | 6 | 7 |
;    | ----- |
;    | 5 | 8 |
;     -------
;      front
;
; (looking at the printer from the top)

; Drive directions
M569 P0 S1 ; A      TODO I wired one of them backwards of course :(
M569 P1 S0 ; B
M569 P3 S0 ; Extruder
M569 P5 S1 ; Z1
M569 P6 S0 ; Z2
M569 P7 S1 ; Z3
M569 P8 S0 ; Z4

; Motor mapping and steps per mm
M584 X0 Y1 Z5:6:7:8 E3
M350 X16 Y16 Z16 E16 I1         ; Use 1/16 microstepping with interpolation everywhere
;M92 X80 Y80 Z400               ; Set XYZ steps per mm (1.8deg motors)
M92 X160 Y160 Z800              ; Set XYZ steps per mm (0.9deg motors)
M92 E406                        ; Set Extruder steps per mm

; Drive currents
M906 X1200 Y1200 Z1200 E600     ; XYZ and E current
M906 I30                        ; Idle current percentage
M84 S120                        ; Idle timeout

; Endstops
M574 X2 S1 P"^!xstop"           ; Xmax endstop on hall effect board
M574 Y2 S1 P"^!ystop"           ; Ymax endstop on hall effect board
M574 Z0 P"nil"                  ; No Z endstop

; Axis travel limits
M208 X-9 Y0 Z0 S1               ; Set axis minima
M208 X312 Y325 Z275 S0          ; Set axis maxima

; Bed leveling
M671 X-65:-65:365:365 Y0:395:395:0 S20      ; Define Z belts locations (Front_Left, Back_Left, Back_Right, Front_Right)
M557 X25:275 Y25:275 S25                    ; Define bed mesh grid (inductive probe, positions include the Y offset!)

; Accelerations and speed
M98 P"/macros/print_scripts/speed_printing.g"

; Bed heater (dual thermistor setup)
M308 S0 P"bedtemp" Y"thermistor" T100000 B3950 A"Bed Heater" ; configure sensor 0 as thermistor on pin bedtemp (heater sensor)
M308 S2 P"e1temp" Y"thermistor" T100000 B3950 A"Bed Plate"  ; configure sensor 2 as thermistor on pin e1temp (mic6 sensor)
M950 H0 C"bedheat" T2 Q10                                   ; create bed heater output on out0 and map it to sensor 2 (mic6 sensor). Set PWM frequency to 10Hz
M140 P0 H0                                                  ; Mark heater H0 as bed heater (for DWC)
M143 H0 P1 T0 A2 S115 C0                                    ; Regulate (A2) bed heater (H0) to have pad sensor (T0) below 115°C. Use Heater monitor 1 for it
M143 H0 P2 T0 A1 S125 C0                                    ; Shut off (A1) bed heater (H0) if pad sensor (T0) exceeds 125°C. Use Heater monitor 2 for it
M143 H0 S110                                                ; Set bed heater max temperature to 120°C, use implict monitor 0 which is implicitly configured for heater fault
M307 H0 B1 S0.6                                             ; Enable Bang Bang mode and set PWM to 60% to avoid warping

; Hotend heater
M308 S1 A"Hotend" P"spi.cs2" Y"rtd-max31865" F60 ; Hotend is 2-wire PT100 on second channel, 60Hz mains
M950 H1 C"e0heat" T1
M307 H1 B0 S1.00                                ; disable bang-bang mode for heater and set PWM limit
M143 H1 S300                                    ; Set temperature limit for heater 1 to 300C

; MCU sensors
M308 S3 Y"mcu-temp" A"MCU"
M308 S4 Y"drivers" A"Duet Drivers"
M308 S5 Y"drivers-duex" A"Duex Drivers"

; Chamber temperature sensor via temperature daughterboard pins on Duex
;M305 S"Ambient" P104 X405 T21                   ; Set DHT21 for chamber temp
;M305 S"Humidity [%]" P105 X455 T21              ; Set DHT21 for chamber humidity

; Z probes
M558 K0 P8 C"^zprobe.in" T18000 F120 H5 A5 S0.01 R0.2
G31 K0 P500 X0 Y25 Z2.0              ; Don't really care about inductive probe Z offset
M558 K1 P8 C"^zstop" T18000 F60 H2 A10 S0.005 R0.2
G31 K1 P500 X0 Y0 Z0.32             ; Z switch offset (if positive, greater value = lower nozzle. if negative, more negative = higher nozzle)

; Fans
M950 F0 C"fan0" Q250                ; Create fan 0 (hotend) on pin fan0 and set its frequency
M106 P0 S1 H1 T50                   ; Configure fan 0: Thermostatic control is turned on, based on sensor #1
M950 F1 C"fan1" Q250                ; Create fan 1 (cooling)on pin fan1 and set its frequency
M106 P1 S0 H-1                      ; Configure fan 1: Thermostatic control is turned off
M950 F2 C"duex.fan3"                ; Create fan 2 (chamber) on Duex pin fan3 (frequency is fixed on Duex)
M106 P2 S1 H2 T50                   ; Configure fan 2: Thermostatic control is turned on, based on sensor #2
M950 F4 C"fan2" Q30                 ; Create fan 4 (electronics bay) on pin fan2 and set its frequency
;M106 P4 S0.25 H1 T50               ; (busted?) Run the fans at 25% if the hotend is over 50C
M106 P4 S0 H-1 C"Bay Fans"          ; Manual fan triggering... with thermostatic mode they are always at 100%?

; LEDs
M950 H2 C"nil" ; free up e2_heat pin
M950 F3 C"duex.e2_heat"
M106 P3 S255 B0 H-1 C"Top Lights"

; Tools
M563 P0 D0 H1 F1                    ; Define tool 0 using fan 1 for M106
G10 P0 X0 Y0 Z0                     ; Set tool 0 axis offsets
G10 P0 R0 S0                        ; Set initial tool 0 active and standby temperatures to 0C

; Misc
M912 P0 S-4                         ; MCU temperature calibration (yours will be different)
;M572 D0 S0.075                      ; Pressure Advance
M572 D0 S0.01                       ; Pressure Advance
M592 D0 A0.015 B0.0012 L0.2         ; Non-linear extrusion
M376 H10                            ; Fade mesh out compensation over 10mm Z

; DAA tuning (you will need to change this for your slicer)
;M593 F26.6                          ; Cura 4.5 stock profile @ 40mm/s outer printing speed
M593 F42.5                          ; PrusaSlicer @ 40mm/s outer perimeter

M80                                 ; turn on PSU & mains voltage

M501                                ; load config-override.g
T0                                  ; select tool 0

; workaround for bug in 3.2beta3, M143 needs to be done after all M950, M307, M140 and M141. https://forum.duet3d.com/topic/19031/m143-issue/25?_=1605986986974
M143 H0 S110
M143 H1 S300
