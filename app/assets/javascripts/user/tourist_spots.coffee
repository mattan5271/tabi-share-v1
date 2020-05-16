# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#tourist_spot_postcode").jpostal({
    postcode : [ "#tourist_spot_postcode" ],
    address  : {
                  "#tourist_spot_prefecture_code" : "%3",
                  "#tourist_spot_address_city"            : "%4",
                  "#tourist_spot_address_street"          : "%5%6%7"
                }
  })

$(document).on 'ready page:load', ->
  $('#tags').tagit()