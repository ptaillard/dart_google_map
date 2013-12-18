var userPanel = {
    init : function() {
      $('#user-panel-button-display').click(function() {
        userPanel.display();
      });
    },
    
    display: function()  {
      $('.icon-arrow-left').switchClass("icon-arrow-left", "icon-arrow-right");
      $('.icon-arrow-right').switchClass( "icon-arrow-right", "icon-arrow-left");
      $('#user-panel').toggle("slide");
    }
};