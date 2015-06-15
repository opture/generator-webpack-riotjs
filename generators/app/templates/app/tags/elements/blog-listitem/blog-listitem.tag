
require('./blog-listitem.css');

<blog-listitem>

	<h4>{post.title}</h4>
	<p>{post.body}</p>
	<b onclick="{loadUser}" style="float:right;">[...]</b>
	<script>
	var self = this;
		post = opts.post;
		this.loadUser = function(e,detail){
			post.getUser(function(user){
				console.log(user);
			});
		}
		this.on('mount', function(){
		});
		this.on('unmount', function(){

		});

	</script>
</blog-listitem>