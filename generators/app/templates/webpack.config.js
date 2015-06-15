var webpack = require('webpack');

var bower_dir = __dirname + '/bower_components';
var node_dir = __dirname + '/node_modules';
var lib_dir = __dirname + '/app/js/libs';
var styles_dir = __dirname + '/app/styles';


module.exports = {
	entry: './app/index.js',
	output: {
	 path: __dirname + '/public',
	 filename: 'bundle.js'
	},
	plugins: [
		new webpack.ProvidePlugin({
		riot: 'riot',
		'window.riot': 'riot',
		'root.riot': 'riot'
		}),
		new webpack.ProvidePlugin({
		   $: "jquery",
		   jQuery: "jquery",
		   "window.jQuery": "jquery",
		   "root.jQuery": "jquery"
		}),
      new webpack.ResolverPlugin(
          new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
      )
	],
	module: {
	 //Compiles the tags.
	 preLoaders: [
	   { test: /\.tag$/,  loader: 'riotjs-loader', query: { type: 'none' } }
	 ],

	 loaders: [
	   { test: /\.js$/, exclude: /node_modules/, loader: 'babel-loader' },
      { test: /\.css$/, loader: 'style-loader!css-loader!autoprefixer-loader?browsers=last 3 versions' },
      { test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192'}, // inline base64 URLs for <=8k images, direct URLs for the rest
     	{ test: /[\\\/]bower_components[\\\/]modernizr[\\\/]modernizr\.js$/, loader: 'script-loader' }
	 ]
	},
	resolve: {
	 modulesDirectories: ['js', 'bower_components', 'node_modules', 'tags'],
	 extensions: ['', '.js', '.json', '.tag', '.css'],
	 alias:{
	 	'jquery': node_dir + '/jquery/dist/jquery.js'
	 }
	},
	devServer: {
	 contentBase: './public'
	}
};