# generator-webpack-riotjs
### Description
Riotjs webpack template with super simple routing, and a RiotControl based dispatcher.
The template comes as a full project with some collection data fetched from [jsonplaceholder](http://jsonplaceholder.typicode.com/)

Provides a ready to run webpack setup with [riotjs](https://muut.com/riotjs/), [babel](https://babeljs.io/) for ES2015 transforms, and [autoprefixer](https://github.com/postcss/autoprefixer) for css.

Optional references to
[jQuery](http://jquery.com/)
[Modernizr](http://modernizr.com/)
[Riot Bootstrap](http://cognitom.github.io/riot-bootstrap/)
[RiotGear](https://riotgear.github.io/)

### Installation
```bash
npm install -g generator-webpack-riotjs
```
### Usage
```
yo webpack-riotjs
```
It will create a folder with your defined app name. Go into that folder and run:
```
webpack-dev-server
```
Then open your browser at: http://localhost:8080

### App structure
The template adds quite a lot of code, it will be made optional to have all the demo code included later, but for now I use this code in the development of the template, so it will stay.
There are a few things that you need to know:
- To setup the router, just add your page-tags to the ```<pages>```-element in public/index.html (The first page-element will be choosen if no specific route is given)
- Use yo riot-element to add tags, it will include the boilerplate for the dispatcher. 
- Otherwise just hack away, build tags, require tags, and create awesome apps.

### Riot Gear
Riot Gear will be included with all components in one file, not component by component.
For more information on usage of Riot Gear components, please visit their [website](https://riotgear.github.io/)

### Riot Bootstrap
Riot Bootstrap will be included with all components in one file, not component by component.
For more information on usage of Riot Bootstrap components, please visit their [website](http://cognitom.github.io/riot-bootstrap/)

## Suggested workflow
The main idea is to create a setup with webpack that keeps out of the way, much like riotjs doesnt add walls to development.<br>
Still, there are some conventions added to this setup. Hopefully it adds to the joy of development instead of adding barriers.<br>

There is a yeoman generator included to create the boilerplate for tags, and it will create 2 files for each tag, one tag file for your html and javascript, and one file for your css. The tag requires the css so it will only be necessary to include the tag.<br>


### Add a new tag
```
yo riot-element my-new-tag
```
this creates a folder under app/tags/elements/my-new-tag with two file:.

#### my-new-tag.tag
```
require('./my-new-tag.css');

<my-new-tag>
    <div>Hello from <span>The underworld</span></div>

	<script>

		this.on('update', function(){

		});
		this.on('mount', function(){

		});
		this.on('unmount', function(){

		});

	</script>
</my-new-tag>
```

#### my-new-tag.css
```
my-new-tag {
	display:block;
	position:relative;
}
```

Then go to app/index.js and add the following to require your tag.
```
require('./tags/elements/my-new-tag/my-new-tag');
```

Edit public/index.html and add your tag to the page.
```
<body>
...
  <my-new-tag></my-new-tag>
...
</body>
```
and finally on your console
```
webpack-dev-server
```

