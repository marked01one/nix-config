import { applauncher } from "./components/applauncher.js";
import { Taskbar } from "./components/taskbar.js";

App.config({
    style: "./styles.css",
    windows: [
        applauncher,
        Taskbar()
    ],
})

export {  }
