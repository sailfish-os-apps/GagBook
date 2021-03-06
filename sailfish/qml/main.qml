/*
 * Copyright (c) 2014 Dickson Leong.
 * All rights reserved.
 *
 * This file is part of GagBook.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.gagbook.Core 1.0

ApplicationWindow {
    id: appWindow
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    property var coverPage

    initialPage: Component { MainPage { } }
    cover: Qt.resolvedUrl("CoverPage.qml")

    Constant { id: constant }

    InfoBanner { id: infoBanner }

    GagBookManager {
        id: gagbookManager
        settings: AppSettings { id: appSettings }
        onLoginSuccess: infoBanner.alert("Login to 9GAG successfully!");
        onLoginFailure: infoBanner.alert(errorMessage);
    }

    // Global busy indicator, it reads the 'busy' property from the current page
    // FIXME: this panel is covered by Image from GagDelegate, setting 'z' property can't solve this
    DockedPanel {
        id: busyPanel
        width: parent.width
        height: busyIndicator.height + 2 * constant.paddingLarge
        open: pageStack.currentPage.hasOwnProperty('busy') ? pageStack.currentPage.busy : false
        dock: Dock.Bottom
        enabled: false

        BusyIndicator {
            id: busyIndicator
            anchors.centerIn: parent
            running: busyPanel.open
        }
    }
}
