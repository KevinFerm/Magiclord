/**
 * Created by Denaton on 2014-08-30.
 */
$(document).ready(function() {
    new Dragdealer('just-a-slider1', {
        animationCallback: function(x, y) {
            $('#slide-bar1').text(Math.round(x * 100)+'%');
        }
    });

    new Dragdealer('just-a-slider2', {
        animationCallback: function(x, y) {
            $('#slide-bar2').text(Math.round(x * 100)+'%');
        }
    });

    new Dragdealer('just-a-slider3', {
        animationCallback: function(x, y) {
            $('#slide-bar3').text(Math.round(x * 100)+'%');
        }
    });

    new Dragdealer('just-a-slider4', {
        animationCallback: function(x, y) {
            $('#slide-bar4').text(Math.round(x * 100)+'%');
        }
    });

    new Dragdealer('just-a-slider5', {
        animationCallback: function(x, y) {
            $('#slide-bar5').text(Math.round(x * 100)+'%');
        }
    });

    new Dragdealer('just-a-slider6', {
        animationCallback: function(x, y) {
            $('#slide-bar6').text(Math.round(x * 100)+'%');
        }
    });
});

function log(msg){
    var d = new Date();
    $(".log").append("<br>"+d.getHours()+":"+d.getMinutes()+" Log: "+msg);
    $(".log").scrollTop($(".log")[0].scrollHeight);
}

function between(main,max,min){
    if(main >= max && main <= min){
        return true;
    }
}