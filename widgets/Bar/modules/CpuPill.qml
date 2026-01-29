import qs.common
import qs.common.components
import qs.common.colors

Pill {
    id: root
    SystemModules { id: sysModules }
    icon: "\ue322"
    pillText: sysModules.cpuUsage + "%"
}
