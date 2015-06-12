<base-ajax>
    <b></b>
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
        this.on('go', function(payload, onsuccess, onerror){
            self.go(payload, onsuccess, onerror);
        });

        this.createQueryString = function(){
            var _queryString = ''
            if (!self.query) {return;}
            for (var property in self.query){
                _querystring += _querystring.length ? '&' : '' + property + '=' + encodeURIComponent(self.query[property]);
            }
            return querystring;
        }

        this.go = function(onsuccess, onerror) {
            if (!onsuccess){
                //Set to defaults
                onsuccess = self.onsuccess;
            }
            if (!onerror){
                //Set to defaults
                onsuccess = self.onsuccess;
            }
            var value = oSelect.options[oSelect.selectedIndex].value;
            xhr = new XMLHttpRequest()

            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && (xhr.status == 200 || xhr.status == 0)) {
                    displayOptions(xhr.responseText, oSelect);
                }
            }

            xhr.open(self.type.toUpperCase(), self.baseurl, true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.send(oSelect.name + "=" + value);
        }

    </script>
</base-ajax>