/*

Gemaakt door: Finn#0007

*/

// Openen en sluiten
window.addEventListener('message', function(event){
    if (event.data.type == "open") {
        $("#telefoon").slideDown();

    } else if (event.data.type == "opensim") {
        $("#telefoon").slideDown();
        document.getElementById("bmchat-app-icon").style.display = "block";

    } else if (event.data.type == "nieuwEncroBericht") {
        var chat = event.data.chat;
        var bericht = event.data.bericht;
        chatappNieuwBericht(chat, false, bericht, true);

    } else if (event.data.type == "updateCrypto") {
        var aantal = event.data.aantal;
        updateCrypto(aantal);

    } else if (event.data.type == "nieuweTaak") {
        var missieNaam = event.data.missieNaam;
        var missieTrigger = event.data.missieTrigger;
        nieuweTaak(missieNaam, missieTrigger);

    } else if (event.data.type == "openATM") {
        var citizenid = event.data.citizenid;

        fetch(`https://zb-customdrugs/requestCrypto`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        }).then(resp => resp.json()).then(resp => openATM(citizenid, resp));

    } else if (event.data.type == "updateLabApp") {
        document.getElementById("buttonBasic").setAttribute("onclick", "verkoopLab();");
        document.getElementById("buttonBasic").innerText = "Verkoop je lab voor 50%";
        document.getElementById("buttonPro").setAttribute("onclick", "verkoopLab();");
        document.getElementById("buttonPro").innerText = "Verkoop je lab voor 50%";
    } else if (event.data.type == "openlablaptop") {
        openLaptop();
    } else if (event.data.type == "grondstofLocatieMelding") {
        notificatie("Je levering is klaar man, locatie staat op je GPS ingesteld!", true)
    } else if (event.data.type == "grondstofReady") {
        document.getElementById("grondstofBestellen").disabled = false;

    } else if (event.data.type == "nieuweHandel") {
        nieuweHandel(event.data.aantal);
    } else if (event.data.type == "stopHandel") {
        stopHandel();
    } else if (event.data.type == "nieuwEncroMelding") {
        var chatKanaal = event.data.chat;
        notificatie("Er is een nieuw EncroChat chatbericht in het " + chatKanaal + " kanaal!", false);
    }
});

// Escape toets
document.onkeydown = function(evt) {
    evt = evt || window.event;
    if (evt.key == "Escape") {
        $("#telefoon").slideUp();
        $("#bitcoinatm-main").fadeOut();
        $("#lab-laptop").fadeOut();
        $.post("https://zb-customdrugs/customdrugs-sluit", JSON.stringify({}));
        document.getElementById("bmchat-app-icon").style.display = "none";
    }
};

// Home knop
var homeknop = document.getElementById("homeknop");
homeknop.addEventListener("click", function() {
    var homescherm = document.getElementById("homescherm");
    homescherm.style.display = "block";

    chatAppScherm.style.display = "none";
    cryptoAppScherm.style.display = "none";
    takenAppScherm.style.display = "none";
    twitterAppScherm.style.display = "none";
    labAppScherm.style.display = "none";
    handelApp.style.display = "none";
    locatiesApp.style.display = "none";
    bmchatApp.style.display = "none";
});

// Alle apps
var homescherm = document.getElementById("homescherm");
function triggerAppOpen(appNaam) {
    appNaam = appNaam;

    if (appNaam == 'chat') {
        // Chat
        homescherm.style.display = "none";
        openChatApp();
    } else if (appNaam == 'taken') {
        // Taken
        homescherm.style.display = "none";
        openTakenApp();
    } else if (appNaam == 'crypto') {
        // Crypto
        homescherm.style.display = "none";

        fetch(`https://zb-customdrugs/requestCrypto`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        }).then(resp => resp.json()).then(resp => openCryptoApp(resp));
    } else if (appNaam == 'instellingen') {
        // Instellingen
    } else if (appNaam == 'twitter') {
        homescherm.style.display = "none";
        openTwitter();
    } else if (appNaam == 'lab') {
        homescherm.style.display = "none";
        openLab();
    } else if (appNaam == "handel") {
        homescherm.style.display = "none";
        openHandel();
    } else if (appNaam == "locaties") {
        homescherm.style.display = "none";
        openLocaties();
    } else if (appNaam == "bmchat") {
        homescherm.style.display = "none";
        openBmchat();
    }
}



