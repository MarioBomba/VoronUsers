if move.axes[1].userPosition > 275
  M291 P"Inductive probe outside of bed area, are you sure?" R"Warning" S3

; workaround for RRF bug where the probe offset is cumulatively applied (1/2)
G31 K0 Y0

G1 Z5 F3000
G30 K0 P0 Z-9999
G30 K0 P1 Z-9999
G30 K0 P2 Z-9999
G30 K0 P3 Z-9999
G30 K0 P4 Z-9999
G30 K0 P5 Z-9999
G30 K0 P6 Z-9999
G30 K0 P7 Z-9999
G30 K0 P8 Z-9999
G30 K0 P9 Z-9999 S-1
G1 Z5

; workaround for RRF bug where the probe offset is cumulatively applied (2/2)
G31 K0 Y25
