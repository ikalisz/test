const app = new Vue({
    el: "#app",
    data: {
        progress: 50,
        text: 'Yükleniyor...'
    },
})
var audioPlayer = null;
var play = true;
const data = [
    { 
        text: `Lvbel C5 - Dacia (Speed UP) rabirdır tarafından seçildi`, 
        music: 'https://cdn.discordapp.com/attachments/1070377961158623262/1070378007170125844/LVBEL_C5_-_DACIA_speed_up.mp3', 
        volume: 0.10
    },
    { 
        text: `Uzi Paranoya X Heijan&Muti (Speed UP) ra1der tarafından seçildi`, 
        music: 'https://cdn.discordapp.com/attachments/1070377961158623262/1070378007455350894/Paranoya_x_Bilader_sped_up.mp3', 
        volume: 0.10
    },
    { 
        text: `ERO - Kontrol ra(one)der tarafından seçildi`, 
        music: 'https://cdn.discordapp.com/attachments/1070377961158623262/1070378007753130004/Ero_-_Kontrol_Speed_Up.mp3', 
        volume: 0.15
    },
]

window.addEventListener('load', (event) => {
    var currentData = data[Math.floor(Math.random() * data.length)]
    audioPlayer = new Audio(currentData.music);
    audioPlayer['volume'] = currentData.volume;
    audioPlayer['play']();
    $('.main > p').html('<img style="margin-top: -0.7%; padding-right: 2px;"width="18" alt="Spotify icon" src="https://cdn.discordapp.com/attachments/932478723700183140/1042511194252116118/sptfy.svg">  ' + currentData.text);
    const texts = [".","..","..."]
    let ct = 1
    setInterval(() => {
        if (ct == 3) {
            ct = 0
        } else {
            ct += 1
        } 
        app.status = texts[ct]
    }, 1000)
});

let count = 0;
let thisCount = 0;
const handlers = {
    startInitFunctionOrder(data) {
        count = data.count;
    },

    initFunctionInvoking(data) {
        let load = Math.floor((data.idx / count) * 100)
        if (load > 100) {load = 100}
        app.progress = load
    },

    startDataFileEntries(data) {
        count = data.count;
    },

    performMapLoadFunction(data) {
        ++thisCount;
        let load = Math.floor((thisCount / count) * 100)
        if (load > 100) {load = 100}
        app.progress = load
    },
};

window.addEventListener("message", function (e) {
    (handlers[e.data.eventName] || function () {})(e.data);
});

window['addEventListener']('keydown', onKeyDown, false);
function onKeyDown(_0x32a5x4) {
    switch (_0x32a5x4['keyCode']) {
        case 32:
            if (play) {
                audioPlayer['pause']();
                play = false
            } else {
                audioPlayer['play']();
                play = true
            };
            break
    };
    return false
}
