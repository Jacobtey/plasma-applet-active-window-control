import QtQuick 2.2
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.1

Item {
    id: appearancePage
    width: childrenRect.width
    height: childrenRect.height

    property alias cfg_doubleClickMaximizes: doubleClickMaximizes.checked
    property int cfg_leftClickAction
    
    
    property alias cfg_middleClickFullscreen: middleClickFullscreen.checked
    property alias cfg_wheelUpMaximizes: wheelUpMaximizes.checked
    property int cfg_wheelDownAction
    
    onCfg_leftClickActionChanged: {
        switch (cfg_leftClickAction) {
        case 1:
            leftClickActionGroup.current = leftClickExposeRadio;
            break;
        case 2:
            leftClickActionGroup.current = leftClickExposeAllRadio;
            break;
        case 3:
            leftClickActionGroup.current = leftClickExposeClassRadio;
            break;
        case 0:
        default:
            leftClickActionGroup.current = leftClickDisabledRadio;
        }
    }

    onCfg_wheelDownActionChanged: {
        switch (cfg_wheelDownAction) {
        case 1:
            wheelDownActionGroup.current = wheelDownMinimizesRadio;
            break;
        case 2:
            wheelDownActionGroup.current = wheelDownUnmaximizesRadio;
            break;
        case 0:
        default:
            wheelDownActionGroup.current = wheelDownDisabledRadio;
        }
    }
    
    Component.onCompleted: {
        cfg_leftClickActionChanged()
        cfg_wheelDownActionChanged()
    }
    
    ExclusiveGroup {
        id: leftClickActionGroup
    }

    ExclusiveGroup {
        id: wheelDownActionGroup
    }
    
    GridLayout {
        id: displayPosition
        columns: 2
        
        Label {
            text: i18n("Mouse Buttons:")
            Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
        }
        CheckBox {
            id: doubleClickMaximizes
            text: i18n("Doubleclick to toggle maximizing")
            onCheckedChanged: if (checked) leftClickDisabledRadio.checked = true
        }
        Item {
            width: 2
            height: 2
            Layout.rowSpan: 4
        }
        RadioButton {
            id: leftClickDisabledRadio
            exclusiveGroup: leftClickActionGroup
            text: i18n("Left click disabled")
            onCheckedChanged: if (checked) cfg_leftClickAction = 0;
            enabled: !doubleClickMaximizes.checked
        }
        RadioButton {
            id: leftClickExposeRadio
            exclusiveGroup: leftClickActionGroup
            text: i18n("Left click to present windows (Current Desktop)")
            onCheckedChanged: if (checked) cfg_leftClickAction = 1;
            enabled: !doubleClickMaximizes.checked
        }
        RadioButton {
            id: leftClickExposeAllRadio
            exclusiveGroup: leftClickActionGroup
            text: i18n("Left click to present windows (All Desktops)")
            onCheckedChanged: if (checked) cfg_leftClickAction = 2;
            enabled: !doubleClickMaximizes.checked
        }
        RadioButton {
            id: leftClickExposeClassRadio
            exclusiveGroup: leftClickActionGroup
            text: i18n("Left click to present windows (Window Class)")
            onCheckedChanged: if (checked) cfg_leftClickAction = 3;
            enabled: !doubleClickMaximizes.checked
        }
        
        Item {
            width: 2
            height: 2
        }
        CheckBox {
            id: middleClickFullscreen
            text: i18n("Middleclick to toggle fullscreen")
        }
        
        Item {
            width: 2
            height: 10
            Layout.columnSpan: 2
        }
        
        Label {
            text: i18n("Mouse Wheel:")
            Layout.alignment: Qt.AlignVCenter|Qt.AlignRight
        }
        CheckBox {
            id: wheelUpMaximizes
            text: i18n("Mouse wheel up to maximize")
        }
        Item {
            width: 2
            height: 2
            Layout.rowSpan: 3
        }
        RadioButton {
            id: wheelDownDisabledRadio
            exclusiveGroup: wheelDownActionGroup
            text: i18n("Mouse wheel down disabled")
            onCheckedChanged: if (checked) cfg_wheelDownAction = 0;
        }
        RadioButton {
            id: wheelDownMinimizesRadio
            exclusiveGroup: wheelDownActionGroup
            text: i18n("Mouse wheel down to minimize")
            onCheckedChanged: if (checked) cfg_wheelDownAction = 1;
        }
        RadioButton {
            id: wheelDownUnmaximizesRadio
            exclusiveGroup: wheelDownActionGroup
            text: i18n("Mouse wheel down to unmaximize")
            onCheckedChanged: if (checked) cfg_wheelDownAction = 2;
        }
    }
    
}