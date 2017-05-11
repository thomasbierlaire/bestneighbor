//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap
//= require_tree .

function main(){
  $('.banner').hide();
  $('.banner').fadeIn(300);
}

$(document).ready(main);
