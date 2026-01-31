import qs.common
import qs.common.components
import qs.common.services
import qs.common.colors

Pill {
    id: root
    CpuandMemoryServices { id: sysModules }
    icon: "memory"
    pillText: sysModules.cpuUsage + "%"
    iconHorizontalCenterOffset: 0
}
