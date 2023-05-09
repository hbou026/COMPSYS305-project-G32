set_global_assignment -entity "pll25M" -library "lib_pll25M" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll25M" -library "lib_pll25M" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "pll25M" -library "lib_pll25M" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll25M" -name SPD_FILE [file join $::quartus(sip_path) "pll25M.spd"]

set_global_assignment -library "lib_pll25M" -name MISC_FILE [file join $::quartus(sip_path) "pll25M_sim/pll25M.vho"]
