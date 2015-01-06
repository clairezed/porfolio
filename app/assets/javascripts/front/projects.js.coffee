class @Projects

  @init = ->
    $container = $("[data-container]")
    $header = $("[data-toggle]")
    $body = $("[data-settings-body]")

    # Settings block animation
    $header.on "click", (e) ->
      if $(@).parent().hasClass('close-setting')
        toggleOpen()
      else
        toggleClose()


    toggleOpen = ->
      $container
        .addClass('open-setting')
        .removeClass('close-setting')

    toggleClose = ->
      $container
        .addClass('close-setting')
        .removeClass('open-setting')