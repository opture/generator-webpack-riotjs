# generator-webpack-riotjs
###Description
Provides a ready to run webpack setup with [riotjs](https://muut.com/riotjs/), [babel](https://babeljs.io/) for ES2015 transforms, [autoprefixer](https://github.com/postcss/autoprefixer) for css.

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

### Riot Gear
Riot Gear will be included with all components in one file, not component by component.
For more information on usage of Riot Gear components, please visit their [website](https://riotgear.github.io/)

### Riot Bootstrap
Riot Bootstrap will be included with all components in one file, not component by component.
For more information on usage of Riot Bootstrap components, please visit their [website](http://cognitom.github.io/riot-bootstrap/)

## Suggested workflow


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

