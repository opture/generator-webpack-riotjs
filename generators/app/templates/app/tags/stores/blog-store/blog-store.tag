require('functional/base-remote-json-collection/base-remote-json-collection.tag');
var BlogPost = require('../../../js/models/blog.js');
<blog-store>
	<base-remote-json-collection name="collection" modelType="{BlogPost}" baseurl="http://jsonplaceholder.typicode.com/posts"></base-remote-json-collection>

	<script>
	var self = this;

		//Listen to event
		self.on('blog-store-init', function(){

			//Trigger event on json-collection.
			self.tags.collection.trigger('init', {}, function(coll){

				//Trigger on dispatcher, and let the app now something wonderful has happend.
			 	window.app.dispatcher.trigger('blog-store-changed', coll);
			});
		});

		//Register with the dispatcher.
		self.registerWithDispatcher = function(e){

		   //Register
			window.app.dispatcher.addStore(self);
			self.dispatcher = window.app.dispatcher;

			//Remove possible eventlistener.
			document.removeEventListener('dispatcher-ready', self.registerWithDispatcher);
	   }


		this.on('mount', function(){
			//Set the modeltype for the collection.
			self.tags.collection.modelType = BlogPost;

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
		this.tags.collection.on('collection-changed', function(e){
			window.app.dispatcher.trigger('blog-store-changed', e.detail.collection);
		});
	</script>
</blog-store>