class @Tags

  @init = ->
    $("[data-tags]").on 'click', ->
      $.ajax $(@).data("path"),
        data:
          tag_title: $("#tag_title").val(),
          project_id: $(@).data('tags')
        type: "put",
        dataType: "html",
        success: (html) ->
          $("[data-tags='list']").html(html)
          $("#tag_title").val('')
        error: ->
          alert("Une erreur est intervenue")

