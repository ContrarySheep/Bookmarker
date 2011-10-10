// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready(function() {
  if ($('#submit_image').length) {
    validateLink();
  }
  showInputInstructions();
});

jQuery(function(){
  $(".swappable").hover(
    function(){this.src = this.src.replace("_off","_over");},
    function(){this.src = this.src.replace("_over","_off");
  });
  $('input#collection_name').focusin(function(){
    clearInputInstructions();
  });
  $('input#collection_name').focusout(function(){
    showInputInstructions();
  });
});


function validateLink(){
  submitImageSrc = $('#submit_image').attr('src');
  validSrc = submitImageSrc.replace("fail","pass");
  invalidSrc = submitImageSrc.replace("pass","fail");
  if( !$('#bookmark_link').val() ) {
    $('#submit_image').attr({src:invalidSrc})
  }else{
    $('#submit_image').attr({src:validSrc})
  }
}

function clearInputInstructions(){
  $('label').hide();
}

function showInputInstructions(){
  if( !$('input#collection_name').val() ) {
    $('label').show();
  }
}
