SetupHulpdiensten = function() {
    var appPagina = document.getElementById("hulpdiensten-app");

    appPagina.style.display = "block";
    document.getElementById("hulpdiensten-selectie").style.display = "flex";
    document.getElementById("hulpdiensten-bericht-112").style.display = "none";
    document.getElementById("hulpdiensten-bericht-ambulance").style.display = "none";
    document.getElementById("hulpdiensten-bericht-anwb").style.display = "none";
}

var selectiewout = document.getElementById("selectie-wout");
var selectieAmbulance = document.getElementById("selectie-ambulance");
var selectieANWB = document.getElementById("selectie-anwb");

selectiewout.addEventListener("click", function() {
    document.getElementById("hulpdiensten-selectie").style.display = "none";
    document.getElementById("hulpdiensten-bericht-112").style.display = "block";
});

selectieAmbulance.addEventListener("click", function() {
    document.getElementById("hulpdiensten-selectie").style.display = "none";
    document.getElementById("hulpdiensten-bericht-ambulance").style.display = "block";
});

selectieANWB.addEventListener("click", function() {
    document.getElementById("hulpdiensten-selectie").style.display = "none";
    document.getElementById("hulpdiensten-bericht-anwb").style.display = "block";
});


document.getElementById("hulpdiensten-bericht-112-versturen").addEventListener("click", function() {
    var bericht = document.getElementById("hulpdiensten-bericht-112-bericht").value;
    
    if (bericht == "") {
        QB.Phone.Notifications.Add("fas fa-bell", "Hulpdiensten", "Je melding kan niet leeg zijn!");
    } else {
        $.post('https://zb-phone/hulpdienstenMelding112', JSON.stringify({
            bericht: bericht
        }));
        
        QB.Phone.Notifications.Add("fas fa-bell", "Hulpdiensten", "Je melding is verzonden naar de wout!");
    
        document.getElementById("hulpdiensten-bericht-112-bericht").value = "";
        document.getElementById("hulpdiensten-selectie").style.display = "flex";
        document.getElementById("hulpdiensten-bericht-112").style.display = "none";
    }
});

document.getElementById("hulpdiensten-bericht-ambulance-versturen").addEventListener("click", function() {
    var bericht = document.getElementById("hulpdiensten-bericht-ambulance-bericht").value;

    if (bericht == "") {
        QB.Phone.Notifications.Add("fas fa-bell", "Hulpdiensten", "Je melding kan niet leeg zijn!");
    } else {
        $.post('https://zb-phone/hulpdienstenMeldingAmbulance', JSON.stringify({
            bericht: bericht
        }));
        
        QB.Phone.Notifications.Add("fas fa-bell", "Hulpdiensten", "Je melding is verzonden naar de Ambulance!");
    
        document.getElementById("hulpdiensten-bericht-ambulance-bericht").value = "";
        document.getElementById("hulpdiensten-selectie").style.display = "flex";
        document.getElementById("hulpdiensten-bericht-ambulance").style.display = "none";
    }
});

document.getElementById("hulpdiensten-bericht-anwb-versturen").addEventListener("click", function() {
    var bericht = document.getElementById("hulpdiensten-bericht-anwb-bericht").value;

    if (bericht == "") {
        QB.Phone.Notifications.Add("fas fa-bell", "Hulpdiensten", "Je melding kan niet leeg zijn!");
    } else {
        $.post('https://zb-phone/hulpdienstenMeldingANWB', JSON.stringify({
            bericht: bericht
        }));
        
        QB.Phone.Notifications.Add("fas fa-bell", "Hulpdiensten", "Je melding is verzonden!");
    
        document.getElementById("hulpdiensten-bericht-anwb-bericht").value = "";
        document.getElementById("hulpdiensten-selectie").style.display = "flex";
        document.getElementById("hulpdiensten-bericht-anwb").style.display = "none";
    }
});