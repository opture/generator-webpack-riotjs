
require('stores/blog-store/blog-store.tag');
require('stores/album-store/album-store.tag');
require('functional/app-dispatcher/app-dispatcher.tag');
require('functional/app-router/app-router.tag');

<app>
	<app-dispatcher name="dispatcher"></app-dispatcher>
	<app-router name="router"></app-router>

	<topmenu>
		<btn-group>
	    <btn onpush={switchpage} route="blogs">Blogs</btn>
    		<btn onpush={switchpage} route="albums">Albums</btn>
 		<btn-group>
	</topmenu>


	<stores>
		<blog-store name="blogs"></blog-store>
		<album-store name="blogs" ></album-store>
	</stores>


	<script>
		this.switchpage = function(e){
			var routeTarget = e.target.parentNode.getAttribute('route');
			riot.route(routeTarget);
		}
		this.includePages = function(){
			var initialPages = document.getElementsByTagName('pages')[0].cloneNode(true);
			this.root.appendChild(initialPages);
			document.getElementsByTagName('pages')[0].parentNode.removeChild(document.getElementsByTagName('pages')[0]);
		}
		this.registerWithRouter = function(){
			this.includePages();
			document.addEventListener('router-hello', function(e){
				//If no hash is given, mount the first page.
				if (!window.location.hash){
					//Route to the first page.
					var firstPage = this.root.getElementsByTagName('PAGES')[0].children[0].tagName.toLowerCase();
					riot.route(firstPage);
				}else{
					riot.route.exec(e.detail.router.router);
				}


			});

			var helloRouter = new CustomEvent('hello-router');
			document.dispatchEvent(helloRouter);

		}.bind(this);

		this.on('mount', function(){
			//Register with router.
			setTimeout(this.registerWithRouter, 1)


		});
	</script>
</app>