const { query } = await Service.import("applications")
const WINDOW_NAME = "applauncher"

const LAUNCHER_STYLES = {
    width: 500,
    height: 500,
    spacing: 12
};

const APP_NAMES = new Map([
    ["Microsoft Teams for Linux", "Microsoft Teams"]
])

const AppItem = app => Widget.Button({
    on_clicked: () => {
        App.closeWindow(WINDOW_NAME)
        app.launch()
    },
    attribute: { app },
    child: Widget.Box({
        children: [
            Widget.Icon({
                icon: app.icon_name || "",
                size: 42,
            }),
            Widget.Label({
                class_name: "title",
                label: APP_NAMES.get(app.name) ?? app.name,
                xalign: 0,
                vpack: "center",
                truncate: "end",
                css: `margin-left: 8px; font-weight: 700;`
            })
        ]
    }),
    css: `padding-top: 4px;padding-bottom: 4px`
})


function AppLauncher() {
    // list of application buttons
    let applications = query("").map(AppItem)
    // container holding the buttons
    const list = Widget.Box({
        vertical: true,
        children: applications,
        spacing: LAUNCHER_STYLES.spacing,
    })

    // repopulate the box, so the most frequent apps are on top of the list
    function repopulate() {
        applications = query("")
            .filter(app => !app.name.includes("KiCad "))
            .sort((a,b) => a.name.localeCompare(b.name))
            .map(AppItem)
        list.children = applications
    }

    const entry = Widget.Entry({
        hexpand: true,
        css: `margin-bottom: ${LAUNCHER_STYLES.spacing}px;`,

        // to launch the first item on Enter
        on_accept: () => {
            // make sure we only consider visible (searched for) applications
            const results = applications.filter((item) => item.visible);
            if (results[0]) {
                App.toggleWindow(WINDOW_NAME)
                results[0].attribute.app.launch()
            }
        },

        // filter out the list
        on_change: ({ text }) => applications.forEach(item => {
            item.visible = item.attribute.app.match(text ?? "")
        })
    })

    return Widget.Box({
        vertical: true,
        css: `margin: ${LAUNCHER_STYLES.spacing * 2}px;`,
        children: [
            entry,

            // wrap the list in a scrollable
            Widget.Scrollable({
                hscroll: "never",
                css: `min-width: ${LAUNCHER_STYLES.width}px;`
                    + `min-height: ${LAUNCHER_STYLES.height}px`,
                child: list,
            }),
        ],

        setup: self => self.hook(App, (_, windowName, visible) => {
            if (windowName !== WINDOW_NAME) return;

            // when the applauncher shows up
            if (visible) {
                repopulate()
                entry.text = ""
                entry.grab_focus()
            }
        })
    })
}

// there needs to be only one instance
export const applauncher = Widget.Window({
    name: WINDOW_NAME,
    setup: self => self.keybind("Escape", () => {
        App.closeWindow(WINDOW_NAME)
    }),
    visible: false,
    keymode: "exclusive",
    child: AppLauncher(),
    css: `
        border: 4px solid @theme_selected_bg_color;
        border-radius: 16px;
        opacity: 0.8;
    `
})