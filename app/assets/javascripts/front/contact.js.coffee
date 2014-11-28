class @Contact

  @init = ->
    console.log "init !"

    $("[data-ajax='contact-form']").on "ajax:success", '.contact-form', (e, data, status, xhr) ->
      console.log "success"
      $("[data-ajax='contact-form']").html(data)

    $("[data-ajax='contact-form']").on "ajax:error", '.contact-form', (event, xhr, error) ->
      console.log "error"
      if xhr.status is 422
        $("#form").html(xhr.responseText)
      else
        flash("Erreur", 'danger')