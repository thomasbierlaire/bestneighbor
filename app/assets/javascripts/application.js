//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap
//= require bootstrap-datepicker.min
//= require bootstrap-datepicker.fr.min
//= require_tree .

function main(){
$('.date').datepicker({
    format: "yyyymmdd",
    weekStart: 1,
    language: "fr",
    autoclose: true,
    todayHighlight: true
});
}

$(document).ready(main);
