 var userToolbar = {
  init: function() {
     $('#user-toolbar').toolbar({
      content: '#user-toolbar-options', 
      position: 'bottom',
      hideOnClick: true
    });
    $('#user-toolbar-options').remove();
    
    $('#user-toolbar').on('toolbarItemClick',
        function( event ) {
          $(this).addClass();
        }
    );
  }
};