// Apps
// Apps
// Apps
// Apps
// Apps

//Chat App
var chatSpamCounter = 0;

var chatAppHome = document.getElementById("chatapp-topbalk-home");

var chatLijstDrugs = document.getElementById("chatLijstDrugs");
var chatLijstWapens = document.getElementById("chatLijstWapens");
var chatLijstAdverteren = document.getElementById("chatLijstAdverteren");

var chatDrugsVeld = document.getElementById("chatDrugsVeld");
var chatWapenhandelVeld = document.getElementById("chatWapenhandelVeld");
var chatAdverterenVeld = document.getElementById("chatAdverterenVeld");

function openChatApp() { // Open de app
    $("#chatAppScherm").fadeIn();
}

function notificatie(bericht, geluid) {
    var bericht = bericht;

    var notificatieTekstP = document.getElementById("notificatie-text");
    var notificatieBox = document.getElementById("drugs-telefoon-notificatie");

    notificatieTekstP.innerText = bericht;
    $("#drugs-telefoon-notificatie").fadeIn("slow");
    if (geluid == true) {
        var notificatieGeluid = new Audio("./sounds/notificatie.mp3");
        notificatieGeluid.volume = 0.15;
        notificatieGeluid.play();
    }
    $("#drugs-telefoon-notificatie").delay(5000).fadeOut("slow");
}

chatAppHome.addEventListener("click", function() { // Terug naar home
    $("#chatbox-drugs").fadeOut();
    $("#chatbox-wapenhandel").fadeOut();
    $("#chatbox-adverteren").fadeOut();
    $("#chatapp-groepenlijst").fadeIn();
});

chatLijstDrugs.addEventListener("click", function() {
    $("#chatapp-groepenlijst").fadeOut();
    $("#chatbox-drugs").fadeIn();
});

chatLijstWapens.addEventListener("click", function() {
    $("#chatapp-groepenlijst").fadeOut();
    $("#chatbox-wapenhandel").fadeIn();
});

chatLijstAdverteren.addEventListener("click", function() {
    $("#chatapp-groepenlijst").fadeOut();
    $("#chatbox-adverteren").fadeIn();
});

chatDrugsVeld.addEventListener("keypress", function (toets) { // Versturen van chatdrugs veld
    if (toets.key === "Enter") {
        var bericht = document.getElementById("chatDrugsVeld").value;
        var verzender = true;
        if (bericht != "") { // Als het bericht niet leeg is
            chatappNieuwBericht(1, verzender, bericht, false);
            document.getElementById("chatDrugsVeld").value = "";

            var objectDiv = document.getElementById("chatbox-drugs-berichten");
            objectDiv.scrollTop = objectDiv.scrollHeight;

            chatSpamCounter = chatSpamCounter + 1;
            if (chatSpamCounter >= 3) {
                document.getElementById("chatDrugsVeld").setAttribute("disabled", true)
            }
            setTimeout(chatSpamCounterMin, 5000);
        }
    }
});

chatWapenhandelVeld.addEventListener("keypress", function (toets) { // Versturen van wapenhandel veld
    if (toets.key === "Enter") {
        var bericht = document.getElementById("chatWapenhandelVeld").value;
        var verzender = true;
        if (bericht != "") { // Als het bericht niet leeg is
            chatappNieuwBericht(2, verzender, bericht, false);
            document.getElementById("chatWapenhandelVeld").value = "";

            var objectDiv = document.getElementById("chatbox-wapenhandel-berichten");
            objectDiv.scrollTop = objectDiv.scrollHeight;

            chatSpamCounter = chatSpamCounter + 1;
            if (chatSpamCounter >= 3) {
                document.getElementById("chatWapenhandelVeld").setAttribute("disabled", true)
            }
            setTimeout(chatSpamCounterMin, 5000);
        }
    }
});

