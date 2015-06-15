require('./albums.css');
require('elements/album-listitem/album-listitem.tag');
require('elements/loading-spinner/loading-spinner.tag');

<albums>
	<h1>Albums</h1>
	<loading-spinner if={!albums.length}></loading-spinner>
	<album-listitem each={album in albums} album={album}></album-listitem>
	<script>
		var self = this;
		var active = opts.active;
		self.albums = [];

		self.updateView = function(coll){
			self.albums = coll;
			self.update();
		}

		self.registerEvents = function(){
			setTimeout(function(){
				window.app.dispatcher.on('album-store-changed',self.updateView);
				window.app.dispatcher.trigger('album-store-init',self.updateView);
			}, 1);
		};

		self.on('mount', function(){
			//Check if dispatcher is ready.
			if (window.app.dispatcher) {
			  //If appDispatcher is ready then register
			  self.registerEvents();
			} else {
			  //AppDispatcher not ready yet, register event and wait for it to be ready.
			  document.addEventListener('dispatcher-ready', self.registerEvents);
			}

			//self.store = self.tags.albums;
		});
	</script>
</albums>
