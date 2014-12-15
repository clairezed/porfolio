class @Tags

  @init = ->

    # Tag autocomplete --------------------------------------------------------------------------

    $input = $("[data-input='tag_title']")

    tags_engine = new Bloodhound
      name: 'tags'
      datumTokenizer: (d) ->
        Bloodhound.tokenizers.whitespace(d.val)
      queryTokenizer: Bloodhound.tokenizers.whitespace
      remote: "#{$input.data('autocomplete-path')}?val=%QUERY"

    tags_engine.initialize()

    $input.typeahead({
        hint: true
        highlight: true
        minLength: 1
      },{
        name: 'tags'
        displayKey: 'title'
        source: tags_engine.ttAdapter()
      })

    # Ajout d'un tag --------------------------------------------------------------------------
    $input.keydown (e) ->
      if e.keyCode is 13
        e.preventDefault()
        $("[data-add-tags]").click()

    $("[data-add-tags]").on 'click', ->
      $.ajax $(@).data("path"),
        data:
          title: $("#tag_title").val(),
          project_id: $(@).data('add-tags')
        type: "post",
        dataType: "html",
        success: (html) ->
          $("[data-tags='list']").html(html)
          $("#tag_title").val('').focus()
        error: ->
          flash("Erreur", 'danger')

    # Suppression d'un tag ----------------------------------------------------------------------
    $("[data-tags='list']").on 'ajax:success',  "[data-delete-tag]", (e, data, status, xhr)->
      flash("Le tag a bien été supprimé", 'success')
      $("[data-tags='list']").html(data)
      $("#tag_title").val('').focus()