chatAdverterenVeld.addEventListener("keypress", function (toets) { // Versturen van adverteren veld
    if (toets.key === "Enter") {
        var bericht = document.getElementById("chatAdverterenVeld").value;
        var verzender = true;
        if (bericht != "") { // Als het bericht niet leeg is
            chatappNieuwBericht(3, verzender, bericht, false);
            document.getElementById("chatAdverterenVeld").value = "";

            var objectDiv = document.getElementById("chatbox-adverteren-berichten");
            objectDiv.scrollTop = objectDiv.scrollHeight;

            chatSpamCounter = chatSpamCounter + 1;
            if (chatSpamCounter >= 3) {
                document.getElementById("chatAdverterenVeld").setAttribute("disabled", true)
            }
            setTimeout(chatSpamCounterMin, 5000);
        }
    }
});


function chatappNieuwBericht(chat, verzender, bericht, server) {
    var chat = chat;
    var verzender = verzender;
    var bericht = bericht;
    var server = server;

    var dateObject = new Date();
    var uren = dateObject.getHours();
    var minuten = dateObject.getMinutes();
    if (minuten < 10) {
        minuten = "0" + minuten;
    }

    if (server == false) {
        var bericht = bericht + " - " + uren + ":" + minuten;
    }

    // Alle chat groepen
    chat1 = document.getElementById("chatbox-drugs-berichten");
    chat2 = document.getElementById("chatbox-wapenhandel-berichten");
    chat3 = document.getElementById("chatbox-adverteren-berichten");

    var node = document.createElement("div");
    var textnode = document.createTextNode(bericht);
    node.appendChild(textnode);
    if (verzender == true) {
        node.className = "chatapp-chatbox-bericht rechts";
    } else {
        node.className = "chatapp-chatbox-bericht links";
    }
    if (chat == 1) { // Drugs chat
        chat1.appendChild(node);
    } else if (chat == 2) {
        chat2.appendChild(node);
    } else if (chat == 3){
        chat3.appendChild(node);
    }
    if (server == false) {
        $.post("https://zb-customdrugs/postEncroChat", JSON.stringify({
            chat: chat,
            bericht: bericht
        }));
    }
    window.scrollTo(0,document.body.scrollHeight);
}

function chatSpamCounterMin() {
    chatSpamCounter = chatSpamCounter - 1;
    if (chatSpamCounter == 0) {
        document.getElementById("chatDrugsVeld").removeAttribute("disabled");
        document.getElementById("chatWapenhandelVeld").removeAttribute("disabled");
        document.getElementById("chatAdverterenVeld").removeAttribute("disabled");
    }
}


// Crypto app
function openCryptoApp(saldo) {
    $("#cryptoAppScherm").fadeIn();
    var cryptoAppSaldo = document.getElementById("cryptoAppSaldo");
    var cryptoAppEuro = document.getElementById("cryptoAppEuro");

    cryptoAppSaldo.innerText = saldo;
    var cryptoAppEuros = saldo * 500;
    cryptoAppEuro.innerText = "(€" + cryptoAppEuros + ")";
}

function koopCrypto(aantal) {
    $.post("https://zb-customdrugs/koopCrypto", JSON.stringify({
        aantal: aantal
    }));
}

function updateCrypto(aantal) {
    var cryptoAppSaldo = document.getElementById("cryptoAppSaldo");
    var cryptoAppEuro = document.getElementById("cryptoAppEuro");

    cryptoAppSaldo.innerText = aantal;
    var cryptoAppEuros = aantal * 500;
    cryptoAppEuro.innerText = "(€" + cryptoAppEuros + ")";
}


// Taken app
function openTakenApp() {
    $("#takenAppScherm").fadeIn();
}

var takenAppSwitchKnop = document.getElementById("switch");
takenAppSwitchKnop.addEventListener("click", function() {
    var takenAppStatusText = document.getElementById("takenapp-status");
    if (takenAppSwitchKnop.checked) {
        takenAppStatusText.innerText = "Aanwezig";
        takenAppStatusText.style.color = "#bada55";
        editTakenStatus(true);
    } else {
        takenAppStatusText.innerText = "Afwezig";
        takenAppStatusText.style.color = "red";
        editTakenStatus(false);
    }
});

