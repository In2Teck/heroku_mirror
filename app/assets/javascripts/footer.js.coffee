$ ->
  $('footer.pie .modal-links a').click (event)->
    event.preventDefault()
    $div = $('<div>').addClass('reveal-modal').appendTo('body')
    $this = $(this)
    $.get $this.attr('href'), { ajax: true }, (data)->
      $div.empty().html(data)
      .append('<a class="close-reveal-modal">&#215;</a>')
      .reveal()
  
  $('footer.pie .mas select').on 'change', ->
    window.location = $(this).val() unless !$(this).val()
