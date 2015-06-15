
<app-dispatcher>
  <script>
  'use strict';
    var self = this;


    self.on('mount', function(){

      var RiotControl = {
        _stores: [],
        addStore: function(store) {
          this._stores.push(store);
        }
      };

      ['on','one','off','trigger'].forEach(function(api){
        RiotControl[api] = function() {
          var args = [].slice.call(arguments);
          this._stores.forEach(function(el){
            el[api].apply(null, args);
          });
        };
      });

      //If there is no app object.
      if (!window.app){
        window.app = {};
      }

      //Register the dispatcher with the app.
      window.app.dispatcher = RiotControl;

      //Emit event so everyone can start working.
      var readyEvent = new Event('dispatcher-ready');
      document.dispatchEvent(readyEvent);


    });




  </script>
</app-dispatcher>