function editTakenStatus(status) {
    if (status) {
        $.post("https://zb-customdrugs/editTakenStatus", JSON.stringify({
            status: true
        }));
    } else {
        $.post("https://zb-customdrugs/editTakenStatus", JSON.stringify({
            status: false
        }));
    }
}

var openStaandeTaken = 0;

function nieuweTaak(naam, trigger) {
    if (openStaandeTaken < 10) {
        var naam = naam;
        var trigger = trigger;

        var takenlijstdiv = document.getElementById("takenapp-takenlijst");
        
        var node = document.createElement("div");
        var pnode = document.createElement("p");
        var pnodeText = document.createTextNode(naam);
        node.appendChild(pnode);
        pnode.appendChild(pnodeText);
        node.className = "takenapp-takenlijst-taak";

        var button = document.createElement("button");
        // var buttonText = document.createTextNode("ok");
        var buttonIElement = document.createElement("i");
        button.appendChild(buttonIElement);
        node.appendChild(button);
        buttonIElement.className = "fas fa-check-square";
        var hash = Math.random().toString(36).substring(3,15);
        button.setAttribute("id", hash);
        button.setAttribute("onclick", "accepteerTaak('"+trigger+"', this.id)");

        takenlijstdiv.appendChild(node);
        openStaandeTaken++;
        notificatie("Er is een nieuwe taak in de taken app!", true);
    }
}

