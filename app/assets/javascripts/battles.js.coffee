# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
socket = io('http://88.131.100.93:1337')
$ ->
  socket.on "timer", (data) ->
    $("#timer").html("Timer: " + data + "s")
  socket.on 'msg', (data) ->
    log(data)

  ready = (state, data) ->
    if state
      $("#status_"+data.player).css("background-color","green")
      $("#status_span_"+data.player).html("This player has taken an action")
      if data.player is $(this).data("name")
        $(".action").attr("disabled", true)
    else
      $("#status_"+data.player).css("background-color","red")
      $("#status_span_"+data.player).html("Player is not ready yet")
      if data.player is $(this).data("name")
        $(".action").attr("disabled", false)

  log("DOM Ready")
  $('.button_join').click ->
    $('.button_join').attr("action", "/battles/join?battle_id=1&player_id=1&target_id=" + $('input[name="to_attack"]:checked').val());

  $("#send_attack").click ->
    ready(yes, {player: $(this).data("name")})
    socket.emit('battle',{
      type: 'attack',
      player: $(this).data("name"),
      target: $('input[name="to_attack"]:checked').val(),
      attack: $('input[name="attack"]:checked').val(),
      battle: $(this).data("battle")
    })
  $("#send_dodge").click ->
    log( $(this).data("name") + "has chosen to dodge")
    ready(yes, {player: $(this).data("name")})

  socket.on "battle", (data) ->
    if data.battle is $("#send_attack").data("battle")
      log(data.msg)
      switch data.type
        when "attack chosen"
          ready(yes, data)
        when "activate buttons"
          ready(no, data)
        when "update"
          $.ajax
            url: "http://88.131.100.93:3000/battles"
            dataType: "html"
            error: (jqXHR, textStatus, errorThrown) ->
              $('body').append "AJAX Error: #{textStatus}"
            success: (data, textStatus, jqXHR) ->
              $('#teams').html($(data).find("#teams"))
              $('#attacks').html($(data).find("#attacks"))
              $('#stats_info').html($(data).find("#stats_info"))
        when "died"
          log("died")