const blt = await Service.import('bluetooth')
const WINDOW_NAME = 'bluetooth'

const connectedList = Widget.Box({
    setup: self => self.hook(blt, self => {
        self.children = blt.connected_devices
            .map(({ icon_name, name }) => Widget.Box([
                Widget.Icon(icon_name + '-symbolic'),
                Widget.Label(name)
            ]))
        
        self.visible = blt.connected_devices.length > 0;
    }, 'notify::connected-devices'),
})

const indicator = Widget.Icon({
    icon: blt.bind('enabled').as(on =>
        `bluetooth-${on ? 'active' : 'disabled'}-symbolic`)
})


export const bluetooth = Widget.Window({
    name: WINDOW_NAME,
    setup: self => self.keybind("Escape", () => {
        App.closeWindow(WINDOW_NAME)
    }),
    visible: false,
    keymode: "exclusive",
    child: connectedList
})