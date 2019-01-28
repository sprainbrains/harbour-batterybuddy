/**
 * Battery Buddy, a Sailfish application to prolong battery lifetime
 *
 * Copyright (C) 2019 Matti Viljanen
 *
 * Battery Buddy is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * Battery Buddy is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details. You should have received a copy of the GNU
 * General Public License along with CarBudget. If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Matti Viljanen
 */
import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

CoverBackground {
    id: coverPage

    BatteryGraph {
        id: batteryGraph
        x: coverPage.width * 0.3
        y: coverPage.width * 0.25
        width: 0.4 * coverPage.width

        onChargingChanged: onChargeChanged()
        onChargeChanged: {
            if(charge <= settings.lowerLimit && battery.state === "discharging") {
                coverText.text = qsTr("Connect\ncharger")
            }
            else if(battery.charge >= settings.upperLimit &&
                    ((battery.state === "charging" && battery.charging === true) || (battery.state === "idle" && battery.charging === false))) {
                coverText.text = qsTr("Disconnect\ncharger")
            }
            else if(battery.charging) {
                coverText.text = qsTr("Charging...")
            }
            else {
                coverText.text = qsTr("Battery\nBuddy")
            }
        }
    }
    Label {
        id: coverText
        anchors.top: batteryGraph.bottom
        anchors.bottom: coverPage.bottom
        anchors.horizontalCenter: coverPage.horizontalCenter
        width: coverPage.width * 0.9
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.Wrap
        maximumLineCount: 2
    }
}
