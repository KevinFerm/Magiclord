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

    $( "#character_Class" ).change(function() {
        if(this.value == "tinkerer"){
            $("#secondary_Profession").html('<label for="character_Secondary_Profession">Secondary profession</label><br> <select id="character_Secondary_Profession" name="character[Secondary_Profession]"><option value="cooking">Cooking</option> <option value="fishing">Fishing</option> <option value="enchant">Enchant</option><option value="alchemist">Alchemist</option> <option value="cloth_worker">Cloth Worker</option> <option value="leather_worker">Leather Worker</option> <option value="wood_worker">Wood Worker</option> <option value="metal_worker">Metal Worker</option> <option value="jewel_worker">Jewel Worker</option> <option value="miner">Miner</option> <option value="herbalism">Herbalism</option> <option value="farming">Farming</option> <option value="scribbler">Scribbler</option></select>')
        }
        else{
            $("#secondary_Profession").html("");
        }
    });

});

function log(msg){
    var d = new Date();
    $(".log").append("<p>"+d.getHours()+":"+d.getMinutes()+" Log: "+msg+"</p>");
}