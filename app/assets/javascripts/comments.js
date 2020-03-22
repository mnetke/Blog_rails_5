
extend: function(){
    var me = this;

    $("#" + me.widgetId).addClass("loading-mask");

    $.ajax({
      method: "POST",
      url: "//" + me.recordId + "/extend",
      success: function(response){
        $("#" + me.widgetId).removeClass("loading-mask");

        if(response.success){
          window.location.replace("/authorizations?deep_link_action=edit&deep_link_record_id="+response.extended_authorization_id);
        }
        else{
          alert("Error extending");
        }
      },
      failure: function() {
        $("#" + me.widgetId).removeClass("loading-mask");

        alert("Error extending");
      }
    });
  }
