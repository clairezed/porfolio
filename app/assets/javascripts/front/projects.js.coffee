class @Projects

  @init = ->
    $container = $("[data-container]")
    $header = $("[data-toggle]")
    $body = $("[data-settings-body]")


    console.log "hey"
    $header.on "click", ->
      console.log "click"
      console.log $(@).data('toggle')
      if $(@).data('toggle') is 'close'
        toggleOpen()
      else
        toggleClose()


    toggleOpen = ->
      console.log "toggle open"
      $container
        .addClass('open-setting')
        .removeClass('close-setting')
      $header.data('toggle', 'open')
      # $container.width('100%')
      # $body.slideDown()
  #       $("span").each(function(index) {
  #     $(this).delay(400*index).fadeIn(300);
  # });

    toggleClose = ->
      console.log "toggle close"
      $container
        .addClass('close-setting')
        .removeClass('open-setting')
      # $body.slideUp()
      # $container.width('10%')
      $header.data('toggle', 'close')