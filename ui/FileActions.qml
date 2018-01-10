import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

import sfxr2 1.0

ColumnLayout {
    property Sound sound
    property SoundPlayer soundPlayer

    Button {
        text: qsTr("Play (Return)")
        onClicked: {
            soundPlayer.play();
        }
    }

    Shortcut {
        sequence: "Return"
        onActivated: soundPlayer.play();
    }

    Label {
        text: qsTr("File")
        font.bold: true
    }
    Button {
        FileDialog {
            id: loadFileDialog
            title: qsTr("Load SFXR sound")
            nameFilters: [qsTr("sfxr files") + " (*.sfxr)",
                qsTr("All files") + " (*)"]
            onAccepted: {
                sound.load(fileUrl);
            }
        }
        text: qsTr("Load...")
        onClicked: {
            loadFileDialog.open();
        }
    }

    Button {
        FileDialog {
            id: saveFileDialog
            title: qsTr("Save SFXR sound")
            selectExisting: false
            nameFilters: [qsTr("sfxr files") + " (*.sfxr)",
                qsTr("All files") + " (*)"]
            onAccepted: {
                sound.save(fileUrl);
            }
        }
        text: qsTr("Save as...")
        onClicked: {
            saveFileDialog.open();
        }
    }

    Label {
        text: qsTr("WAV export")
        font.bold: true
    }

    WavSaver {
        id: wavSaver
    }

    Button {
        Layout.fillWidth: true
        text: qsTr("%1 bits").arg(wavSaver.bits)
        onClicked: {
            wavSaver.bits = wavSaver.bits == 16 ? 8 : 16;
        }
    }

    Button {
        Layout.fillWidth: true
        text: qsTr("%1 hz").arg(wavSaver.frequency)
        onClicked: {
            wavSaver.frequency = wavSaver.frequency == 44100 ? 22050 : 44100;
        }
    }

    Button {
        Layout.fillWidth: true
        FileDialog {
            id: exportWavFileDialog
            selectExisting: false
            title: qsTr("Export as WAV")
            nameFilters: [qsTr("Wav files") + " (*.wav)",
                qsTr("All files") + " (*)"]
            onAccepted: {
                wavSaver.save(sound, fileUrl);
            }
        }
        text: qsTr("Export as...")
        onClicked: {
            exportWavFileDialog.open();
        }
    }
}