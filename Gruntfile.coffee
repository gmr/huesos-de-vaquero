gruntFunction = (grunt) ->

  appName    = "huesos"
  staticDir  = "static/"
  fontsDir   = "#{staticDir}/fonts/"
  imagesDir  = "#{staticDir}/images/"
  scriptsDir = "#{staticDir}/scripts/"
  stylesDir  = "#{staticDir}/styles/"
  wskDir     = "bower_components/web-starter-kit"

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    checkDependencies:
      this: {}

    clean:
      fonts:   "#{fontsDir}/**"
      images:  "#{imagesDir}/**"
      scripts: "#{scriptsDir}/**"
      styles:  "#{stylesDir}/**"
      dist:    "_rel"

    shell:
      bower:
        command: 'bower install'
        options:
          stdout: true
          stderr: true
          failOnError: true
      rebar_clean:
        command: "bin/rebar clean"
        options:
          stdout: true
          stderr: true
          failOnError: true
      compile:
        command: 'bin/rebar compile'
        options:
          stdout: true
          stderr: true
          failOnError: true
      deps:
        command: "bin/rebar get-deps"
        options:
          stdout: true
          stderr: true
          failOnError: true
      release:
        command: "bin/relx release"
        options:
          stdout: true
          stderr: true
          failOnError: false
      run:
        command: "erl -pa ebin deps/*/ebin -s #{appName}"
        options:
          stdout: true
          stderr: true
          failOnError: true
      wsk_copy_fonts:
        command: "cp -R #{wskDir}/dist/fonts #{fontsDir}"
      wsk_copy_icon:
        command: "cp #{wskDir}/dist/apple-touch-icon-precomposed.png #{staticDir}"
      wsk_copy_images:
        command: "cp -R #{wskDir}/dist/images #{imagesDir}"
      wsk_copy_scripts:
        command: "cp -R #{wskDir}/dist/scripts #{scriptsDir}"
      wsk_copy_styles:
        command: "cp -R #{wskDir}/dist/styles #{stylesDir}"
      wsk_gulp:
        command: "../../node_modules/.bin/gulp"
        options:
          stdout: true
          stderr: true
          failOnError: true
          execOptions:
            cwd: wskDir
      wsk_install:
        command: "npm install"
        options:
          stdout: true
          stderr: true
          failOnError: true
          execOptions:
            cwd: wskDir

  grunt.loadNpmTasks 'grunt-check-dependencies'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-dev-update'
  grunt.loadNpmTasks 'grunt-npm-install'
  grunt.loadNpmTasks 'grunt-shell-spawn'

  grunt.registerTask 'default', ['deps', 'compile']
  grunt.registerTask 'deps',    ['npm-install', 'shell:deps', 'shell:bower', 'shell:wsk_install']
  grunt.registerTask 'compile', ['shell:compile', 'wsk']
  grunt.registerTask 'run',     ['shell:run']
  grunt.registerTask 'release', ['compile']
  grunt.registerTask 'wsk',     ['shell:wsk_gulp', 'shell:wsk_copy_fonts', 'shell:wsk_copy_icon', 'shell:wsk_copy_images', 'shell:wsk_copy_scripts', 'shell:wsk_copy_styles']

module.exports = gruntFunction
