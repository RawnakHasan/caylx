import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.common.colors
import qs.common

ScrollView {
    id: root
    anchors.fill: parent
    anchors.margins: 20

    // ((container width) - total gaps width - total margin width) / amount of items
    property int rowOneWidth: ((Screen.width * 3 / 4) - 10 * 3 - 20 * 2) / 4
    property int rowTwoWidth: ((Screen.width * 3 / 4) - 10 * 3 - 20 * 2) / 4
    property int rowThreeWidth: ((Screen.width * 3 / 4) - 10 * 3 - 20 * 2) / 4
    property int rowFourWidth: ((Screen.width * 3 / 4) - 10 - 20 * 2) / 4
    property int rowFiveWidth: ((Screen.width * 3 / 4) - 10 - 20 * 2) / 6
    property int rowSixWidth: ((Screen.width * 3 / 4) - 10 - 20 * 2) / 5

    ColumnLayout {
        spacing: 10

        GridLayout {
            columns: 4
            rowSpacing: 10
            columnSpacing: 10

            // Row 1: Primary, Secondary, Tertiary, Error
            TwoColorBox {
                primaryText: "Primary"
                secondaryText: "On Primary"
                mainColor: Dynamic.color.primary
                _onMainColor: Dynamic.color.on_primary
                Layout.preferredWidth: root.rowOneWidth
                Layout.preferredHeight: 100
            }

            TwoColorBox {
                primaryText: "Secondary"
                secondaryText: "On Secondary"
                mainColor: Dynamic.color.secondary
                _onMainColor: Dynamic.color.on_secondary
                Layout.preferredWidth: root.rowOneWidth
                Layout.preferredHeight: 100
            }

            TwoColorBox {
                primaryText: "Tertiary"
                secondaryText: "On Tertiary"
                mainColor: Dynamic.color.tertiary
                _onMainColor: Dynamic.color.on_tertiary
                Layout.preferredWidth: root.rowOneWidth
                Layout.preferredHeight: 100
            }

            TwoColorBox {
                primaryText: "Error"
                secondaryText: "On Error"
                mainColor: Dynamic.color.error
                _onMainColor: Dynamic.color.on_error
                Layout.preferredWidth: root.rowOneWidth
                Layout.preferredHeight: 100
            }

            // Row 2: Containers
            TwoColorBox {
                primaryText: "Primary Container"
                secondaryText: "On Primary Container"
                mainColor: Dynamic.color.primary_container
                _onMainColor: Dynamic.color.on_primary_container
                Layout.preferredWidth: root.rowTwoWidth
                Layout.preferredHeight: 100
            }

            TwoColorBox {
                primaryText: "Secondary Container"
                secondaryText: "On Secondary Container"
                mainColor: Dynamic.color.secondary_container
                _onMainColor: Dynamic.color.on_secondary_container
                Layout.preferredWidth: root.rowTwoWidth
                Layout.preferredHeight: 100
            }

            TwoColorBox {
                primaryText: "Tertiary Container"
                secondaryText: "On Tertiary Container"
                mainColor: Dynamic.color.tertiary_container
                _onMainColor: Dynamic.color.on_tertiary_container
                Layout.preferredWidth: root.rowTwoWidth
                Layout.preferredHeight: 100
            }

            TwoColorBox {
                primaryText: "Error Container"
                secondaryText: "On Error Container"
                mainColor: Dynamic.color.error_container
                _onMainColor: Dynamic.color.on_error_container
                Layout.preferredWidth: root.rowTwoWidth
                Layout.preferredHeight: 100
            }

            // Row 3: Fixed variants
            FourColorBox {
                topLeftText: "Primary Fixed"
                topRightText: "Primary Fixed Dim"
                middleText: "On Primary Fixed"
                bottomText: "On Primary Fixed Variant"
                fixedColor: Dynamic.color.primary_fixed
                fixedDimColor: Dynamic.color.primary_fixed_dim
                _onFixedColor: Dynamic.color.on_primary_fixed
                _onFixedVariantColor: Dynamic.color.on_primary_fixed_variant
                Layout.preferredWidth: root.rowThreeWidth
                Layout.preferredHeight: 150
            }

            FourColorBox {
                topLeftText: "Secondary Fixed"
                topRightText: "Secondary Fixed Dim"
                middleText: "On Secondary Fixed"
                bottomText: "On Secondary Fixed Variant"
                fixedColor: Dynamic.color.secondary_fixed
                fixedDimColor: Dynamic.color.secondary_fixed_dim
                _onFixedColor: Dynamic.color.on_secondary_fixed
                _onFixedVariantColor: Dynamic.color.on_secondary_fixed_variant
                Layout.preferredWidth: root.rowThreeWidth
                Layout.preferredHeight: 150
            }

            FourColorBox {
                topLeftText: "Tertiary Fixed"
                topRightText: "Tertiary Fixed Dim"
                middleText: "On Tertiary Fixed"
                bottomText: "On Tertiary Fixed Variant"
                fixedColor: Dynamic.color.tertiary_fixed
                fixedDimColor: Dynamic.color.tertiary_fixed_dim
                _onFixedColor: Dynamic.color.on_tertiary_fixed
                _onFixedVariantColor: Dynamic.color.on_tertiary_fixed_variant
                Layout.preferredWidth: root.rowThreeWidth
                Layout.preferredHeight: 150
            }

            // Empty space for alignment
            Item {
                Layout.preferredWidth: root.rowThreeWidth
                Layout.preferredHeight: 150
            }
        }

        // Row Four
        GridLayout {
            columns: 2
            columnSpacing: 10
            rowSpacing: 10

            RowLayout {
                spacing: 0

                SingleColorBox {
                    text: "Surface Dim"
                    backgroundColor: Dynamic.color.surface_dim
                    textColor: Dynamic.color.on_surface
                    topLeftRadius: 10
                    bottomLeftRadius: 10
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: root.rowFourWidth
                }

                SingleColorBox {
                    text: "Surface"
                    backgroundColor: Dynamic.color.surface
                    textColor: Dynamic.color.on_surface
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: root.rowFourWidth
                }

                SingleColorBox {
                    text: "Surface"
                    backgroundColor: Dynamic.color.surface_bright
                    textColor: Dynamic.color.on_surface
                    topRightRadius: 10
                    bottomRightRadius: 10
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: root.rowFourWidth
                }
            }
            
            ColumnLayout {
                spacing: 0

                SingleColorBox {
                    text: "Inverse Surface"
                    backgroundColor: Dynamic.color.inverse_surface
                    textColor: Dynamic.color.inverse_on_surface
                    topLeftRadius: 10
                    topRightRadius: 10
                    Layout.preferredHeight: 25
                    Layout.preferredWidth: root.rowFourWidth
                }

                SingleColorBox {
                    text: "Inverse Surface"
                    backgroundColor: Dynamic.color.inverse_on_surface
                    textColor: Dynamic.color.inverse_surface
                    bottomLeftRadius: 10
                    bottomRightRadius: 10
                    Layout.preferredHeight: 25
                    Layout.preferredWidth: root.rowFourWidth
                }
            }
        }

        // Row Five
        GridLayout {
            columns: 2
            columnSpacing: 10
            rowSpacing: 10

            RowLayout {
                spacing: 0

                SingleColorBox {
                    text: "Surface Container Lowest"
                    backgroundColor: Dynamic.color.surface_container_lowest
                    textColor: Dynamic.color.on_surface
                    fontSize: Appearance.swatchesPixelSize - 2
                    topLeftRadius: 10
                    topRightRadius: 0
                    bottomLeftRadius: 10
                    bottomRightRadius: 0
                    Layout.preferredHeight: 75
                    Layout.preferredWidth: root.rowFiveWidth
                }
                
                SingleColorBox {
                    text: "Surface Container Low"
                    backgroundColor: Dynamic.color.surface_container_low
                    textColor: Dynamic.color.on_surface
                    Layout.preferredHeight: 75
                    Layout.preferredWidth: root.rowFiveWidth
                }

                SingleColorBox {
                    text: "Surface Container"
                    backgroundColor: Dynamic.color.surface_container
                    textColor: Dynamic.color.on_surface
                    Layout.preferredHeight: 75
                    Layout.preferredWidth: root.rowFiveWidth
                }

                SingleColorBox {
                    text: "Surface Container High"
                    backgroundColor: Dynamic.color.surface_container_high
                    textColor: Dynamic.color.on_surface
                    Layout.preferredHeight: 75
                    Layout.preferredWidth: root.rowFiveWidth
                }

                SingleColorBox {
                    text: "Surface Container Highest"
                    backgroundColor: Dynamic.color.surface_container_highest
                    textColor: Dynamic.color.on_surface
                    fontSize: Appearance.swatchesPixelSize - 2
                    topRightRadius: 10
                    bottomRightRadius: 10
                    Layout.preferredHeight: 75
                    Layout.preferredWidth: root.rowFiveWidth
                }
            }

            SingleColorBox {
                text: "Inverse Primary"
                backgroundColor: Dynamic.color.inverse_primary
                textColor: Dynamic.color.on_surface
                topLeftRadius: 10
                topRightRadius: 10
                bottomLeftRadius: 10
                bottomRightRadius: 10
                Layout.preferredHeight: 75
                Layout.preferredWidth: root.rowFiveWidth
            }
        }

        // Row Six
        GridLayout {
            columns: 3
            columnSpacing: 10

            RowLayout {
                spacing: 0

                SingleColorBox {
                    text: "On Surface"
                    backgroundColor: Dynamic.color.on_surface
                    textColor: Dynamic.color.surface
                    topLeftRadius: 10
                    bottomLeftRadius: 10
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: root.rowSixWidth
                }

                SingleColorBox {
                    text: "On Surface Variant"
                    backgroundColor: Dynamic.color.on_surface_variant
                    textColor: Dynamic.color.surface
                    fontSize: Appearance.swatchesPixelSize - 2
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: root.rowSixWidth
                }

                SingleColorBox {
                    text: "Outline"
                    backgroundColor: Dynamic.color.outline
                    textColor: Dynamic.color.on_surface
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: root.rowSixWidth
                }

                SingleColorBox {
                    text: "On Surface"
                    backgroundColor: Dynamic.color.outline_variant
                    textColor: Dynamic.color.on_surface
                    topRightRadius: 10
                    bottomRightRadius: 10
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: root.rowSixWidth
                }
            }
            
            RowLayout {
                spacing: 10

                SingleColorBox {
                    text: "Scrim"
                    backgroundColor: Dynamic.color.scrim
                    textColor: Dynamic.color.on_surface
                    topLeftRadius: 10
                    topRightRadius: 10
                    bottomLeftRadius: 10
                    bottomRightRadius: 10
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: root.rowSixWidth / 2 - parent.spacing / 2
                }

                SingleColorBox {
                    text: "Shadow"
                    backgroundColor: Dynamic.color.shadow
                    textColor: Dynamic.color.on_surface
                    topLeftRadius: 10
                    topRightRadius: 10
                    bottomLeftRadius: 10
                    bottomRightRadius: 10
                    Layout.preferredHeight: 50
                    Layout.preferredWidth: root.rowSixWidth / 2 - parent.spacing / 2
                }
            }
        }
    }
}