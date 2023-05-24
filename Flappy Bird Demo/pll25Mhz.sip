set_global_assignment -entity "pll25Mhz" -library "lib_pll25Mhz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll25Mhz" -library "lib_pll25Mhz" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "pll25Mhz" -library "lib_pll25Mhz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll25Mhz" -name SPD_FILE [file join $::quartus(sip_path) "pll25Mhz.spd"]

set_global_assignment -library "lib_pll25Mhz" -name MISC_FILE [file join $::quartus(sip_path) "pll25Mhz_sim/pll25Mhz.vho"]