function accepteerTaak(trigger, id) {
    var bezigheid = false;

    fetch(`https://zb-customdrugs/vraagBezigheidTaakOp`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(function(bezig) {
        if (bezig == false) {
            trigger = trigger;
            id = id;
            $.post("https://zb-customdrugs/startTaak", JSON.stringify({
                trigger: trigger,
                id: id
            }));
        
            var taak = document.getElementById(id);
            taak.parentNode.remove(taak);
            openStaandeTaken--;
        }
    });


}

// Anonieme Twitter
function openTwitter() {
    $("#twitterAppScherm").fadeIn();
}

function verstuurAnonTweet() {
    var tweet = document.getElementById("anonTweetVeld").value;
    var CurrentDate = new Date();

    document.getElementById("anonTweetVeld").value = "";

    if (tweet != "") {
        $.post("https://zb-customdrugs/PlaatsAnonTweet", JSON.stringify({
            message: tweet,
            date: CurrentDate
        }));
    }
}

// Labs
function openLab() {
    $("#labAppScherm").fadeIn();

    fetch(`https://zb-customdrugs/checkLab`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(function(status) {
        if (status) {
            document.getElementById("buttonBasic").setAttribute("onclick", "confirmatieVerkoop();");
            document.getElementById("buttonBasic").innerText = "Verkoop je lab voor 50%";
            document.getElementById("buttonPro").setAttribute("onclick", "confirmatieVerkoop();");
            document.getElementById("buttonPro").innerText = "Verkoop je lab voor 50%";
        }
    });
}

function koopLab(type) {
    $.post("https://zb-customdrugs/koopLab", JSON.stringify({
        lab: type
    }));
}

function confirmatieVerkoop() {
    document.getElementById("buttonBasic").style.backgroundColor = "#FF0000";
    document.getElementById("buttonBasic").innerText = "Weet je het zeker?";
    document.getElementById("buttonBasic").setAttribute("onclick", "verkoopLab();");
    document.getElementById("buttonPro").style.backgroundColor = "#FF0000";
    document.getElementById("buttonPro").innerText = "Weet je het zeker?";
    document.getElementById("buttonPro").setAttribute("onclick", "verkoopLab();");
}


function verkoopLab() {
    fetch(`https://zb-customdrugs/checkLab`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(function(status) {
        if (status) {
            $.post("https://zb-customdrugs/verkoopLab", JSON.stringify({}));
            document.getElementById("buttonBasic").setAttribute("onclick", "koopLab('basic');");
            document.getElementById("buttonBasic").innerHTML = "<i class='fab fa-bitcoin'></i> 200";
            document.getElementById("buttonBasic").style.backgroundColor = "#33FF99";

            document.getElementById("buttonPro").setAttribute("onclick", "koopLab('pro');");
            document.getElementById("buttonPro").innerHTML = "<i class='fab fa-bitcoin'></i> 500";
            document.getElementById("buttonPro").style.backgroundColor = "#33FF99";
        }
    });
}

// Handel app
function openHandel() {
    $("#handelApp").fadeIn(500);
}

var handelAantal = 0;

function nieuweHandel(aantal) {
    document.getElementById("handelZoeken").style.display = "none";
    document.getElementById("handelVerkoopKaart").style.display = "block";

    document.getElementById("handelAantal").innerText = aantal;
    handelAantal = aantal;
    document.getElementById("linksHandel").disabled = false;
    document.getElementById("rechtsHandel").disabled = false;
}

function stopHandel() {
    $.post("https://zb-customdrugs/handelDeny", JSON.stringify({}));
    document.getElementById("handelZoeken").style.display = "flex";
    document.getElementById("handelVerkoopKaart").style.display = "none";
    handelAantal = 0;
}

function handelDeny() {
    $.post("https://zb-customdrugs/handelDeny", JSON.stringify({}));
    document.getElementById("handelZoeken").style.display = "flex";
    document.getElementById("handelVerkoopKaart").style.display = "none";
    handelAantal = 0;
}

function handelAccept() {
    $.post("https://zb-customdrugs/handelAccept", JSON.stringify({
        aantal: handelAantal
    }));
    document.getElementById("linksHandel").disabled = true;
    document.getElementById("rechtsHandel").disabled = true;
}

// Locatie app
function openLocaties() {
    $("#locatiesApp").fadeIn(500);
}

function koopLocatie(type) {
    $.post("https://zb-customdrugs/koopLocatie", JSON.stringify({
        koopLocatie: type
    }));
}

// BM chat app
function openBmchat() {
    document.getElementById("bmchatBerichten").innerHTML = "";
    fetch(`https://zb-customdrugs/refreshBmChat`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(function(berichten) {
        berichten.forEach(element => {
            var bericht = element["bericht"];
            var verzender = element["verzender"];
            var datum = element["datum"];
            BmNieuwBericht(bericht, verzender, datum)
        });
    });

    $("#bmchatApp").fadeIn(500);
}

function BmNieuwBericht(bericht, verzender, datum) {
    var bericht = bericht; 
    var verzender = verzender;
    var datum = datum;
    var chat = document.getElementById("bmchatBerichten");

    var node = document.createElement("div");
    var textnode = document.createTextNode(bericht);
    node.appendChild(textnode);
    if (verzender == "speler") {
        node.className = "bmchat-chatbox-bericht rechts";
    } else {
        node.className = "bmchat-chatbox-bericht links";
    }

    chat.appendChild(node);
    window.scrollTo(0,document.body.scrollHeight);
}

bmchatVeld.addEventListener("keypress", function (toets) { // Versturen van bericht
    if (toets.key === "Enter") {
        var bericht = document.getElementById("bmchatVeld").value;
        if (bericht != "") {
            $.post("https://zb-customdrugs/verstuurBmBericht", JSON.stringify({
                bericht: bericht
            }));
            document.getElementById("bmchatVeld").value = "";
            var chat = document.getElementById("bmchatBerichten");
            var node = document.createElement("div");
            var textnode = document.createTextNode(bericht);
            node.appendChild(textnode);
            node.className = "bmchat-chatbox-bericht rechts";
        
            chat.appendChild(node);

            var objectDiv = document.getElementById("bmchatBerichten");
            objectDiv.scrollTop = objectDiv.scrollHeight;
        }
    }
});















// Bitcoin ATM pinautomaat
function openATM(citizenid, aantalBitcoin) {
    var citizenid = citizenid;
    var aantalBitcoin = aantalBitcoin;
    var aantalBitcoinEuro = aantalBitcoin * 500;
    var walletId = maakWalletId(citizenid);

    $("#bitcoinatm-main").fadeIn(500);

    document.getElementById("walletID").innerText = walletId;
    document.getElementById("bitcoinAantalATM").innerText = aantalBitcoin;
    document.getElementById("bitcoinAantalEuroATM").innerText = aantalBitcoinEuro;
}

function maakWalletId(citizenid){
    var arr = "abcdefghijklmnopqrstuvwxyz".split("");
    return citizenid.replace(/[a-z]/ig, function(m){ return arr.indexOf(m.toLowerCase()) + 1 });
}

function atmOpnemen() {
    var inputAantal = document.getElementById("ATMaantalInput").value;
    var inputAantal = parseInt(inputAantal);
    var regExp = /[a-zA-Z]/g;
    var atmResponse = 0;

    if (inputAantal < 1) {
        document.getElementById("atmFoutCode").innerText = "Het minimale aantal moet 1 zijn";
        $("#bitcoinatm-fout-div").fadeIn();
        $("#bitcoinatm-fout-div").delay(5000).fadeOut();
    } else if(regExp.test(inputAantal)){
        document.getElementById("atmFoutCode").innerText = "Het aantal moet een getal zijn";
        $("#bitcoinatm-fout-div").fadeIn();
        $("#bitcoinatm-fout-div").delay(5000).fadeOut();
    } else {
        // Alles klopt, geen rare torries
        fetch(`https://zb-customdrugs/pinBitcoin`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({aantal: inputAantal})
        }).then(resp => resp.json()).then(function(pinStatus) {
            if (pinStatus == true) {
                verversBitcoinATM();
                document.getElementById("atmGoedCode").innerText = "Transactie succesvol!";
                $("#bitcoinatm-goed-div").fadeIn();
                $("#bitcoinatm-goed-div").delay(5000).fadeOut();
            } else {
                document.getElementById("atmFoutCode").innerText = "Je hebt niet genoeg bitcoins om deze transactie uit te voeren!";
                $("#bitcoinatm-fout-div").fadeIn();
                $("#bitcoinatm-fout-div").delay(5000).fadeOut();
            }
        });
    }
}

function verversBitcoinATM() {
    fetch(`https://zb-customdrugs/requestCrypto`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        }).then(resp => resp.json()).then(function(response) {
            var aantalBitcoin = response;
            var aantalBitcoinEuro = aantalBitcoin * 500;
            document.getElementById("bitcoinAantalATM").innerText = aantalBitcoin;
            document.getElementById("bitcoinAantalEuroATM").innerText = aantalBitcoinEuro;
        });
}

// Lab laptop

var grondstofBestelBerichten = ["Yo, kan ik een levering krijgen?", "Ik heb snel een nieuwe levering nodig man!", "Kan je weer leveren?"];
var randomTijden = [5, 7, 9, 21, 22, 23];

function openLaptop() {
    $("#lab-laptop").fadeIn(500);
}

function grondstofBestellen() {
    var randomBericht = Math.floor(Math.random() * grondstofBestelBerichten.length);
    nieuwLabLaptopBericht(grondstofBestelBerichten[randomBericht], false);

    document.getElementById("grondstofBestellen").disabled = true;

    setTimeout(function() {
        var randomTijd = Math.floor(Math.random() * randomTijden.length);
        var formatRandomTijd = randomTijd;
        if (formatRandomTijd < 10) {
            formatRandomTijd = "0" + formatRandomTijd;
        }
        formatRandomTijd = formatRandomTijd + ":" + "00";
        nieuwLabLaptopBericht("Ik heb een levering voor je klaar om " + formatRandomTijd + " stuur ik je een locatie op je telefoon. Kom daar dan heen.", true);

        $.post("https://zb-customdrugs/nieuweGrondstofbestelling", JSON.stringify({
            tijd: randomTijd
        }));
    }, 5000);
}

function nieuwLabLaptopBericht(bericht, npc) {
    var labchatveld = document.getElementById("labchatveld");
    if (npc) {
        // Bericht komt van de NPC af
        var node = document.createElement("div");
        var textnode = document.createTextNode(bericht);
        node.appendChild(textnode);
        node.className = "lab-laptop-chatveld-links";
        labchatveld.appendChild(node);
        labchatveld.scrollTop = labchatveld.scrollHeight;
    } else {
        // Bericht komt van de speler af
        var node = document.createElement("div");
        var textnode = document.createTextNode(bericht);
        node.appendChild(textnode);
        node.className = "lab-laptop-chatveld-rechts";
        labchatveld.appendChild(node);
        labchatveld.scrollTop = labchatveld.scrollHeight;
    }
}