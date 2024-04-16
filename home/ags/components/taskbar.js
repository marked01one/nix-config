const hyprland = await Service.import('hyprland')
const notifications = await Service.import('notifications')
const mpris = await Service.import('mpris')
const audio = await Service.import('audio')
const battery = await Service.import('battery')
const systemtray = await Service.import('systemtray')


const date = Variable("", {
    poll: [1000, 'date "+%H:%M:%S %%b %e."']
})

// Define workspace display functionalities
function Workspace() {
    const activeId = hyprland.active.workspace.bind("id")
    const workspaces = hyprland.bind("workspaces")
        .as(ws => ws.map(
            ({ id }) => Widget.Button({
                on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
                child: Widget.Label(`${id}`),
                class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
            })
        ))
    
    return Widget.Box({
        class_name: "workspaces",
        children: workspaces
    })
}


function ClientTitle() {
    return Widget.Label({
        class_name: "client-title",
        label: hyprland.active.client.bind("title")
    })
}


function Clock() {
    return Widget.Label({
        class_name: "clock",
        label: date.bind()
    })
}



export const taskbar = (monitor = 0) => Widget.Window({
    name: `bar-${monitor}`,
    class_name: "bar"
})