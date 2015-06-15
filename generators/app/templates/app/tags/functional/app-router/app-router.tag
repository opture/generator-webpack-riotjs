
<app-router>
	<script>
		var self = this;
		self.switchPage = function(page){

				//Require the tag.
				require('pages/' + page + '/' + page);

				//Mount and reference the tag.
				var currentTag = riot.mount(page);
				window.app.currentTag = currentTag[0];

				//Fade in the tag.
				window.app.currentTag.root.style.display='';
				setTimeout(function(){
					window.app.currentTag.root.style.opacity = '1';
				},1);

		}
		self.router =  function(collection){

			//If there is a tag animate out and unmount.
			if(window.app.currentTag){

				//Fade out current page
				window.app.currentTag.root.style.transition = 'all 200ms linear';
				window.app.currentTag.root.style.opacity = '0';

				//Wait as long as the above transition, then unmount.
				setTimeout(function(){
					window.app.currentTag.root.style.display='none';
					window.app.currentTag.unmount(true);
					self.switchPage(collection);
				},200);

			}else{

				//Initial load, display the page requested.
				self.switchPage(collection);
			}
		};


		self.on('mount', function(){

			//Add a function to handle the routes.
			riot.route(function(collection, id, action) {
				self.router(collection, id, action);
			});

			//Listen and reply if anyone is interested in my existance.
			document.addEventListener('hello-router', function(){
				var routerHello = new CustomEvent('router-hello', {detail:{router: self}});
				document.dispatchEvent(routerHello);
			});

		});
	</script>
</app-router>