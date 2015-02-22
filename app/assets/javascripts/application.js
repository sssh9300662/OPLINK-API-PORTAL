//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery_nested_form
//= require chosen-jquery
//= require_self

$(document).ready(function() {
  $("[data-type=data-types-selectable]").each(function(){
    $(this).dataTypeSelectable();
  });
  $(document).on('nested:fieldAdded', function(event){
    event.field.find("[data-type=data-types-selectable]").dataTypeSelectable();
  });
});


$.fn.dataTypeSelectable = function() {
  var selector = $(this);
  var auto_hide = selector.attr("data-autohide");
  auto_hide = (auto_hide == "true" || auto_hide == "" || auto_hide == "null" || !auto_hide);
  var data_type = $(selector.attr("data-to"), selector.parent());
  selector.find("option").each(function(){
    if(auto_hide && $(this).val() == data_type.val()) {
      data_type.hide();
    }
  });
  selector.on("change", function() {
    var v = $(this).val()
    if(v == "Set" || v == "List" || v == "Array" || v == "custom") {
      data_type.show();
      data_type.focus();
      if(v != "custom") {
        data_type.val(v+"[]");
        data_type.selectRange(v.length+1, v.length+1);
      } else {
        data_type.val("");
      }
    } else {
      if(auto_hide) {
        data_type.hide();
      }
      data_type.val(v);
    }
  })
};

$.fn.selectRange = function(start, end) { 
    return this.each(function() { 
        if (this.setSelectionRange) { 
            this.focus(); 
            this.setSelectionRange(start, end); 
        } else if (this. createTextRange) { 
            var range = this.createTextRange(); 
            range.collapse(true); 
            range.moveEnd('character', end); 
            range.moveStart('character', start); 
            range.select(); 
        } 
    }) ; 
};

$(document).ready(function() {
  $('select.chosen').chosen();
});
