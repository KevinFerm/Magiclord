/**
 * Created by Denaton on 2014-12-28.
 */
var io = require('socket.io')(1337);
var sqlite3 = require('sqlite3').verbose();
var usersDB = new sqlite3.Database("../../db/development.sqlite3");

max_count = 120;
count = 120; // 2Min world cooldown

setInterval(function(){
    count--;
    if (count <= 0){
        count = max_count;
        player_ai();
        io.sockets.emit('msg',"Ready or not here we go!");
    }
    io.sockets.emit('timer', count);
}, 1000);

io.on('connection', function(socket){
    console.log("User connected");

    socket.on('battle', function (data) {
        if(data.type == 'attack' && data.attack != null && data.target != null){
            var target = data.target.split("_");
            var npc = false;
            if(target[0] == "npc")
                npc = true;
            validate_attack(data.player,parseInt(data.attack),parseInt(target[1]),npc,data.battle);
        }
        else if(data.attack == null || data.target == null){
            io.sockets.emit('battle', {
                type: "activate buttons",
                battle: battle_id,
                msg: 'Invalid target or attack'
            });
        }
    });
});

function validate_attack(user,attack,target,npc,battle){
    console.log("-=Validate Attack=-");
    query = "SELECT pearls.id, characters.FirstName, character_id FROM pearls INNER JOIN items ON items.id=pearls.item_id INNER JOIN inventories ON inventories.id=items.inventory_id INNER JOIN characters ON characters.id=inventories.character_id";
    usersDB.all(query, function(err, char) {
        for(var i = 0; char.length > i; i++) {
            if (char[i].FirstName == user && char[i].id == attack) {
                validate_target(char[i], target, battle, attack, npc);
            }
        }
    });
}

function validate_target(char,target_char ,battle_id,attack_id,npc){
    console.log("-=Validate Target=-");
    usersDB.get("SELECT * FROM battles WHERE id='"+battle_id+"'", function(err, battle) {
        teams = JSON.parse(battle.contestant);
        for(var i = 0; teams.length > i; i++){
            for(var j = 0; teams[i].players.length > j; j++){
                console.log("SET ATTACK");
                console.log(teams[i].players[j]["id"] == char.character_id, !teams[i]["players"][j]["npc"]);
                console.log(teams[i].players[j]["id"], char.character_id, !teams[i]["players"][j]["npc"]);
                if(teams[i].players[j]["id"] == char.character_id && !teams[i]["players"][j]["npc"]){
                    console.log("FIX ATTACK");
                   teams[i].players[j]["attack"]["id"] =  attack_id;
                   teams[i].players[j]["attack"]["target"] = target_char;
                   teams[i].players[j]["attack"]["npc"] = npc;
                    console.log(attack_id,target_char,npc);
                    io.sockets.emit('battle', {
                       type: "attack chosen",
                       battle: battle_id,
                       player: "char_" + char.character_id,
                       msg: char.FirstName + ' has chosen an action'
                   });
               }
            }
        }
        var stringify = JSON.stringify(teams);
        console.log(stringify);
        usersDB.run("UPDATE battles SET contestant = '"+stringify+"' WHERE id = '"+battle_id+"'");
        ai(battle_id);
        ready_check(battle_id);
    });
}

function battle_phase(battle_id){
    console.log("-=Battle Phase=-");
    usersDB.get("SELECT * FROM battles WHERE id='"+battle_id+"'", function(err, battle) {
        teams = JSON.parse(battle.contestant);

        for(var i = 0; teams.length > i; i++){
            for(var j = 0; teams[i].players.length > j; j++){
                player_info = teams[i]["players"][j];
                var typ = "";
                if(player_info["attack"]["npc"])
                    typ = "npcs";
                else
                    typ = "characters";
                damage_from_attack(typ,player_info["attack"]["target"],player_info["attack"]["id"]);
                add_effect(typ,player_info["attack"]["target"],player_info["attack"]["id"]);
            }
        }
        end_phase(battle_id);
    });
}

