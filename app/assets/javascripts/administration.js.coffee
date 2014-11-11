#= require jquery
#= require jquery_ujs
#= require bootstrap

#= require ./lib/summernote.min
#= require ./lib/typeahead.bundle.min

#= require_tree ./admin

#= require ./shared/flash-messages

$ ->
  $('.tooltip_bottom').tooltip(placement: 'bottom')