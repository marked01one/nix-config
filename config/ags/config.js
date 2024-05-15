import { applauncher } from "./components/applauncher.js";
import { Taskbar } from "./components/taskbar.js";

App.config({
    style: "./styles/taskbar.css",
    windows: [
        applauncher,
        Taskbar()
    ],
})

export {  }
