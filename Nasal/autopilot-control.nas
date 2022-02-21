setlistener('sim/model/config/panel', func (node) {
    var panel = node.getValue();
    setprop('autopilot/sperry/available', panel == 'traditional');
    setprop('autopilot/century/available', panel == 'standard');
}, 1, 0);
