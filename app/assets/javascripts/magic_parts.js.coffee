# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  log('DOM READY!')
  $('#magic_part_type').change ->
    switch $(this).val()
      when "target"
        $("#selected").html('<select><option value="target">Target</option><option value="me">Self</option><option value="aoe">Area of Effect</option><option value="team">Team</option></select>')
        break
      when "damage"
        break
      when "effect"
        break
      when "trigger"
        break