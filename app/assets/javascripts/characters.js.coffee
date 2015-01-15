# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  age_str = -1
  age_agi = 2
  age_int = -2
  age_sta = 3

  race_str = 5
  race_agi = 3
  race_int = 4
  race_sta = 3

  class_str = 4
  class_agi = 2
  class_int = -2
  class_sta = 1

  extra_stat = 10

  extra_str = 0
  extra_agi = 0
  extra_int = 0
  extra_sta = 0

  log("DOM is ready")

  update_stat = ->
    log("Update stats")
    $("#stat").html("Stat: #{ extra_stat }")
    $("#str").val(10 + age_str + race_str + class_str + extra_str)
    $("#agi").val(10 + age_agi + race_agi + class_agi + extra_agi)
    $("#int").val(10 + age_int + race_int + class_int + extra_int)
    $("#sta").val(10 + age_sta + race_sta + class_sta + extra_sta)
  do update_stat
  $(".update_stat").click ->
    log("Update extra stat")
    value = parseInt($(this).val())
    if $(this).hasClass("str") and between(extra_str + value,0,10) and between(extra_stat - value,0,10)
      extra_str += value
      extra_stat -= value
    else if $(this).hasClass("agi") and between(extra_agi + value,0,10) and between(extra_stat - value,0,10)
      extra_agi += value
      extra_stat -= value
    else if $(this).hasClass("int") and between(extra_int + value,0,10) and between(extra_stat - value,0,10)
      extra_int += value
      extra_stat -= value
    else if $(this).hasClass("sta") and between(extra_sta + value,0,10) and between(extra_stat - value,0,10)
      extra_sta += value
      extra_stat -= value
    do update_stat

  $("#character_Class").change ->
    log("Selected " + $(this).val())
    if $(this).val() is "tinkerer"
      $("#secondary_Profession").html('<label for="character_Secondary_Profession">Secondary profession</label><br> <select id="character_Secondary_Profession" name="character[Secondary_Profession]"><option value="cooking">Cooking</option> <option value="fishing">Fishing</option> <option value="enchant">Enchant</option><option value="alchemist">Alchemist</option> <option value="cloth_worker">Cloth Worker</option> <option value="leather_worker">Leather Worker</option> <option value="wood_worker">Wood Worker</option> <option value="metal_worker">Metal Worker</option> <option value="jewel_worker">Jewel Worker</option> <option value="miner">Miner</option> <option value="herbalism">Herbalism</option> <option value="farming">Farming</option> <option value="scribbler">Scribbler</option></select>')
    else
      $("#secondary_Profession").html('')
  # Stats of Ages
  $("#character_Age").change ->
    if between($(this).val(),10,17)
      age_str = -1
      age_agi = 2
      age_int = -2
      age_sta = 3
    else if between($(this).val(),18,25)
      age_str = 1
      age_agi = 1
      age_int = 1
      age_sta = 2
    else if between($(this).val(),26,35)
      age_str = 2
      age_agi = 1
      age_int = 1
      age_sta = 1
    else if between($(this).val(),36,50)
      age_str = 1
      age_agi = -1
      age_int = 2
      age_sta = 1
    else if between($(this).val(),51,80)
      age_str = -1
      age_agi = -2
      age_int = 3
      age_sta = -1
    else if between($(this).val(),81,100)
      age_str = -2
      age_agi = -3
      age_int = 4
      age_sta = -2
    do update_stat
  # Stats of races total of 15
  $("#character_Race").change ->
    if $(this).val() is "human"
      race_str = 5
      race_agi = 3
      race_int = 4
      race_sta = 3
    if $(this).val() is "halfling"
      race_str = 2
      race_agi = 5
      race_int = 6
      race_sta = 2
    if $(this).val() is "elf"
      race_str = 2
      race_agi = 5
      race_int = 5
      race_sta = 3
    if $(this).val() is "dwarf"
      race_str = 8
      race_agi = 2
      race_int = 2
      race_sta = 3
    if $(this).val() is "dryad"
      race_str = 3
      race_agi = 2
      race_int = 6
      race_sta = 4
    if $(this).val() is "troll"
      race_str = 7
      race_agi = 2
      race_int = 1
      race_sta = 5
    if $(this).val() is "ogre"
      race_str = 7
      race_agi = 3
      race_int = 2
      race_sta = 3
    do update_stat
  # Stats of classes, total of extra 5
  $("#character_Class").change ->
    if $(this).val() is "warrior"
      class_str = 4
      class_agi = 2
      class_int = -2
      class_sta = 1
    if $(this).val() is "priest"
      class_str = -1
      class_agi = -1
      class_int = 5
      class_sta = 2
    if $(this).val() is "wizard"
      class_str = -2
      class_agi = -1
      class_int = 6
      class_sta = 2
    if $(this).val() is "scholar"
      class_str = 0
      class_agi = -3
      class_int = 6
      class_sta = 2
    if $(this).val() is "merchant"
      class_str = -1
      class_agi = 1
      class_int = 2
      class_sta = 3
    if $(this).val() is "hunter"
      class_str = -1
      class_agi = 3
      class_int = 1
      class_sta = 2
    if $(this).val() is "thief"
      class_str = 1
      class_agi = 1
      class_int = 1
      class_sta = 2
    if $(this).val() is "assasin"
      class_str = 1
      class_agi = 2
      class_int = 1
      class_sta = 1
    if $(this).val() is "tinkerer"
      class_str = 1
      class_agi = 1
      class_int = 2
      class_sta = 1
    do update_stat