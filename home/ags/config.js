import { bluetooth } from "./components/bluetooth.js";
import { applauncher } from "./components/applauncher.js";
import { taskbar } from "components/taskbar.js";

App.config({
    windows: [
        applauncher,
        taskbar()
    ],
})
