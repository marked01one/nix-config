import { applauncher } from "./components/applauncher.js";
import { taskbar } from "./components/taskbar.js";

App.config({
    style: "./styles.css",
    windows: [
        // applauncher,
        taskbar()
    ],
})

export {  }
