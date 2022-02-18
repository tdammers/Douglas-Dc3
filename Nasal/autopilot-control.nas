setprop('autopilot/active', 0);

setlistener('autopilot/active', func (node) {
    var active = node.getValue();
    if (active) {
        setprop('autopilot/locks/altitude', 'pitch-hold');
        setprop('autopilot/locks/heading', 'dg-heading-hold');
    }
    else {
        setprop('autopilot/locks/altitude', '');
        setprop('autopilot/locks/heading', '');
    }
});
