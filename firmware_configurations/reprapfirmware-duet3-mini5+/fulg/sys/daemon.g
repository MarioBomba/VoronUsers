; used to allow bypassing the heatsoak dialog during print_start.g
; (documentation states this is called every second but RRF3.3b3+ calls this once every 10 seconds instead)

if exists(global.heatsoak_daemon) && (global.heatsoak_daemon == 1)
  if (global.heatsoak_timeout < state.upTime)
    M292
