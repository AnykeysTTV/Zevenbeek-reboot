window.addEventListener("message", function(event) {
    if (event.data.type == "open") {
        $("#beheerComputer").fadeIn("fast");
    }
});

document.onkeydown = function(evt) { /* Escape event */
    evt = evt || window.event;
    if (evt.key == "Escape") {
        $("#beheerComputer").fadeOut("fast");
        $.post("https://zb-gemeentehuis/sluiten", JSON.stringify({}));
    }
};

function afsluiten() {
    $("#beheerComputer").fadeOut("fast");
    $.post("https://zb-gemeentehuis/sluiten", JSON.stringify({}));
}

function openwout() {
    $("#kiesKnoppen").fadeOut(100);
    $("#woutForm").delay(150).fadeIn("slow");
    $("#terugKnop").delay(150).fadeIn("slow");
}

function openAmbulance() {
    $("#kiesKnoppen").fadeOut(100);
    $("#ambulanceForm").fadeIn("slow");
    $("#terugKnop").delay(150).fadeIn("slow");
}

function openAnwb() {
    $("#kiesKnoppen").fadeOut(100);
    $("#anwbForm").delay(150).fadeIn("slow");
    $("#terugKnop").delay(150).fadeIn("slow");
}

function terug() {
    document.getElementById("woutForm").style.display = "none";
    document.getElementById("ambulanceForm").style.display = "none";
    document.getElementById("anwbForm").style.display = "none";
    $("#kiesKnoppen").fadeIn("slow");
    document.getElementById("terugKnop").style.display = "none";
}

function krijgJob(baan) {
    $.post("https://zb-gemeentehuis/krijgJob", JSON.stringify({
        baan: baan
    }));
    afsluiten();
}