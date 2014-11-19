class @Contact

  @init = ->
    console.log "init !"

    $("[data-ajax='contact-form']").on "ajax:success", '.contact_form', (e, data, status, xhr) ->
      $("[data-ajax='contact-form']").html(data)

    $("[data-ajax='contact-form']").on "ajax:error", '.contact_form', (event, xhr, error) ->
      if xhr.status is 422
        $("#form").html(xhr.responseText)
      else
        flash("Erreur", 'danger')