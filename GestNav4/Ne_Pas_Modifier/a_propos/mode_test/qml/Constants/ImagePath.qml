/*#############################################################################
 
############################################################################*/
import QtQuick 2.4
pragma Singleton
Item {
    readonly property int valueTheme: setdisplay.valueBackGround
    readonly property int mex_color: setdisplay.mexColor
    readonly property var folderName: ["MI","M0","EM2","LADA"]
    readonly property string themeImage:  folderName[valueTheme]
    readonly property url image_root:               PROJECT_DIR + "com.lge.bavn.settings/img/"
    readonly property url theme:                    image_root + themeImage
    readonly property url themeFlag:               image_root + "Flag"
    readonly property url imageBTSettings:         theme + "/"
    function suffixes_by_mex_color(position){
        var suffixes;
        if(valueTheme === 0){
            if(position === 1 || position === 3){ // image 1 and 3 is same with all mex_color value
                suffixes = "_pb"
            }
            else{
                switch(mex_color){
                   case 20:
                       suffixes = "_pb"
                       break;
                   case 21:
                       suffixes = "_c"
                       break;
                   case 22:
                       suffixes = "_b"
                       break;
                   case 23:
                       suffixes = "_g"
                       break;
                   case 24:
                       suffixes = "_y"
                       break;
                   case 25:
                       suffixes = "_o"
                       break;
                   case 26:
                       suffixes = "_r"
                       break;
                   case 27:
                       suffixes = "_v"
                       break;
                   default:
                       suffixes = "_pb"
                       break;
                }
            }
        }
        else{
            suffixes = ""
        }
        return suffixes
    }
    readonly property url imageFlag:               themeFlag + "/"
    readonly property url imageKeyboard:            imageBTSettings + "keyboard/"
    readonly property url imagePopup:            imageBTSettings + "popup/"
	
    readonly property var img_GestNav: [
        imageBTSettings + "GestNav_0.png",
        imageBTSettings + "GestNav_1.png",
        imageBTSettings + "GestNav_2.png",
        imageBTSettings + "GestNav_3.png",
    ]
    readonly property var swrc_ptt:  [
        imageBTSettings + "setting_spvr_help2_2_img.png",       // default
        imageBTSettings + "setting_spvr_help2_1_img.png",       //(SWRC Type 1 & 4)
        imageBTSettings + "setting_spvr_help2_2_img.png",       //(SWRC Type 2)
        imageBTSettings + "setting_spvr_help3_swrc3_img.png",   //(SWRC Type 3)
        imageBTSettings + "setting_spvr_help3_1_img.png"]         //PTT fitted

    readonly property var spvr_page1:  [
        imageBTSettings + "setting_spvr_help1_dacia_img.png",   // Dacia
        imageBTSettings + "setting_spvr_help1_1_img.png", // Renault
        imageBTSettings + "setting_spvr_help1_nobrand_img.png"] // Other

    readonly property var spvrHelpImage: [
         spvr_page1[1]//imageBTSettings + "setting_spvr_help1_1_img.png"
        ,""
        ,swrc_ptt[QML_ADAPTOR.get_SWRC_PTT_Config()]
        ,imageBTSettings + "setting_spvr_help4_img.png"
        ,imageBTSettings + "setting_spvr_help5_img.png"
        ,imageBTSettings + "setting_spvr_help5_img.png"
        ,imageBTSettings + "setting_spvr_siri_help_icon.png"]

    property var img_2_left_btn: [
        imageBTSettings + "setting_setting_btn_0.png",
        imageBTSettings + "setting_setting_btn_1.png",
        imageBTSettings + "setting_setting_btn_2.png"
    ]
    property string img_divider_1: imageBTSettings + "common_softkey_divider.png"
    property var img_divider: [
        imageBTSettings + "common_softkey_divider_0.png",
        imageBTSettings + "common_softkey_divider_1.png",
    ]
    property var img_minus_btn: valueTheme === 2 ? img_minus_btn_for_EM2 : img_minus_btn_for_MO_MI
    property var img_minus_btn_for_MO_MI: [
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]
    property var img_minus_btn_for_EM2: [
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(0) + "_03_0.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(0) + "_03_1.png",
        imageBTSettings + "common_spinner_minus_btn" + suffixes_by_mex_color(0) + "_03_2.png"
    ]
    property var img_plus_btn: valueTheme === 2 ? img_plus_btn_for_EM2 : img_plus_btn_for_M0_MI
    property var img_plus_btn_for_M0_MI: [
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]
    property var img_plus_btn_for_EM2: [
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(0) + "_03_0.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(0) + "_03_1.png",
        imageBTSettings + "common_spinner_plus_btn" + suffixes_by_mex_color(0) + "_03_2.png"
    ]
    property url img_spinner_number: imageBTSettings + "common_spinner_number_img.png"
    property var img_switch_3_btn_bg: valueTheme === 2 ? img_switch_3_btn_bg_for_EM2 : img_switch_3_btn_bg_for_M0_MI
    property var img_switch_3_btn_bg_for_M0_MI: [imageBTSettings + "common_sc_3menu_bg.png"]
    property var img_switch_3_btn_bg_for_EM2: [
        imageBTSettings + "common_sc_3menu_bg_01.png",
        imageBTSettings + "common_sc_3menu_bg_02.png",
        imageBTSettings + "common_sc_3menu_bg_03.png",
        imageBTSettings + "common_sc_3menu_bg_04.png",
    ]
    property var img_switch_2_btn_bg: valueTheme === 2 ? img_switch_2_btn_bg_for_EM2 : img_switch_2_btn_bg_for_M0_MI
    property var img_switch_2_btn_bg_for_M0_MI: [imageBTSettings + "common_sc_2menu_bg.png"]
    property var img_switch_2_btn_bg_for_EM2: [
        imageBTSettings + "common_sc_2menu_bg_01.png",
        imageBTSettings + "common_sc_2menu_bg_02.png",
        imageBTSettings + "common_sc_2menu_bg_03.png",
        imageBTSettings + "common_sc_2menu_bg_04.png",
    ]
    property url img_switch_btn: imageBTSettings + "common_sc_btn.png"
    //for timesetting
    property var common_timesetting_sc_bg:  [imageBTSettings + "common_timesetting_sc_bg.png"]
    property url common_timesetting_sc_btn: imageBTSettings + "common_timesetting_sc_btn.png"

    //image on off component
    property var img_onoff_btn: [
        imageBTSettings + "common_toggle_off_btn.png",
        imageBTSettings + "common_toggle_on_btn.png",
    ]
    property string img_onoff_bg: imageBTSettings + "common_toggle_bg.png"

    property var img_selectarrow_btn: [
        imageBTSettings + "setting_selectarrow_icon_0.png",
        imageBTSettings + "setting_selectarrow_icon_1.png",
        imageBTSettings + "setting_selectarrow_icon_2.png"
    ]

    property var img_2_left_btn_1: [
        imageBTSettings + "setting_selectarrow_icon_0.png"
    ]

    property var img_2_right_btn: [
        imageBTSettings + "setting_2_right_btn_0.png",
        imageBTSettings + "setting_2_right_btn_1.png",
        imageBTSettings + "setting_2_right_btn_2.png"
    ]

    property var img_softkey_4_btn: valueTheme === 2 ? img_softkey_4_btn_for_EM2 : img_softkey_4_btn_for_M0_MI

    property var img_softkey_4_btn_for_M0_MI:[
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]
    property var img_softkey_4_btn_for_EM2:[
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_03_0.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_03_1.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_03_2.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_04_0.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_04_1.png",
        imageBTSettings + "common_softkey_4_btn" + suffixes_by_mex_color(0) + "_04_2.png"
    ]

    property var img_scroll_down_btn: [
        imageBTSettings + "common_scroll_down_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_scroll_down_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_scroll_down_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]

    property var img_srcoll_up_btn: [
        imageBTSettings + "common_scroll_up_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_scroll_up_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_scroll_up_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]

    property var img_media_softkey_home_btn: [
        imageBTSettings + "fmradio_softkey_home_btn_0.png",
        imageBTSettings + "fmradio_softkey_home_btn_1.png",
        imageBTSettings + "fmradio_softkey_home_btn_2.png"
    ]

    property var img_setting_surSound_left_btn: valueTheme === 2 ? img_setting_surSound_left_btn_for_EM2: img_setting_surSound_left_btn_for_M0_MI
    property var img_setting_surSound_left_btn_for_M0_MI: [
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]
    property var img_setting_surSound_left_btn_for_EM2: [
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(0) + "_03_0.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(0) + "_03_1.png",
        imageBTSettings + "setting_surround_left_btn" + suffixes_by_mex_color(0) + "_03_2.png"
    ]
    property var img_setting_surSound_right_btn: valueTheme === 2 ? img_setting_surSound_right_btn_for_EM2 : img_setting_surSound_right_btn_for_M0_MI
    property var img_setting_surSound_right_btn_for_M0_MI: [
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]
    property var img_setting_surSound_right_btn_for_EM2: [
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(0) + "_03_0.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(0) + "_03_1.png",
        imageBTSettings + "setting_surround_right_btn" + suffixes_by_mex_color(0) + "_03_2.png"
    ]

    property var img_setting_surSound_middle_btn: [
        imageBTSettings + "setting_surround_center_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "setting_surround_center_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "setting_surround_center_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]

    property var img_direction_left_btn: [
        imageBTSettings + "setting_direction_left_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "setting_direction_left_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "setting_direction_left_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]

    property url img_direction_line: imageBTSettings + "setting_direction_line.png"

    property var img_direction_right_btn: [
        imageBTSettings + "setting_direction_right_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "setting_direction_right_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "setting_direction_right_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]

    property var img_direction_up_btn: [
        imageBTSettings + "setting_direction_up_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "setting_direction_up_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "setting_direction_up_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]

    property var img_direction_down_btn: [
        imageBTSettings + "setting_direction_down_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "setting_direction_down_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "setting_direction_down_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]

    property var img_direction_center_btn: [
        imageBTSettings + "setting_direction_center_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "setting_direction_center_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "setting_direction_center_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]

    property var img_direction_back_btn: [
        imageBTSettings + "common_softkey_back_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_softkey_back_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_softkey_back_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]
    property var img_direction_back_tp_btn: [
        imageBTSettings + "common_softkey_back_tp_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_softkey_back_tp_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_softkey_back_tp_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageBTSettings + "common_softkey_back_tp_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]

    property var img_direction_ok_btn: [
        imageBTSettings + "common_softkey_1_btn" + suffixes_by_mex_color(1) +"_0.png",
        imageBTSettings + "common_softkey_1_btn" + suffixes_by_mex_color(2) +"_1.png",
        imageBTSettings + "common_softkey_1_btn" + suffixes_by_mex_color(3) +"_2.png",
        imageBTSettings + "common_softkey_1_btn" + suffixes_by_mex_color(2) +"_1.png"
    ]

    property var img_common_ok_btn: [
        imageBTSettings + "common_softkey_1_btn" + suffixes_by_mex_color(1) +"_0.png",
        imageBTSettings + "common_softkey_1_btn" + suffixes_by_mex_color(2) +"_1.png",
        imageBTSettings + "common_softkey_1_btn" + suffixes_by_mex_color(3) +"_2.png"
    ]

    property var img_sound_audio_icon:[
        imageBTSettings + "setting_sound_audio_icon_0.png",
        imageBTSettings + "setting_sound_audio_icon_1.png"
    ]

    property var img_sound_navi_icon:[
        imageBTSettings + "setting_sound_navi_icon.png",
        imageBTSettings + "setting_sound_navi_icon.png"
    ]

    property var img_sound_ta_icon:[
        imageBTSettings + "setting_sound_ta_icon.png",
        imageBTSettings + "setting_sound_ta_icon.png"
    ]

    property var img_sound_te_icon:[
        imageBTSettings + "setting_sound_tel_icon.png",
        imageBTSettings + "setting_sound_tel_icon.png"
    ]

    property var img_sound_ring_icon:[
        imageBTSettings + "setting_sound_ring_icon.png",
        imageBTSettings + "setting_sound_ring_icon.png"
    ]

    property var img_sound_list_siri_icon:[
        imageBTSettings + "setting_sound_vr_icon.png",
        imageBTSettings + "setting_sound_vr_icon.png"
    ]


    property var img_timesetting_down_btn:valueTheme === 2 ? img_timesetting_down_btn_for_EM2 : img_timesetting_down_btn_for_M0_MI
    property var img_timesetting_down_btn_for_EM2:[
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(0) + "_01_3.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(0) + "_02_3.png"
    ]
    property var img_timesetting_down_btn_for_M0_MI:[
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageBTSettings + "common_timesetting_down_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]
    property var img_timesetting_bg: valueTheme === 2 ? img_timesetting_bg_for_EM2 : img_timesetting_bg_for_M0_MI

    property var img_timesetting_bg_for_M0_MI : [imageBTSettings + "common_timesetting_bg.png"]
    property var img_timesetting_bg_for_EM2 : [
        imageBTSettings + "common_timesetting_bg_01.png",
        imageBTSettings + "common_timesetting_bg_02.png"
    ]

    property var img_timesetting_up_btn: valueTheme === 2 ? img_timesetting_up_btn_for_EM2 : img_timesetting_up_btn_for_M0_MI
    property var img_timesetting_up_btn_for_EM2:[
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(0) + "_01_3.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(0) + "_02_3.png"
    ]
    property var img_timesetting_up_btn_for_M0_MI:[
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageBTSettings + "common_timesetting_up_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]
    property var img_timesetting_am: [
        imageBTSettings + "common_timesetting_am_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_timesetting_am_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_timesetting_am_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageBTSettings + "common_timesetting_am_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]
    property var img_timesetting_pm: [
        imageBTSettings + "common_timesetting_pm_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_timesetting_pm_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_timesetting_pm_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageBTSettings + "common_timesetting_pm_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]

    readonly property var img_list_press: valueTheme === 2 ? img_list_press_for_EM2 : img_list_press_for_MO_MI

    readonly property var img_list_press_for_MO_MI:[
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(3) + "_2.png"
    ]
    readonly property var img_list_press_for_EM2:[
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_03_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_03_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_03_2.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_04_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_04_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_04_2.png"
    ]

    readonly property var img_checkbox: [
        imageBTSettings + "setting_checkbox_btn_0.png",
        imageBTSettings + "setting_checkbox_btn_1.png",
        imageBTSettings + "setting_checkbox_btn_2.png",
        imageBTSettings + "setting_checkbox_btn_3.png"
    ]
    readonly property var img_testkey_number_btn: [
        imageBTSettings + "common_authentication_key_number_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_authentication_key_number_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_authentication_key_number_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageBTSettings + "common_authentication_key_number_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]

    readonly property var  img_common_authentication_back_btn: [
        imageBTSettings + "common_authentication_back_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_authentication_back_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_authentication_back_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageBTSettings + "common_authentication_back_btn" + suffixes_by_mex_color(2) + "_1.png",
    ]
    readonly property var img_osl_info_btn: [
        imageBTSettings + "setting_info_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "setting_info_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "setting_info_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageBTSettings + "setting_info_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]

    readonly property url img_common_authentication_key_inputbox:           imageBTSettings + "common_authentication_key_inputbox.png"
    readonly property url img_barSound:                                     imageBTSettings + "setting_surround_bar_bg.png"
    readonly property url img_barSound_f:                                   imageBTSettings + "setting_surround_bar_f.png"
    readonly property url img_common_stepper_bg:                            imageBTSettings + "common_stepper_bg.png"
    readonly property url img_common_stepper_bar_img:                       imageBTSettings + "common_stepper_bar_img.png"
    readonly property url img_direction:                                    imageBTSettings + "setting_direction_img.png"
    readonly property url img_direction_rear_gray:                          imageBTSettings + "setting_direction_img_rear.png"
    readonly property url img_direction_point:                              imageBTSettings + "setting_direction_point.png"
    readonly property url img_volspeed_bg:                                  imageBTSettings + "common_spinner_bg.png"


    readonly property url img_screenBg:                                     imageBTSettings +"setting_bg.png"
    readonly property url img_fmradio_bg:                                   imageBTSettings +"fmradio_bg.png"
    readonly property url img_list_line:                                    imageBTSettings + "setting_list_divider.png"
    //poppup image
    readonly property url img_popup:                                        imageBTSettings + "popup_bg.png"
    //setting_title_siri_help_icon
    readonly property url setting_title_siri_help_icon: imageBTSettings + "setting_title_siri_help_icon.png"


    property var img_national: [
        imageFlag +  "setting_flag_cz_img.png",
        imageFlag +  "setting_flag_dk_img.png",
        imageFlag +  "setting_flag_de_img.png",
        imageFlag +  "setting_flag_England_img.png",
        imageFlag +  "setting_flag_au_img.png",
        imageFlag +  "setting_flag_ee_img.png",
        imageFlag +  "setting_flag_es_img.png",
        imageFlag +  "setting_flag_fr_img.png",
        imageFlag +  "setting_flag_hr_img.png",
        imageFlag +  "setting_flag_id_img.png",
        imageFlag +  "setting_flag_it_img.png",
        imageFlag +  "setting_flag_lv_img.png",
        imageFlag +  "setting_flag_lt_img.png",
        imageFlag +  "setting_flag_hu_img.png",
        imageFlag +  "setting_flag_nl_img.png",
        imageFlag +  "setting_flag_no_img.png",
        imageFlag +  "setting_flag_pl_img.png",
        imageFlag +  "setting_flag_pt_img.png",
        imageFlag +  "setting_flag_br_img.png",
        imageFlag +  "setting_flag_ro_img.png",
        imageFlag +  "setting_flag_si_img.png",
        imageFlag +  "setting_flag_sk_img.png",
        imageFlag +  "setting_flag_fi_img.png",
        imageFlag +  "setting_flag_se_img.png",
        imageFlag +  "setting_flag_tr_img.png",
        imageFlag +  "setting_flag_gr_img.png",
        imageFlag +  "setting_flag_bg_img.png",
        imageFlag +  "setting_flag_kz_img.png",
        imageFlag +  "setting_flag_ru_img.png",
        imageFlag +  "setting_flag_rs_img.png",
        imageFlag +  "setting_flag_ua_img.png",
        imageFlag +  "setting_flag_il_img.png",
        imageFlag +  "setting_flag_Arab League_img.png",
        imageFlag +  "setting_flag_ir_img.png",
        imageFlag +  "setting_flag_in_img.png",
        imageFlag +  "setting_flag_jp_img.png",
        imageFlag +  "setting_flag_al_img.png"
    ]

    property var img_national_deactive_Israel: [
        imageFlag +  "setting_flag_cz_img.png",
        imageFlag +  "setting_flag_dk_img.png",
        imageFlag +  "setting_flag_de_img.png",
        imageFlag +  "setting_flag_England_img.png",
        imageFlag +  "setting_flag_au_img.png",
        imageFlag +  "setting_flag_ee_img.png",
        imageFlag +  "setting_flag_es_img.png",
        imageFlag +  "setting_flag_fr_img.png",
        imageFlag +  "setting_flag_hr_img.png",
        imageFlag +  "setting_flag_id_img.png",
        imageFlag +  "setting_flag_it_img.png",
        imageFlag +  "setting_flag_lv_img.png",
        imageFlag +  "setting_flag_lt_img.png",
        imageFlag +  "setting_flag_hu_img.png",
        imageFlag +  "setting_flag_nl_img.png",
        imageFlag +  "setting_flag_no_img.png",
        imageFlag +  "setting_flag_pl_img.png",
        imageFlag +  "setting_flag_pt_img.png",
        imageFlag +  "setting_flag_br_img.png",
        imageFlag +  "setting_flag_ro_img.png",
        imageFlag +  "setting_flag_si_img.png",
        imageFlag +  "setting_flag_sk_img.png",
        imageFlag +  "setting_flag_fi_img.png",
        imageFlag +  "setting_flag_se_img.png",
        imageFlag +  "setting_flag_tr_img.png",
        imageFlag +  "setting_flag_gr_img.png",
        imageFlag +  "setting_flag_bg_img.png",
        imageFlag +  "setting_flag_kz_img.png",
        imageFlag +  "setting_flag_ru_img.png",
        imageFlag +  "setting_flag_rs_img.png",
        imageFlag +  "setting_flag_ua_img.png",
        //imageFlag +  "setting_flag_il_img.png",
        imageFlag +  "setting_flag_Arab League_img.png",
        imageFlag +  "setting_flag_ir_img.png",
        imageFlag +  "setting_flag_in_img.png",
        imageFlag +  "setting_flag_jp_img.png",
        imageFlag +  "setting_flag_al_img.png"
    ]

    // KeyboardManage
    readonly property url img_phone_keyboard_bg:            imageKeyboard + "keyboard_bg.png"
    property url keyboard_search_type_bg : imageKeyboard + "phone_keyboard_search_type_bg.png"
    property var keyboard_down_button:[
        imageKeyboard + "phone_keyboard_search_results_list_down_btn"+ suffixes_by_mex_color(1) + "_0.png",
        imageKeyboard + "phone_keyboard_search_results_list_down_btn"+ suffixes_by_mex_color(2) + "_1.png",
        imageKeyboard + "phone_keyboard_search_results_list_down_btn"+ suffixes_by_mex_color(3) + "_2.png",
        imageKeyboard + "phone_keyboard_search_results_list_down_btn"+ suffixes_by_mex_color(2) + "_1.png"
    ]

    property var keyboard_up_button:[
        imageKeyboard + "phone_keyboard_search_results_list_up_btn"+ suffixes_by_mex_color(1) + "_0.png",
        imageKeyboard + "phone_keyboard_search_results_list_up_btn"+ suffixes_by_mex_color(2) + "_1.png",
        imageKeyboard + "phone_keyboard_search_results_list_up_btn"+ suffixes_by_mex_color(3) + "_2.png",
        imageKeyboard + "phone_keyboard_search_results_list_up_btn"+ suffixes_by_mex_color(2) + "_1.png"
    ]

    property var keyboard_backspace_button:[
        imageKeyboard + "phone_keyboard_search_back_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageKeyboard + "phone_keyboard_search_back_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageKeyboard + "phone_keyboard_search_back_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageKeyboard + "phone_keyboard_search_back_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]

    property var keyboard_search_results_button:[
        imageKeyboard + "phone_keyboard_search_results_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageKeyboard + "phone_keyboard_search_results_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageKeyboard + "phone_keyboard_search_results_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageKeyboard + "phone_keyboard_search_results_btn" + suffixes_by_mex_color(2) + "_1.png",
    ]
    property var img_phone_list_press:valueTheme === 2 ? img_phone_list_press_for_EM2 : img_phone_list_press_for_M0_MI
    property var img_phone_list_press_for_M0_MI:[
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(1) + "_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(2) + "_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(3) + "_2.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]
    property var img_phone_list_press_for_EM2:[
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_03_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_03_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_03_2.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_03_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_04_0.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_04_1.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_04_2.png",
        imageBTSettings + "common_list_btn" + suffixes_by_mex_color(0) + "_04_1.png"
    ]

    //for popup
    property url popup_conform_notext: imagePopup + "popup_bg.png"
    property url popup_conform2_button: imagePopup + "popup_confirm2_bg.png"
    property url popup_conform1_button: imagePopup + "popup_confirm_bg.png"

    //for popup 2 buttons
    property url imgReleased_first_btn: imagePopup + "popup_confirm2_btn" + suffixes_by_mex_color(1) + "_01_0" + ".png"
    property url imgReleased_second_btn: imagePopup + "popup_confirm2_btn" + suffixes_by_mex_color(1) + "_02_0" + ".png"
    property url imgPressed_first_btn: imagePopup + "popup_confirm2_btn" + suffixes_by_mex_color(2) + "_01_1" + ".png"
    property url imgPressed_second_btn: imagePopup + "popup_confirm2_btn" + suffixes_by_mex_color(2) + "_02_1" + ".png"

    //for popup 1 buttons
    property url imgReleased_1_btn: imagePopup + "popup_confirm_btn" + suffixes_by_mex_color(1) + "_0" + ".png"
    property url imgPressed_1_btn: imagePopup + "popup_confirm_btn" + suffixes_by_mex_color(2) + "_1" + ".png"
    property url img_popup_list_bg: imagePopup + "popup_list_bg.png"
    property var img_phonebook_popup_list_press_btn: valueTheme === 2 ? img_phonebook_popup_list_press_btn_for_EM2 : img_phonebook_popup_list_press_btn_for_M0_MI
    property var img_phonebook_popup_list_press_btn_for_M0_MI:[
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(1)+ "_0.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(2)+ "_1.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(3)+ "_2.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(2)+ "_1.png"
    ]
    property var img_phonebook_popup_list_press_btn_for_EM2:[
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_01_0.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_01_1.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_01_2.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_01_3.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_02_0.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_02_1.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_02_2.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_02_3.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_03_0.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_03_1.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_03_2.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_03_3.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_04_0.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_04_1.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_04_2.png",
        imagePopup + "popup_list_press_btn" + suffixes_by_mex_color(0) + "_04_3.png"
    ]
    property var img_popup_list_confirm_btn:[
        imagePopup + "popup_confirm_btn" + suffixes_by_mex_color(1) + "_0.png",
        imagePopup + "popup_confirm_btn" + suffixes_by_mex_color(2) + "_1.png",
        imagePopup + "popup_confirm_btn" + suffixes_by_mex_color(3) + "_2.png",
        imagePopup + "popup_confirm_btn" + suffixes_by_mex_color(2) + "_1.png"
    ]
}
