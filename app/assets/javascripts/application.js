//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap
//= require bootstrap-datepicker.min
//= require bootstrap-datepicker.fr.min
//= require_tree .

function main(){
$('.date').datepicker({
    format: "dd/mm/yyyy",
    weekStart: 1,
    language: "fr"
});
}

$(document).ready(main);
