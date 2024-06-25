window.addEventListener('message', function (event) {
    if (event.data.action == "notify") {
        notificatie(event.data.text, event.data.type, event.data.length);
    }
});

// function ShowNotif(data) {
//     var $notification = $('.notification.template').clone();
//     $notification.removeClass('template');
//     $notification.addClass(data.type);
//     $notification.html(data.text);
//     $notification.fadeIn();
//     $('.notif-container').prepend($notification);
//     setTimeout(function() {
//         $.when($notification.fadeOut(1500)).done(function() {
//             $notification.remove()
//         });
//     }, data.length != null ? data.length : 2500);
// }

function notificatie(text, type, length) {
    var typeIcon = "";

    var text = text;
    var type = type;
    var length = length;

    if (length == null) {
        length = 4200;
    }
    
    if(type == null || type == undefined) {
        type = "primary";
    }

    if (type == "success") {
        typeIcon = "fa-check-circle";
    } else if (type == "error") {
        typeIcon = "fa-exclamation-circle";
    } else if (type == "primary") {
        typeIcon = "fa-bell";
    }else{
        typeIcon = "fa-bell";
    }
 



    var $notificatie = $(".notificatie-box.template").clone();
    $notificatie.removeClass("template");
    $notificatie.addClass(type);
    $notificatie.html("<span><i class='fas "+ typeIcon +"'></i></span><span><h1>Melding</h1><p>"+ text +"</p></span>")
    $notificatie.animate({width: "400px"});
    $(".notificaties-wrapper").prepend($notificatie);
    setTimeout(() => {
            $notificatie.animate({
                width: "0px"
            }, function() {
                $notificatie.remove();
            });
    }, length);
}