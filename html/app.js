window.addEventListener("message", function (event) {
    if (event.data.action == "display") {
        streetA = event.data.streetA
        value = event.data.value
        streetB = event.data.streetB
        if (streetA === null) {
            $(".streetA").hide();
            $(".compass").hide();
            $(".backgroundbox").hide();
        } else  {
            $('.streetA').html(streetA);
            $(".streetA").show();
            $('.streetB').html(streetB);
            $(".streetB").show();
            $('.compass').html(value);
            $(".compass").show();
            $(".backgroundbox").show();

            if (value  !== undefined) {
                bar = document.getElementsByTagName("svg")[0];
                bar.setAttribute("viewBox", ''+ (value - 90) + ' 0 180 5');
                heading = document.getElementsByTagName("svg")[1];
            }
        }

        $(".ui").fadeIn();
    } else if (event.data.action == "hide") {
        $(".bar").show();
        $(".ui").fadeOut();
    }
});