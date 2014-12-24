class @Tasks

  @init = ->

    # Task autocomplete --------------------------------------------------------------------------

    $input = $("#task_title")

    tasks_engine = new Bloodhound
      name: 'tasks'
      datumTokenizer: (d) ->
        Bloodhound.tokenizers.whitespace(d.val)
      queryTokenizer: Bloodhound.tokenizers.whitespace
      remote: "#{$input.data('autocomplete-path')}?val=%QUERY"

    tasks_engine.initialize()

    $input.typeahead({
        hint: true
        highlight: true
        minLength: 1
      },{
        name: 'tasks'
        displayKey: 'title'
        source: tasks_engine.ttAdapter()
      })


    #// à la sélection d'un résultat
    #$input.on 'typeahead:selected', (evt, elt) ->
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


    # Ajout d'un task --------------------------------------------------------------------------
    $("#task_title").keydown (e) ->
      if e.keyCode is 13
        e.preventDefault()
        $("[data-add-tasks]").click()


    $("[data-add-tasks]").on 'click', ->
      $.ajax $(@).data("path"),
        data:
          title: $("#task_title").val(),
          project_id: $(@).data('add-tasks')
        type: "post",
        dataType: "html",
        success: (html) ->
          $("[data-tasks='list']").html(html)
          $("#task_title").val('').focus()
        error: ->
          flash("Erreur", 'danger')

 # Changement position d'un task ----------------------------------------------------------------------
    $("[data-tasks='list']").on 'change', "[data-position-task]", ->
      $.ajax $(@).data("path"),
        data:
          position: $(@).val(),
          p_task: $(@).data('add-tasks')
        type: "patch",
        dataType: "html",
        success: (html) ->
          $("[data-tasks='list']").html(html)
        error: ->
          flash("Erreur", 'danger')

    # Suppression d'un task ----------------------------------------------------------------------
    $("[data-tasks='list']").on 'ajax:success',  "[data-delete-task]", (e, data, status, xhr)->
      flash("La tâche a bien été supprimée du projet", 'success')
      $("[data-tasks='list']").html(data)
      $("#task_title").val('').focus()