function end_phase(battle_id){
    console.log("-=End Phase=-");
    usersDB.get("SELECT * FROM battles WHERE id='"+battle_id+"'", function(err, battle) {
        teams = JSON.parse(battle.contestant);
    });
    for(var i = 0; teams.length > i; i++){
        for(var j = 0; teams[i].players.length > j; j++){
            player_info = teams[i]["players"][j];
            var typ = "characters";
            if(player_info["npc"])
                typ = "npcs";
            trigger_effects(typ,player_info["id"],battle_id);
        }
    }
    console.log("New Turn");
    reset_attacks(battle_id);
}

function join_phase(battle_id){

}

function upkeep_phase(battle_id){

}

function reset_attacks(battle_id){
    console.log("-=Reset Attacks=-");
    usersDB.get("SELECT * FROM battles WHERE id='"+battle_id+"'", function(err, battle) {
        teams = JSON.parse(battle.contestant);
        for(var i = 0; teams.length > i; i++){
            console.log("RESET");
            console.log(teams[i]["players"]);
            for(var j = 0; teams[i].players.length > j; j++){
                teams[i].players[j].attack.id =  0;
                teams[i].players[j].attack.target = 0;
                teams[i].players[j].attack.npc = null;
            }
        }
        var stringify = JSON.stringify(teams);
        usersDB.run("UPDATE battles SET contestant = '"+stringify+"' WHERE id = '"+battle_id+"'", function(){
            io.sockets.emit('battle', {
                type: "activate buttons",
                battle: battle_id,
                msg: 'Reset'
            });
            emit_update(battle_id);
        });
    });
}

function ready_check(battle_id){
    console.log("-=Ready Check=-");
    usersDB.get("SELECT * FROM battles WHERE id='"+battle_id+"'", function(err, battle) {
        teams = JSON.parse(battle.contestant);
        for(var i = 0; teams.length > i; i++){
            for(var j = 0; teams[i].players.length > j; j++){
                if(teams[i].players[j].attack.id == 0 && teams[i].players[j].npc == false){
                    return;
                }
            }
        }
        battle_phase(battle_id);
    });
}

function ai(battle_id){
    console.log("-=AI=-");
    usersDB.get("SELECT * FROM battles WHERE id='"+battle_id+"'", function(err, battle) {
        teams = JSON.parse(battle.contestant);
        for(var i = 0; teams.length > i; i++){
            for(var j = 0; teams[i]["players"].length > j; j++){
                if(teams[i]["players"][j]["npc"] == true){
                    var npc = teams[i]["players"][j];
                    var pick_team = i;
                    while(pick_team == i){
                        pick_team = Math.floor(Math.random() * teams.length);
                    }
                    var target_player = Math.floor(Math.random() * teams[pick_team]["players"].length);
                    target_player = teams[pick_team]["players"][target_player];
                    npc["attack"]["target"] = target_player["id"];
                    npc["attack"]["npc"] = target_player["npc"];
                    npc["attack"]["id"] = 1; // Fix this once we have melee system and database in meanwhile they can only cast fireballs!
                    teams[i]["players"][j] = npc;
                }
            }
        }
        var stringify = JSON.stringify(teams);
        console.log(stringify);
        usersDB.run("UPDATE battles SET contestant = '"+stringify+"' WHERE id = '"+battle_id+"'");
        console.log("AI set for npc in battle id:" + battle_id);
    });
}

// Idle or slow players cast on random target with random spell
function player_ai(){
    usersDB.all("SELECT * FROM battles", function(err, battle) {
        for(b = 0; b < battle.length; b++){
            teams = JSON.parse(battle[b].contestant);
            for(var i = 0; teams.length > i; i++){
                for(var j = 0; teams[i]["players"].length > j; j++){
                    if(teams[i]["players"][j]["npc"] == false && teams[i]["players"][j]["attack"]["id"] == 0){
                        var player = teams[i]["players"][j];
                        var pick_team = i;
                        while(pick_team == i){
                            pick_team = Math.floor(Math.random() * teams.length);
                        }
                        var target_player = Math.floor(Math.random() * teams[pick_team]["players"].length);
                        target_player = teams[pick_team]["players"][target_player];

                        player["attack"]["target"] = target_player["id"];
                        player["attack"]["npc"] = target_player["npc"];
                        player["attack"]["id"] = 1; // Fix this once we have melee system and database in meanwhile they can only cast fireballs!
                        io.sockets.emit('battle', {
                            type: "attack chosen",
                            battle: battle[b].id,
                            player: "char_" + player['id'],
                            msg: "A player was to slow and got random target and attack"
                        });
                        teams[i]["players"][j] = player;
                    }
                }
            }
            var stringify = JSON.stringify(teams);
            usersDB.run("UPDATE battles SET contestant = '"+stringify+"' WHERE id = '"+battle[b].id+"'");
            ai(battle[b].id);
            ready_check(battle[b].id);
            console.log("AI set for players in battle id:" + battle[b].id);
        }
    });
}

