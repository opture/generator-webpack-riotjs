define(function(){
	var BlogPost = function(opts){
		if (!opts) opts = {};
		this.id = opts.id || null;
		this.title = opts.title || null;
		this.body = opts.body || null;
		this.userId = opts.userId || null;
		this.getUser = function(callback){
			if (!this.userId) return;
            var xhr = new XMLHttpRequest();

            var requestUrl = 'http://jsonplaceholder.typicode.com/users/' + this.userId;
            //var requestUrl = self.baseurl + '?' + querystring;
            xhr.onreadystatechange = function() {
                if(xhr.readyState === 4 ) {
                    if  (xhr.status === 200 ) {
                        //Callback registered with tag.
                        callback(JSON.parse(xhr.response));

                    } else {
                        console.log('error: ', xhr.status, xhr.response);
                    }

                }
            };

            xhr.open("GET", requestUrl, true);
            xhr.send(null);
            // if (options.type==='GET'){
            //     xhr.send(null);
            // } else if (options.type === 'POST'){
            //     xhr.setRequestHeader('Content-Type', 'application/json');
            //     xhr.send(JSON.stringify(self.query));
            // }
		}
	}
	return BlogPost;
});