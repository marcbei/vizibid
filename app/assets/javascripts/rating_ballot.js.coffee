# Sets up the stars to match the data when the page is loaded.
$ ->
  checkedId = $("form.rating_ballot > input:checked").attr("id")
  $("form.rating_ballot > label[for=" + checkedId + "]").prevAll().andSelf().addClass "bright"

$(document).ready ->
  
  # Makes stars glow on hover.
  $("form.rating_ballot > label").hover (-> # mouseover
    $(this).prevAll().andSelf().addClass "glow"
  ), -> # mouseout
    $(this).siblings().andSelf().removeClass "glow"

  
  # Makes stars stay glowing after click.
  $("form.rating_ballot > label").click ->
    $(this).siblings().removeClass "bright"
    $(this).prevAll().andSelf().addClass "bright"

  
  # Submits the form (saves data) after user makes a change.
  $("form.rating_ballot").change ->
    $("form.rating_ballot").submit()