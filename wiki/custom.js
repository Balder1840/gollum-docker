$(document).ready(function () {
  $("#sidebar-content li.sidebar-dir > span.sidebar-dir-title").click(function(){
    $(this).parent().toggleClass("collapsed")
  })
})
