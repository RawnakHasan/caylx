import qs.common
import qs.common.components
import qs.common.services
import qs.common.colors

Pill {
    id: root
    CpuandMemoryServices { id: sysModules }
    icon: "memory_alt"
    pillText: sysModules.memUsage + "%"
    iconHorizontalCenterOffset: 0
}