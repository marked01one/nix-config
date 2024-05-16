import { applauncher } from "./components/applauncher.js";
import { Taskbar } from "./components/taskbar.js";
const hyprland = await Service.import("hyprland")

let taskbar = hyprland.monitors.map(m => Taskbar(m.id))

App.config({
    style: "./styles/taskbar.css",
    windows: [
        applauncher,
        taskbar
    ].flat(),
})

export {  }
