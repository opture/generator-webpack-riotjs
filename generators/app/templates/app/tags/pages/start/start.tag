require('./start.css');

<start>
    <div>start page</div>
    <btn onpush={switchpage} route="blogs">Blogs</btn>
    <btn onpush={switchpage} route="albums">Albums</btn>

	<script>
		var self = this;
		self.switchpage = function(e){
			var routeTarget = e.target.parentNode.getAttribute('route');
			riot.route(routeTarget);
		}
		self.on('mount', function(){

		});

	</script>
</start>