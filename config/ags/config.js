import { applauncher } from "./components/applauncher.js";
import { Taskbar } from "./components/taskbar.js";

App.config({
    windows: [
        applauncher,
        Taskbar()
    ],
})

export {  }
