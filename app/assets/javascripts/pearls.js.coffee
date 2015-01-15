# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
do_on_target = 'To do</br><select><option value="none">None</option><option value="damage">Damage</option><option value="heal">Heal</option><option value="effect">Effect</option><option value="Trigger">Trigger</option></select>'
target = '<select><option value="none">None</option><option value="target">Target</option><option value="self">Self</option><option value="aoe">Area of Effect</option><option value="team">Team</option></select>'

ep_base = 10;

$ ->
  log('DOM READY!')
  $('#pearl_type').change ->
    switch $(this).val()
      when "target"
        $("#selected").html(do_on_target)
        break
      when "self"
        break
      when "aoe"
        $("#selected").html('Number of Targets<br/><input type="number" id="aoe_num" name="aoe_num" min="2" value="4" max="20"><br/>')
        $("#selected").append(do_on_target)
        break
      when "team"
        break

  $('#aoe_num').change ->
    log($(this).val())
    $("#pearl_ep").val(ep_base - $(this).val())