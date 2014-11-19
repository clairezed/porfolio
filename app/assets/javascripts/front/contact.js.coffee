class @Contact

  @init = ->
    console.log "init !"
    $('.contact_form').on "ajax:success", (e, data, status, xhr) ->
      console.log("success")
      console.log data
    $('.contact_form').on "ajax:error", (event, xhr, error) ->
      if xhr.status is 422
        $("#form").html(xhr.responseText)
      else
        alert("Une erreur technique s'est produite. Veuillez réessayer ultérieurement")


    # $("#new-contact").on "submit", ->
    #   console.log "submit"
    # $("#new-contact").on("ajax:success", (e, data, status, xhr) ->
    #   console.log "success !"
    #   console.log data
    #   # $("[data-ajax='premium']").html(data)
    #   # $("#new_article").append xhr.responseText
    # ).on "ajax:error", (e, xhr, status, error) ->
    #   console.log "error"
    #   console.log xhr
    #   console.log status
    #   console.log error

    # $("[data-tasks='list']").on 'ajax:success',  "[data-delete-task]", (e, data, status, xhr)->
    #   flash("Le task a bien été supprimé", 'success')
    #   $("[data-tasks='list']").html(data)
    #   $("#task_title").val('').focus()