/*global module:false*/

module.exports = function(grunt) {

  // grunt.loadNpmTasks('grunt-css');
  // Project configuration.
  grunt.initConfig({
    meta: {
      version: '0.1.0',
      banner: '/*! PROJECT_NAME - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '* http://PROJECT_WEBSITE/\n' +
        '* Copyright (c) <%= grunt.template.today("yyyy") %> ' +
        'YOUR_NAME; Licensed MIT */'
    },
    lint: {
      files: ['grunt.js', 'public/js/**/*.js']
    },
    qunit: {
      files: ['test/**/*.html']
    },
    concat: {
      js: {
        src: ['public/js/jst.js', 'public/js/paper.js', 'public/js/main.js', 'public/js/player.js', 'public/js/sounder.js', 'public/js/renderer.js', 'public/js/routers/*.js', 'public/js/models/*.js', 'public/js/collections/*.js', 'public/js/views/*.js'],
        dest: 'build/js/app.js'
      }
    },
    min: {
      js: {
        src: 'build/js/app.js',
        dest: 'build/js/app.min.js'
      }
    },
    watch: {
      files: '<config:lint.files>',
      tasks: 'lint qunit'
    },
    jshint: {
      options: {
        curly: true,
        eqeqeq: true,
        immed: true,
        latedef: true,
        newcap: true,
        noarg: true,
        sub: true,
        undef: true,
        boss: true,
        eqnull: true,
        browser: true
      },
      globals: {
        jQuery: true
      }
    },
    uglify: {}
  });

  // Default task.
  grunt.registerTask('default', 'concat min');

};
