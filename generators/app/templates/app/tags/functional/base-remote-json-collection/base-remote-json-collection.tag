require('functional/base-ajax-json/base-ajax-json.tag');
<base-remote-json-collection>
    <base-ajax-json name="ajaxElement" query={query}  onsuccess={_success} onerror={_fail} type={type} baseurl={baseurl}></base-ajax-json>
    <script>
    /* global opts */
    'use strict';
        var self = this;
            self._currentPage = 0;
            self.success = opts.success;
            self.fail = opts.fail;
            self.baseurl = opts.baseurl || '';
            self.responseWrapper = opts.responsewrapper || null;
            self.responseItemWrapper = opts.ersponseitemwrapper || null;
            self.idproperty = opts.idproperty || 'id';
            self.decodeResult = opts.decodeResult || null;
            self.collection = {};
            self._collection = [];
            self.modelType = opts.modelType || null;
            self.paging = opts.paging ||  function(){
                return {page:self._currentPage++};
            };

            self.collection = [];

        /** Fetch a collection by ajax and store the collection.
         *
         * */
        self.query = {
            //userId:1
        };

        self._success = function(response){
            console.log('successful');
            response = response.detail || response; //IF it is the custom event we receive then set it to detail, otherwise it is the response.
            var newitems = {};

            var unwrappedItem;
            var unwrappedResponse = self.responseWrapper ? response[self.responseWrapper] : response;

            unwrappedResponse.forEach(function(item){
                //If a itemwrapper property is supplied then get the inner object.
                unwrappedItem = self.responseItemWrapper ? item[self.responseItemWrapper] : item;
                if (self.modelType) {
                    unwrappedItem = new self.modelType(unwrappedItem)
                }

                //Check if it laready is in the collection. this is only to be able to emit a change event.
                if (self.collection[unwrappedItem[self.idproperty]]){
                    //Update item in the collection.
                    console.log('update item');
                }else{
                    //New item for the collection.
                    console.log('add item');
                    self._collection.push(unwrappedItem);
                    newitems[unwrappedItem[self.idproperty]] = unwrappedItem;
                }
                self.collection[unwrappedItem[self.idproperty]] = unwrappedItem;

            });

            //Did we get asuplied callback?
            self.trigger('collection-changed', {detail:{collection:self._collection, newItems: newitems}});
            // if (self.success){
            //     self.success(self._collection,newitems);
            // }

        };

        self._fail = function(status,response){
            console.log('failed');
            self.fail(status, response);
        };

        self.on('init', function(options,callback){
           options = {
                onerror: self._fail,
                type: opts.type || 'GET',
                baseurl : self.baseurl
            };
            //If there already is a collection, return that. The user at least gets something old to watch before the new will appear.
            if (self.collection.length) callback(self.collection);
            self.tags.ajaxElement.trigger('get', options);
        });

        self.on('next-page', function(){
            //should fetch the next page, based on where we are now, from the server.
            console.log('not implemented');
        });

        self.on('re-init', function(){
            //should reload from "page0"
            //still keeping track of last page.
            console.log('not implemented');
        });

        self.on('add-item', function(newItem, callback){
            //Make a ajax post.
            //Add it to the collection.
            //Respond to the
            var options = {
                onsuccess: function(response){
                    self.trigger('item-added', response);
                },
                onerror: self._fail,
                type: opts.type || 'POST',
                baseurl : self.baseurl,
                query: newItem
            };
            self.tags.ajaxElement.trigger('post', options);
        });

        self.on('delete-item', function(newItem, callback){
            //Make a ajax delete.
            //Add it to the collection.
            //Respond to the
            var options = {
                onsuccess: callback,
                onerror: self._fail,
                type: opts.type || 'DELETE',
                baseurl : self.baseurl,
                query: newItem
            };
            self.tags.ajaxElement.trigger('delete', options);
        });

        self.on('update-item', function(newItem, callback){
            //Make a ajax delete.
            //Add it to the collection.
            //Respond to the
            var options = {
                onsuccess: callback,
                onerror: self._fail,
                type: opts.type || 'PUT',
                baseurl : self.baseurl,
                query: newItem
            };
            self.tags.ajaxElement.trigger('put', options);
        });

        self.on('fetch-item', function(itemId, callback){
            //First check the local collection if the value is already present.
            //If so return that.
            //Otherwise fetch it from remote end.
            if (self.collection[itemId]){
                callback(self.collection[itemId]);
                return;
            }

            var options = {
                onsuccess: callback,
                onerror: self._fail,
                type: opts.type || 'PUT',
                baseurl : self.baseurl,
                query: newItem
            };
            self.tags.ajaxElement.trigger('put', options);
        });
    </script>
</base-remote-json-collection>