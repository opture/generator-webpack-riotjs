<base-ajax-json>

    <!-- Makes ajax calls and handles the json for the ajax call.
        Triggers event when ajax is received.
        Can be supplied a callback instead.
        @attr {function}    onsuccess - A callback that receives the payload of a returned ajax request.
        @attr {string}      baseurl - A string defining the base url with or without querystring.
        @attr {string}      type - "POST", "GET", "PUT", "DELETE"
        @attr {object}      query - a key value pair object that defines the query.
                            {query: 'shoes',fromdate:'2015-06-05' } => {baseurl}?query=shoes&fromdate=2015-06-05
    -->
    <script>
        var self = this;

        self.onsuccess = opts.onsuccess || null;
        self.onerror = opts.onerror || null;
        self.type = opts.type || 'GET';
        self.baseurl  = opts.baseurl || null;
        self.query = opts.query || null;

        //"Listen" for observable event.
        this.on('go', function(payload, onsuccess, onerror){
            self.go(payload, onsuccess, onerror);
        });

        /** Creates a querystring from object.
         * @return {string}     a encoded uri string.
         */
        this.createQueryString = function(){
            var _queryString = '';
            console.log('create querystring');
            if (!self.query) {return _queryString;}
            for (var property in self.query){
                _queryString += (_queryString.length ? '&' : '') + property + '=' + encodeURIComponent(self.query[property]);
            }
            console.log(_queryString);
            return _queryString;
        }

        /** Makes the actual ajax call and listens for the returning call.
         * Calls proper callbacks if defined.
         * */
        this.go = function() {
            onsuccess = self.onsuccess;
            onerror = self.onerror;

            xhr = new XMLHttpRequest()

            var querystring = self.createQueryString();
            var requestUrl = querystring.length > 0 ? self.baseurl + (self.baseurl.indexOf('?') > 0 ? '' : '?') + querystring : self.baseurl
            //var requestUrl = self.baseurl + '?' + querystring;
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 ) {
                    if  (xhr.status == 200 || xhr.status == 0) {
                        var successevent = new CustomEvent('response-success',
                            {
                                detail:JSON.parse(xhr.response)
                            });
                        self.root.dispatchEvent(successevent);
                        onsuccess(JSON.parse(xhr.response));
                    } else {
                        onerror(xhr.status, xhr.response);
                    }

                }
            }

            xhr.open(self.type.toUpperCase(), requestUrl, true);

            if (self.type=='GET'){
                xhr.send(null);
            } else if (self.type == 'POST'){
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.send(JSON.stringify(query));
            }

        }

        this.on('mount', function(){
            //Add dom eventlistner to the root element.
            //self.root.addEventListener('go', self.go);
            self.root.go = self.go;
        });
        this.on('unmount', function(){
            //self.root.removeEventListener('go', self.go);

        });

    </script>
</base-ajax-json>