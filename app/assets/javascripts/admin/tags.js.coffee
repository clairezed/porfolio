class @Tags

  @init = ->
    console.log 'hey'
    $("[data-tags]").on 'click', ->
      console.log $(@).data('tags')
      console.log $("#tag_title").val()
      $.ajax $(@).data("path"),
        data:
          tag_title: $("#tag_title").val(),
          project_id: $(@).data('tags')
        type: "put",
        dataType: "html",
        success: (html) ->
          $("[data-tags]").append(html)
        error: ->
          alert("Une erreur est intervenue")

