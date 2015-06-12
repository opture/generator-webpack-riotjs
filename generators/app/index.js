'use strict';
var yeoman = require('yeoman-generator');
var chalk = require('chalk');
var yosay = require('yosay');
var path = require('path');

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
    }];

    this.prompt(prompts, function (props) {
      this.props = props;
      // To access props later use this.props.someOption;
      this.appName = props.appName;
      this.appPath = path.join(this.appName);
      done();
    }.bind(this));
  },

  writing: function(){

    console.log('appName: ' + this.props.appName);
    this.template('_package.json', this.appPath + '/package.json');
    this.template('_bower.json', this.appPath + '/bower.json');
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
    this.installDependencies();
  }
});
