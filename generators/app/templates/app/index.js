require('./styles/main.css');
require('./styles/grid.css');
require('./styles/lg.css');
require('modernizr/modernizr.js');
if (!Modernizr.input.placeholder) {
	require('./js/polyfills/placeholder');
}
require('./tags/pages/base-page/base-page');
require('./tags/pages/lg-company-base/lg-company-base');

riot.mount('*');