function emit_update(battle_id){
    io.sockets.emit('battle', {
        type: "update",
        battle: battle_id,
        msg: 'Update Stats'
    });
}

function add_effect(typ,target_id,attack_id){
    console.log("-=Add Effects=-");
    if(target_id != 0 && attack_id != 0) {
        usersDB.get("SELECT * FROM pearls WHERE id='" + attack_id + "'", function (err, attack) {
            effect = JSON.parse(attack.effect);
            if (typeof effect["dot"] != 'undefined') {
                check_effect(typ,target_id,effect);
            }
        });
    }
}

function check_effect(typ,target_id,effect){
    usersDB.get("SELECT * FROM " + typ + " WHERE id='" + target_id + "'", function (err, effect_target) {
        console.log(effect["dot"]["name"]);
        var eff = [];
        if (effect_target.effect != null) {
            eff = JSON.parse(effect_target.effect);
            if(eff.length > 0){
                for (var i = 0; eff.length > i; i++) {
                    if (eff[i][effect["dot"]["name"]] != null) {
                        if (eff[i][effect["dot"]["name"]]["turn"] > 0) {
                            eff[i][effect["dot"]["name"]]["damage"] = effect["dot"]["damage"];
                            eff[i][effect["dot"]["name"]]["turn"] = effect["dot"]["turn"];
                        }
                    }
                }
            }
            else {
                var new_effect = {};
                new_effect[effect["dot"]["name"]] = {
                    "damage": effect["dot"]["damage"],
                    "turn": effect["dot"]["turn"]
                };
                eff.push(new_effect);
            }
        }
        eff = JSON.stringify(eff);
        usersDB.run("UPDATE " + typ + " SET effect = '" + eff + "' WHERE id = '" + target_id + "'");
    });
}

function trigger_effects(typ,player_id){
    console.log("-=Trigger Effects=-");
    usersDB.get("SELECT * FROM " + typ + " WHERE id='" + player_id + "'", function (err, effect_target) {
        var eff = [];
        var remove = [];
        if (effect_target.effect != null) {
            eff = JSON.parse(effect_target.effect);
            for (var i = 0; eff.length > i; i++) {
                for (effect in eff[i]) {
                    console.log("Testing Effects",eff[i][effect]);
                    if (eff[i][effect]["turn"] > 0) {
                        eff[i][effect]["turn"]--;
                        console.log("Effect trigger's and do " + eff[i][effect]["damage"] + " damage to " + typ+"_"+player_id);
                        damage(typ, effect_target, eff[i][effect]["damage"]);
                    }
                    if (eff[i][effect]["turn"] == 0) {
                        remove.push(i);
                    }
                }
            }
            for (var i = 0; remove.length > i; i++) {
                eff.splice(i, 1);
            }
        }
        eff = JSON.stringify(eff);
        usersDB.run("UPDATE " + typ + " SET effect = '" + eff + "' WHERE id = '" + player_id + "'");
    });
}

function damage_from_attack(typ,target_id,attack_id){
    console.log("-=Damage from Attacks=-");
    if(attack_id > 0) {
        usersDB.get("SELECT * FROM " + typ + " WHERE id='" + target_id + "'", function (err, target) {
            usersDB.get("SELECT * FROM pearls WHERE id='" + attack_id + "'", function (err, attack) {
                var effect = JSON.parse(attack.effect);
                damage(typ, target, effect["damage"]);
            });
        });
    }
}

function damage(typ,player,dmg){
    console.log("-=Damage=-");
    console.log("Do " + dmg + " on " + typ +"_" + player.id);
    io.sockets.emit('msg',player.FirstName + " got " + dmg + " damage.");
    var hp = player.Curr_Hp - dmg;
    usersDB.run("UPDATE "+typ+" SET Curr_Hp = '"+hp+"' WHERE id = '"+player.id+"'");
}