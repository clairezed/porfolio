class @Contact

  @init = ->

    $("[data-ajax='contact-form']").on "ajax:success", '.contact-form', (e, data, status, xhr) ->
      $("[data-ajax='contact-form']").fadeOut ->
        $("[data-ajax='contact-form']").html(data).hide().fadeIn('slow')

    $("[data-ajax='contact-form']").on "ajax:error", '.contact-form', (event, xhr, error) ->
      console.log "error"
      if xhr.status is 422
        $("#form").html(xhr.responseText)
      else
        flash("Erreur", 'danger')