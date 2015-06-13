'use strict';
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var yosay = require('yosay');
var path = require('path');
var reqModernizr = 'require(\'modernizr/modernizr.js\');';
var reqRiotGear = 'require(\'riotgear/dist/rg.js\');';
var reqRiotBootstrap = 'require(\'riot-bootstrap/dist/riot-bootstrap.js\');';
module.exports = yeoman.generators.Base.extend({
  prompting: function () {
    var done = this.async();

    // Have Yeoman greet the user.
    this.log(yosay(
      'Welcome to the incomplete but somewhat working ' + chalk.red('WebpackRiot') + ' generator!'
    ));

    var prompts = [{
      name: 'appName',
      message: 'What\'s the name of your app?',
      default: 'WebpackRiotApp'
    },
    {
      name:'includejquery',
      message:'Include jQuery? ',
      default:false,
      type:'confirm'
    },
    {
      name:'includeModernizr',
      message:'Include Modernizr? ',
      default:false,
      type:'confirm'
    },
    {
      name:'includeRiotGear',
      message:'Include Riot gear components? ',
      default:false,
      type:'confirm'
    },
    {
      name:'includeRiotBooststrap',
      message:'Include Riot bootstrap components? ',
      default:false,
      type:'confirm'
    }

    ];

    this.prompt(prompts, function (props) {
      this.props = props;
      // To access props later use this.props.someOption;
      this.appName = props.appName;

      this.includejquery = props.includejquery;
      this.includeModernizr = props.includeModernizr;
      this.includeRiotGear = props.includeRiotGear;
      this.includeRiotBooststrap = props.includeRiotBooststrap;


      this.appPath = path.join(this.appName);
      done();
    }.bind(this));
  },

  writing: function(){

    console.log('appName: ' + this.props.appName);

    this.copy('_package.json', this.appPath + '/package.json', function(file) {
      var manifest =  JSON.parse(file);
      if (!this.includejquery) {
        delete manifest.dependencies['jquery'];
      }
      if (!this.includeRiotGear) {
        delete manifest.dependencies['riotgear'];
        reqRiotGear = '';
      }
      if (!this.includeRiotBooststrap) {
        delete manifest.dependencies['riot-bootstrap'];
        reqRiotBootstrap = '';
      }
      manifest.name = this.appName;

      return JSON.stringify(manifest, null, 2);

    }.bind(this));

    this.copy('_bower.json', this.appPath + '/bower.json', function(file) {
      var manifest =  JSON.parse(file);
      if (!this.includeModernizr) {
        delete manifest.dependencies['modernizr'];
        reqModernizr = '';
      }
      manifest.name = this.appName;
      return JSON.stringify(manifest, null, 2);
    }.bind(this));



    this.fs.copyTpl(
      this.templatePath('_index.js'),
      this.destinationPath(this.appPath + '/app/index.js'),
      { reqModernizr: reqModernizr,reqRiotGear: reqRiotGear,reqRiotBootstrap: reqRiotBootstrap }
    );

    //this.template('_bower.json', this.appPath + '/bower.json');
    this.copy('gitignore', this.appPath + '/.gitignore');
    this.copy('webpack.config.js', this.appPath + '/webpack.config.js');
    this.copy('editorconfig', this.appPath + '/.editorconfig');
    this.copy('jshintrc', this.appPath + '/.jshintrc');
    this.copy('jshintignore', this.appPath + '/.jshintignore');
    this.mkdir(this.appPath + '/styles');
    this.mkdir(this.appPath + '/fonts');
    this.directory('app', this.appPath + '/app');
    this.directory('public', this.appPath + '/public');
  },

  install: function () {
    process.chdir(this.appPath);
    //this.installDependencies();
  }
});
