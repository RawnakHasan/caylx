import qs.common
import qs.common.components
import qs.common.colors

Pill {
    id: root
    SystemModules { id: sysModules }
    icon: "\uf7a3"
    pillText: sysModules.memUsage + "%"
}