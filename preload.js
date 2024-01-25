window.require = require
const { shell } = window.require('electron')
window.trash = (path) => {
    return shell.trashItem(path)
}