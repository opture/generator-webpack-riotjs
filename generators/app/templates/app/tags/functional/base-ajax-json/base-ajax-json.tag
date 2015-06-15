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
    'use strict';
        var self = this;
        self._onsuccess = opts.onsuccess;

        //"Listen" for observable event.
        // this.on('go', function(payload, onsuccess, onerror){
        //     self.go(payload, onsuccess, onerror);
        // });

        /** Creates a querystring from object.
         * @return {string}     a encoded uri string.
         */
        self.createQueryString = function(){
            var _queryString = '';
            console.log('create querystring');
            if (!self.query) {return _queryString;}
            for (var property in self.query){
                _queryString += (_queryString.length ? '&' : '') + property + '=' + encodeURIComponent(self.query[property]);
            }
            console.log(_queryString);
            return _queryString;
        };


        self.on('get',function(options) {
            self._makerequest(options);
        });

        self.on('post', function(options) {
            self._makerequest(options);
        });
        self.on('put', function(options) {
            self._makerequest(options);
        });
        self.on('delete', function(options) {
            self._makerequest(options);
        });
        self._makerequest = function(options){
            var xhr = new XMLHttpRequest();

            var querystring = self.createQueryString();
            var requestUrl = querystring.length > 0  ? options.baseurl + (options.baseurl.indexOf('?') > 0 ? '' : '?') + querystring : options.baseurl;
            //var requestUrl = self.baseurl + '?' + querystring;
            xhr.onreadystatechange = function() {
                if(xhr.readyState === 4 ) {
                    if  (xhr.status === 200 ) {
                        //Callback registered with tag.
                        self._onsuccess(JSON.parse(xhr.response));
                        //Callback supplied by options.
                        if (options.onsuccess) {options.onsuccess(JSON.parse(xhr.response));}


                    } else {
                        options.onerror(xhr.status, xhr.response);
                    }

                }
            };

            xhr.open(options.type.toUpperCase(), requestUrl, true);

            if (options.type==='GET'){
                xhr.send(null);
            } else if (options.type === 'POST'){
                xhr.setRequestHeader('Content-Type', 'application/json');
                xhr.send(JSON.stringify(self.query));
            }
        };
    </script>
</base-ajax-json>