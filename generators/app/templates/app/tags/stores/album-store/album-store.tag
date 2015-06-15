require('functional/base-remote-json-collection/base-remote-json-collection.tag');
<album-store>
	<base-remote-json-collection name="albumscollection" baseurl="http://jsonplaceholder.typicode.com/albums"></base-remote-json-collection>
	<script>
		var self = this;

		self.on('album-store-init', function(){
			self.tags.albumscollection.trigger('init', {}, function(coll){
				window.app.dispatcher.trigger('album-store-changed', coll);
			});
		});

		//Register with the dispatcher.
		self.registerWithDispatcher = function(){

		   //Register
			window.app.dispatcher.addStore(self);
			self.dispatcher = window.app.dispatcher;

			//Remove possible eventlistener.
			document.removeEventListener('dispatcher-ready', self.registerWithDispatcher);
	   }

		this.on('mount', function(){
			self.coll = self.tags.albumscollection;

			//Check if dispatcher is ready.
			if (window.app.dispatcher) {

			  //If appDispatcher is ready then register
			  self.registerWithDispatcher();
			} else {

			  //AppDispatcher not ready yet, register event and wait for it to be ready.
			  document.addEventListener('dispatcher-ready', self.registerWithDispatcher);
			}
		});

		//Listen for a collection change on the remote collection.
		this.tags.albumscollection.on('collection-changed', function(e){
			window.app.dispatcher.trigger('album-store-changed', e.detail.collection);
		});
	</script>

</album-store>