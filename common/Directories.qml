pragma Singleton

import QtCore
import QtQuick
import Quickshell
import qs.common.functions

Singleton {
    readonly property string quickshellConfigName: "caylx"

    readonly property string home: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
    readonly property string config: StandardPaths.standardLocations(StandardPaths.ConfigLocation)[0]
    readonly property string state: StandardPaths.standardLocations(StandardPaths.StateLocation)[0]
    readonly property string cache: StandardPaths.standardLocations(StandardPaths.CacheLocation)[0]
    readonly property string genericCache: StandardPaths.standardLocations(StandardPaths.GenericCacheLocation)[0]
    readonly property string documents: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
    readonly property string downloads: StandardPaths.standardLocations(StandardPaths.DownloadLocation)[0]
    readonly property string pictures: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
    readonly property string music: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0]
    readonly property string videos: StandardPaths.standardLocations(StandardPaths.MoviesLocation)[0]
    readonly property list<string> appDirs: StandardPaths.standardLocations(StandardPaths.ApplicationsLocation)

    property string shellConfigFile: FileUtils.trimFileProtocol(`${Directories.config}/${Directories.quickshellConfigName}/config.json`)
    property string generatedMaterialThemePath: FileUtils.trimFileProtocol(`${Directories.home}/.local/state/caylx/colors.json`)
    property string wallpaperDirPath: FileUtils.trimFileProtocol(`${Directories.pictures}/Wallpapers`)
    property string scriptsPath: Quickshell.shellPath("scripts")
}
