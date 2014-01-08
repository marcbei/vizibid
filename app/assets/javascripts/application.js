// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require s3_direct_upload

 // Sets up the stars to match the data when the page is loaded.
$(function () {
    var checkedId = $('form.rating_ballot > input:checked').attr('id');
    $('form.rating_ballot > label[for=' + checkedId + ']').prevAll().andSelf().addClass('bright');
});

//$(#)

$(document).ready(function() {
    // Makes stars glow on hover.
    $('form.rating_ballot > label').hover(
        function() {    // mouseover
            $(this).prevAll().andSelf().addClass('glow');
        },function() {  // mouseout
            $(this).siblings().andSelf().removeClass('glow');
    });

    // Makes stars stay glowing after click.
    $('form.rating_ballot > label').click(function() {
        $(this).siblings().removeClass("bright");
        $(this).prevAll().andSelf().addClass("bright");
    });

    // Submits the form (saves data) after user makes a change.
    $('form.rating_ballot').change(function() {
        $('form.rating_ballot').submit();
    });

    // activates tooltips
    if ($("[rel=tooltip]").length) {
        $("[rel=tooltip]").tooltip();
     }

     // sets the selected navlist <a/> to active and clears the siblings
    $('ul.nav.nav-list li a').click(function() {           
        $(this).parent().addClass('active').siblings().removeClass('active');           
    });

    // sets the selected nav pils item to active
    $('ul.nav.nav-pills li a').click(function() {           
        $(this).parent().addClass('active').siblings().removeClass('active');           
    });

    $('.uploadform').hide();
    $('.upload').attr('checked', false);

    $('.upload').click (function() {
       $('.uploadform').toggle();
    })

    $('div').delegate("a.follow-button-following", "mouseover" ,function(){
        $('.follow-button-following').html("Unfollow");
        $('.follow-button-following').css("color", "black");
    });

    $('div').delegate("a.follow-button-following", "mouseout", function(){
        $('.follow-button-following').html("Following");
        $('.follow-button-following').css("color", "white");
    });

    $('.disabled').click(function(event){
        event.preventDefault();
      });
});