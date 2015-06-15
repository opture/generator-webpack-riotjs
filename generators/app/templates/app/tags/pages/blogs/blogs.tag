require('./blogs.css');
require('elements/blog-listitem/blog-listitem');
require('elements/loading-spinner/loading-spinner.tag');
<blogs>
	<h1>Blog posts</h1>
	<loading-spinner if={!blogs.length}></loading-spinner>

	<blog-listitem each={post in blogs} post={post}></blog-listitem>
	<script>
		var self = this;
		self.blogs = [];

		self.updateView = function(coll){
			self.blogs = coll;
			self.update();
		}

		self.registerEvents = function(){
			setTimeout(function(){
				 	window.app.dispatcher.on('blog-store-changed',self.updateView);
					window.app.dispatcher.trigger('blog-store-init');
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
		});


	</script>
</blogs>
