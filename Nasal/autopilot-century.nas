# LATERAL MODES:
#
# 0 = wings level
# 1 = HDG
# 2 = NAV
#
# VERTICAL MODES:
#
# 0 = ATT (pitch hold)
# 1 = ALT (altitude hold)

setlistener('autopilot/century/active', func (node) {
    if (node.getBoolValue()) {
        # A/P activated

        # wings level
        setprop('autopilot/century/lateral-mode', 0);

        # pitch hold
        setprop('autopilot/century/vertical-mode', 0);

        # disarm APR
        setprop('autopilot/century/gs-armed', 0);

        # wings level
        setprop('autopilot/settings/target-roll-deg', 0.0);

        # pitch hold; we round to 0.1° to allow the pilot to select exactly 0°
        setprop('autopilot/settings/target-pitch-deg',
            math.round(getprop('instrumentation/attitude-indicator/indicated-pitch-deg') * 10.0) / 10.0);
    }
}, 1, 0);

setlistener('autopilot/century/lateral-mode', func (node) {
    var mode = node.getValue() or 0;
    if (mode == 0) {
        # wings level
        setprop('autopilot/settings/target-roll-deg', 0.0);
    }
    setprop('autopilot/century/gs-armed', 0);
}, 1, 1);

setlistener('autopilot/century/vertical-mode', func (node) {
    var mode = node.getValue() or 0;
    if (mode == 0) {
        # pitch hold; we round to 0.1° to allow the pilot to select exactly 0°
        setprop('autopilot/settings/target-pitch-deg',
            math.round(getprop('instrumentation/attitude-indicator/indicated-pitch-deg') * 10.0) / 10.0);
    }
    elsif (mode == 1) {
        # alt hold
        setprop('autopilot/settings/target-altitude-ft',
            math.round(getprop('instrumentation/altimeter/indicated-altitude-ft'), 25));
    }
    setprop('autopilot/century/gs-armed', 0);
}, 1, 1);
