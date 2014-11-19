#= require jquery
#= require jquery_ujs
#= require bootstrap

#= require_tree ./front

#= require ./shared/flash-messages


$ ->
  $('.tooltip_bottom').tooltip(placement: 'bottom')