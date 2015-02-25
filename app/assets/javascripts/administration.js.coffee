#= require jquery
#= require jquery_ujs
#= require bootstrap

#= require ./lib/summernote.min
#= require ./lib/typeahead.bundle.min

#= require_tree ./admin

#= require ./shared/flash-messages

$ ->
  $('.tooltip_bottom').tooltip(placement: 'bottom')

  $('.summernote').summernote(
    height: 150,
    toolbar: [
      ['style', ['bold', 'italic', 'underline', 'clear']]
      ['font', ['strikethrough']]
      ['fontsize', ['fontsize']]
      ['color', ['color']]
      ['para', ['ul', 'ol', 'paragraph']]
      ['insert', ['link']]
    ]
  )

  $('[data-submit-on-change]').change(-> @form.submit())