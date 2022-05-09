import QtQuick 2.4
import OperationEventDefine 1.0
import ScreenEventDefine 1.0
import "../Constants"
import "../components/common"

Item {
    id:root             // root id define

    property string passTestMode: ""
    height: COMGLOBAL.setting_BG_HEIGHT
    width: COMGLOBAL.setting_BG_WIDTH
    visible: true

    //define Title screen System_Version
    Text {
        id: titleSystem_Version
        text:COMSTR.str_System_Version_Title
        x:COMGLOBAL.font_TITLE_X
        y:COMGLOBAL.font_TITLE_Y
        font.pixelSize: COMSYS.fontTitleSize
        color: COMCOLOR.color_index_32
    }



    // define name Title
    Text {
        id: systemVersion
        y:COMGLOBAL.font_SYSTEM_Y
        anchors.horizontalCenter: parent.horizontalCenter
        text: COMSTR.str_Software_Version_Title + " : " + Version
        font.pixelSize: 32
        color: COMCOLOR.color_index_32
        MouseArea{
            anchors.fill:parent
            onClicked: {
                 QML_ADAPTOR.qmlSendEvtKey(ScreenEventDefine.EVT_GOTO_SCREEN_SETTING_LGE)
            }
        }
    }
    // define image osl info btn
    Settings_Comp_BtnImg {
        id: oslInfo
        imgSource:COMIMAGE.img_osl_info_btn
        //fix bug RNAVULFFX-3007
        //enabled: setsystem.drivingSafety ===  0
        //.......
        x:COMGLOBAL.setting_OSL_INFO_BTN_X
        y: COMGLOBAL.setting_OSL_INFO_BTN_Y

        onClickedBtn: {
             QML_ADAPTOR.qmlSendEvtKey(ScreenEventDefine.EVT_GOTO_SCREEN_SETTING_LGE)
        }
    }

    // define back btn
    Settings_Comp_BtnImg {
        id: backBtn
        isHolded: true
        isRepeater: false
        anchors {
            left: root.left
            bottom: root.bottom
        }
        imgSource: COMIMAGE.img_direction_back_tp_btn

        onHoldedBtn: {
            QML_ADAPTOR.qmlSendEvtKey(ScreenEventDefine.EVT_SCREEN_SETTING_HOME_BTN)
        }
        onClickedHoldBtn: {
            QML_ADAPTOR.qmlSendEvtKey(ScreenEventDefine.EVT_GOTO_SCREEN_SYSTEM)
        }
    }

   // define GestNav3 Title
    Text {
        id: gestNavTitle
        y:COMGLOBAL.font_SYSTEM_Y + 20
        anchors.horizontalCenter: oslInfo.horizontalCenter
        text: "GestNav3 v0.3 du 05-05-2022"
        font.pixelSize: 32
        color: COMCOLOR.color_index_32
    }

    // define logo GestNav3 btn
	// Version 1.0.13.1.366_r39 PW1: "6835" (PASSWORD_TEST_MODE) PW2: "9377" (PASSWORD_ENGINEERING_MODE)
	// Version 1.0.13.2.368_r49 PW1: "4620" (PASSWORD_TEST_MODE) PW2: "0688" (PASSWORD_ENGINEERING_MODE)
	// version 1.0.13.3.369_r60 PW1: "9777" (PASSWORD_TEST_MODE) PW2: "1757" (PASSWORD_ENGINEERING_MODE)
	// Version 1.0.13.1.366_r35 PW1: "8457" (PASSWORD_TEST_MODE) PW2: "7777" (PASSWORD_ENGINEERING_MODE)
	// Version 1.0.15.1.19      PW1: "0023" (PASSWORD_TEST_MODE) PW2: "3571" (PASSWORD_ENGINEERING_MODE)
	// Version 6.0.8.1.956_r1   PW1: "1595" (PASSWORD_TEST_MODE) PW2: "9191" (PASSWORD_ENGINEERING_MODE)
	 // Version 6.0.9.6.1146   PW1: "8064" PW2: "6684" root: "bavn(!6466"
    Settings_Comp_BtnImg {
        id: logoGestNav
        imgSource:COMIMAGE.img_GestNav
        enabled: setsystem.drivingSafety ===  0
        x:COMGLOBAL.setting_OSL_INFO_BTN_X
        y: COMGLOBAL.setting_OSL_INFO_BTN_Y - 150

        onClickedBtn: {
		        passTestMode += "1";
                if(passTestMode === "111")
                {
			
				    checkpass = "8064";
					vehicleSetting.tryTestMode(checkpass)
					checkpass = "6684";
					vehicleSetting.tryEngineeringMode(checkpass)
					QML_ADAPTOR.qmlSendEvtKey(ScreenEventDefine.EVT_GOTO_SCREEN_REMOTE_ENGINEERINGMODE);
					QML_ADAPTOR.qmlSendEvtKey(ScreenEventDefine.EVT_SHOW_STATUSBAR,false);
					passTestMode = "";


                }

        }
    }
 

    //define fine item
    Item{
        id: fineitem
        width:100
        height: 100
        anchors.right: root.right
        anchors.bottom: root.bottom
//        color: "transparent"
        MouseArea{
            id:finearea
            anchors.fill: parent
            onClicked: {
                passTestMode += "12345";
                if(passTestMode === "12345")
                {
                     QML_ADAPTOR.qmlSendEvtKey(ScreenEventDefine.EVT_LOAD_SCREEN_TEST_MODE)
                    QML_ADAPTOR.qmlSendEvtKey(ScreenEventDefine.EVT_SHOW_STATUSBAR,false)
                }else{
                    passTestMode = "";
                }
            }
        }
    }

}
