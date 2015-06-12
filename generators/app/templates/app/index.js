require('./styles/main.css');
require('./styles/grid.css');
require('modernizr/modernizr.js');
if (!Modernizr.input.placeholder) {
	require('./js/polyfills/placeholder');
}
require('./tags/pages/base-page/base-page');

riot.mount('*');