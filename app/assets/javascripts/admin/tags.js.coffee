class @Tags

  @init = ->

    $input = $("#tag_title")
    console.log "#{$input.data('autocomplete-path')}?val=%QUERY"

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


    #// à la sélection d'un résultat
    $input.on 'typeahead:selected', (evt, elt) ->
     # console.log(elt)
     # if elt.title
      #  $.ajax
      #    url: $input.data('geocode-path')
      #    data: {val: elt.description}
      #    type: "get"
      #    dataType: "json"
      #    success: (data) ->
      #      $('#user_latitude').val(data[0])
      #      $('#user_longitude').val(data[1])
      #    error: ->
      #      flash("Une erreur est survenue", 'danger')
      #    complete: ->

    $("[data-tags]").on 'click', ->
      $.ajax $(@).data("path"),
        data:
          tag_title: $("#tag_title").val(),
          project_id: $(@).data('tags')
        type: "put",
        dataType: "html",
        success: (html) ->
          $("[data-tags='list']").html(html)
          $("#tag_title").val('').focus()
        error: ->
          alert("Une erreur est intervenue")

    $("[data-delete-tag]").on 'click', (e), ->
      e.preventDefault()
      #$.ajax $(@).data("path"),
      #  data:
      #    p_tag_id: $(@).data('delete-tag')
      #  type: "post",
      #  dataType: "json",
      #  success: (json) ->
      #    console.log json
      #    if json.success
      #      flash("Le tag a bien été supprimé", 'danger')
      #  error: ->
      #    console.log("Une erreur est intervenue")



