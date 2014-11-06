#= require jquery
#= require jquery_ujs
#= require bootstrap

#= require_tree ./admin

#= require ./shared/flash-messages

$ ->
  $('.tooltip_bottom').tooltip(placement: 'bottom')