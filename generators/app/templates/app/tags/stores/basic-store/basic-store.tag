require('functional/base-remote-json-collection/base-remote-json-collection.tag');

<basic-store>
    <base-remote-json-collection name="basic-storecollection" success={success} baseurl="http://jsonplaceholder.typicode.com/albums"></base-remote-json-collection>

	<script>
		var self = this;

		//Register with the dispatcher.
		registerWithDispatcher = function(){
		   //Register
			window.app.dispatcher.addStore(self);
			self.dispatcher = window.app.dispatcher;
			//Remove possible eventlistener.
			document.removeEventListener('dispatcher-ready', self.registerWithDispatcher);
	   }

		on('mount', function(){
			//Check if dispatcher is ready.
			if (window.app.dispatcher) {
			  //If appDispatcher is ready then register
			  self.registerWithDispatcher();
			} else {
			  //AppDispatcher not ready yet, register event and wait for it to be ready.
			  document.addEventListener('dispatcher-ready', self.registerWithDispatcher);
			}
		});

	</script>
</basic-store>