const { app, BrowserWindow, Menu, shell } = require("electron");
const path = require("path");

function createWindow() {
  const win = new BrowserWindow({
    width: 1440,
    height: 900,
    minWidth: 380,
    minHeight: 600,
    backgroundColor: "#0B1219",
    title: "Futballmenedzser",
    icon: path.join(__dirname, "icon.png"),
    autoHideMenuBar: true,
    show: false,
    webPreferences: {
      contextIsolation: true,
      nodeIntegration: false,
      spellcheck: false,
    },
  });

  win.once("ready-to-show", () => win.show());
  win.loadFile(path.join(__dirname, "index.html"));

  /* külső linkek a rendszer böngészőjében nyíljanak */
  win.webContents.setWindowOpenHandler(({ url }) => {
    shell.openExternal(url);
    return { action: "deny" };
  });

  /* egyszerű magyar menü */
  const menu = Menu.buildFromTemplate([
    {
      label: "Játék",
      submenu: [
        { label: "Teljes képernyő", accelerator: "F11", click: () => win.setFullScreen(!win.isFullScreen()) },
        { label: "Újratöltés", accelerator: "CmdOrCtrl+R", role: "reload" },
        { type: "separator" },
        { label: "Kilépés", accelerator: "CmdOrCtrl+Q", role: "quit" },
      ],
    },
    {
      label: "Nézet",
      submenu: [
        { label: "Nagyítás", accelerator: "CmdOrCtrl+=", role: "zoomIn" },
        { label: "Kicsinyítés", accelerator: "CmdOrCtrl+-", role: "zoomOut" },
        { label: "Eredeti méret", accelerator: "CmdOrCtrl+0", role: "resetZoom" },
      ],
    },
  ]);
  Menu.setApplicationMenu(menu);
}

app.whenReady().then(() => {
  createWindow();
  app.on("activate", () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") app.quit();
});
