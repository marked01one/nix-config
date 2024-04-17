import { bluetooth } from "./components/bluetooth.js";
import { applauncher } from "./components/applauncher.js";

App.config({
    windows: [
        applauncher,
        bluetooth
    ],
})
