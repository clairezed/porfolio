# Ouverture d'un modal et chargement du contenu en ajax
@show_modal = (path, element, params, title) ->
  $modal = $("##{element}")
  $(".loading_content", $modal).show()
  $(".ajax_content", $modal).html('')
  $modal.modal()

  $.ajax
    url: path
    data: params
    type: "get"
    dataType: "html"
    success: (html) ->
      $(".ajax_content", $modal).html(html)
      $(".modal-title", $modal).text(title) if title?
    error: ->
      $(".ajax_content", $modal).html("<p class='alert alert-danger'>Une erreur est survenue.</p>")
    complete: ->
      $(".loading_content", $modal).hide()