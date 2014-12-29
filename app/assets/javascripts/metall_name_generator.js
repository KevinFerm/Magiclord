/**
 * Created by Denaton on 2014-12-28.
 * Template for generating a new metal and other materials, need to be converted to a model and ruby lang
 */
function nameGen(){

    var characters1 = ["b", "c", "d", "f", "g", "h", "i", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"];
    var characters2 = ["a", "e", "o", "u"];
    var characters3 = ["br", "cr", "dr", "fr", "gr", "pr", "str", "tr", "bl", "cl", "fl", "gl", "pl", "sl", "sc", "sk", "sm", "sn", "sp", "st", "sw", "ch", "sh", "th", "wh","kr"];
    var characters4 = ["ae", "ai", "ao", "au", "a", "ay", "ea", "ei", "eo", "eu", "e", "ey", "ua", "ue", "ui", "uo", "u", "uy", "ia", "ie", "iu", "io", "iy", "oa", "oe", "ou", "oi", "o", "oy"];
    var characters5 = ["sium", "cium", "lium", "rium", "trium", "tium", "nese", "nium", "sten"];
    var characters6 = ["ium", "ese", "alt", "um"];


    var random1 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random2 = parseInt(Math.floor((Math.random() * characters2.length)));
    var random3 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random4 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random5 = parseInt(Math.floor((Math.random() * characters5.length)));

    var random6 = parseInt(Math.floor((Math.random() * characters2.length)));
    var random7 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random8 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random9 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random10 = parseInt(Math.floor((Math.random() * characters6.length)));

    var random11 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random12 = parseInt(Math.floor((Math.random() * characters2.length)));
    var random13 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random14 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random15 = parseInt(Math.floor((Math.random() * characters5.length)));

    var random16 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random17 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random18 = parseInt(Math.floor((Math.random() * characters2.length)));
    var random19 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random20 = parseInt(Math.floor((Math.random() * characters6.length)));

    var random21 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random22 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random23 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random24 = parseInt(Math.floor((Math.random() * characters2.length)));
    var random25 = parseInt(Math.floor((Math.random() * characters5.length)));

    var random26 = parseInt(Math.floor((Math.random() * characters2.length)));
    var random27 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random28 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random29 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random30 = parseInt(Math.floor((Math.random() * characters6.length)));

    var random31 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random32 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random33 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random34 = parseInt(Math.floor((Math.random() * characters2.length)));
    var random35 = parseInt(Math.floor((Math.random() * characters6.length)));

    var random36 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random37 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random38 = parseInt(Math.floor((Math.random() * characters2.length)));
    var random39 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random40 = parseInt(Math.floor((Math.random() * characters6.length)));

    var random41 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random42 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random43 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random44 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random45 = parseInt(Math.floor((Math.random() * characters5.length)));

    var random46 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random47 = parseInt(Math.floor((Math.random() * characters1.length)));
    var random48 = parseInt(Math.floor((Math.random() * characters4.length)));
    var random49 = parseInt(Math.floor((Math.random() * characters3.length)));
    var random50 = parseInt(Math.floor((Math.random() * characters6.length)));

    var names = [characters1[random1].charAt(0).toUpperCase() + characters2[random2] + characters3[random3] + characters4[random4] + characters5[random5],
        characters2[random6].charAt(0).toUpperCase() + characters3[random7] + characters4[random8] + characters1[random9] + characters6[random10],
        characters3[random11].charAt(0).toUpperCase() + characters2[random12] + characters1[random13] + characters4[random14] + characters5[random15],
        characters4[random16].charAt(0).toUpperCase() + characters1[random17] + characters2[random18] + characters3[random19] + characters6[random20],
        characters1[random21].charAt(0).toUpperCase() + characters4[random22] + characters3[random23] + characters2[random24] + characters5[random25],
        characters2[random26].charAt(0).toUpperCase() + characters1[random27] + characters4[random28] + characters3[random29] + characters6[random30],
        characters3[random31].charAt(0).toUpperCase() + characters4[random32] + characters1[random33] + characters2[random34] + characters5[random35],
        characters4[random36].charAt(0).toUpperCase() + characters3[random37] + characters2[random38] + characters1[random39] + characters6[random40],
        characters3[random41].charAt(0).toUpperCase() + characters4[random42] + characters1[random43] + characters4[random44] + characters5[random45],
        characters4[random46].charAt(0).toUpperCase() + characters1[random47] + characters4[random48] + characters3[random49] + characters6[random50]];

    var name = names[Match.random() * names.length];
}