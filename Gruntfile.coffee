#This array is created because we need to keep the requires ordered
pokedexJsFiles =
  [
    'src/javascripts/lib/jquery.js',
    'src/javascripts/lib/jquery-ui-1.10.3.custom.js',
    'src/javascripts/lib/underscore.js',
    'src/javascripts/lib/backbone.js',
    'src/javascripts/lib/backbone-relational.js',
    'src/javascripts/lib/backbone-relational-extend.js',
    'src/javascripts/lib/backbone.modelbinder.js',
    'src/javascripts/lib/backbone.wreqr.js',
    'src/javascripts/lib/backbone.babysitter.js',
    'src/javascripts/lib/moment.min.js',
    'src/javascripts/lib/livestamp.min.js',
    'src/javascripts/lib/backbone.marionette.js'
  ]

pokedexExtensionJSFiles = []

deploySharedTasks =
  [
    'clean:distFolder',
    'sass:dist',
    'coffee:dist',
    'eco:dist',
    'htmlmin:dist',
  ]

deployProductionTasks = deploySharedTasks.concat(
  [
    'replace:production',
    'uglify:dist',
    'clean:distFiles',
    'hashres:dist',
    'compress:dist',
    'copy:gzipFilesToDist',
    'clean:gzipFolder',
    'clean:rollbackProduction',
    'aws_s3:backupProduction',
    'aws_s3:production',
  ]
)

deployStagingTasks = deploySharedTasks.concat(
  [
    'replace:staging',
    'uglify:dist',
    'clean:distFiles',
    'hashres:dist',
    'compress:dist',
    'copy:gzipFilesToDist',
    'clean:gzipFolder',
    'clean:rollbackStaging',
    'aws_s3:backupStaging',
    'aws_s3:staging',
  ]
)

devTasks =
  [
    'sass:dev',
    'coffeelint',
    'coffee:dev',
    'eco:dev',
    'uglify:dev',
    'clean:devFiles',
    'copy:indexToDev',
  ]

runTasks =
  [
    'connect:server',
    'watch',
  ]

rollbackStaging=
  [
    'clean:distFolder',
    'copy:stagingRollbackToDist',
    'aws_s3:staging'
  ]

rollbackProduction=
  [
    'clean:distFolder',
    'copy:productionRollbackToDist',
    'aws_s3:production'
  ]

cleanTasks =
  [
    'clean:distFolder',
    'clean:devFolder',
    'clean:rollbackProduction',
    'clean:rollbackStaging',
  ]

module.exports = (grunt) =>

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    uglify:
      dist:
        options:
          banner: "/*! <%= pkg.name %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
          beautify: false
          mangle: true
          preserveComments: false
        files:
          'dist/application.js' : [pokedexJsFiles, pokedexExtensionJSFiles, 'dist/coffeescript-config.js', 'dist/templates.js', 'dist/coffeescript-apps.js']
      dev:
        options: 
          banner: "/*! <%= pkg.name %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
          beautify: true
          mangle: false
          preserveComments: true
        files:
          'dev/application.js'  : [pokedexJsFiles, pokedexExtensionJSFiles, 'dev/coffeescript-config.js', 'dev/templates.js', 'dev/coffeescript-apps.js']

    coffeelint:
      app: ['src/javascripts/backbone/**/*.coffee']
      options:
        force: false
        'no_throwing_strings': {'level': 'ignore'}
        'max_line_length': {'level': 'warn'}

    coffee:
      dist:
        options:
          join: false
        files: [
          'dist/coffeescript-apps.js': 'src/javascripts/backbone/**/*.coffee',
          'dist/coffeescript-config.js': 'src/javascripts/config/**/*.coffee'
        ]
      dev:
        options:
          join: false
        files: [
          'dev/coffeescript-apps.js' : 'src/javascripts/backbone/**/*.coffee',
          'dev/coffeescript-config.js': 'src/javascripts/config/**/*.coffee'
        ]

    eco:
      dist:
        files:
          'dist/templates.js': 'src/javascripts/backbone/**/*.eco'
      dev:
        files:
          'dev/templates.js': 'src/javascripts/backbone/**/*.eco'

    sass:
      dist:
        options:
          style: 'compressed'
        files:
          'dist/application.css': 'src/stylesheets/application.css.scss'
      dev:
        options:
          style: 'expanded'
        files: 
          'dev/application.css' : 'src/stylesheets/application.css.scss'

    csslint:
      strict:
        options:
          import: 2
        src: 'dist/application.css'

    copy:
      distToRollback:
        expand: true
        cwd: 'dist/'
        src: '**'
        dest: 'rollback/'

      stagingRollbackToDist:
        expand: true
        cwd: 'rollback/staging/'
        src: '**'
        dest: 'dist/'

      productionRollbackToDist:
        expand: true
        cwd: 'rollback/production/'
        src: '**'
        dest: 'dist/'

      indexToDev:
        src: 'src/*.html'
        dest: 'dev/index.html'
        flatten: true

      gzipFilesToDist:
        expand: true
        cwd: 'gzips/'
        src: '**'
        dest: 'dist/'
        flatten: true
        filter: 'isFile'

    hashres:
      dist:
        src:
          ['dist/application.css', 'dist/application.js']
        dest:
          'dist/index.html'

    htmlmin:
      options:
        removeComments: true
        collapseWhitespace: true
      dist:
        files:
          'dist/index.html' : 'src/index.html'

    clean:
      distFiles:
        src:[
          'dist/coffeescript-apps.js',
          'dist/coffeescript-config.js',
          'dist/templates.js',
        ]
      devFiles:
        src:[
          'dev/coffeescript-apps.js',
          'dev/coffeescript-config.js',
          'dev/templates.js',
        ]
      distFolder:
        src:[
          'dist/*',
        ]
      devFolder:
        src:[
          'dev/*',
        ]
      rollbackProduction:
        src:[
          'rollback/production/*',
        ]
      rollbackStaging:
        src:[
          'rollback/staging/*',
        ]
      gzipFolder:
        src:[
          'gzips/'
        ]

    compress:
      dist:
        options:
          mode: 'gzip'
        files:[
          {expand: true, src: ["dist/*.application.cache.js"], dest: 'gzips/', ext: '.application.cache.js'},
          {expand: true, src: ["dist/*.application.cache.css"], dest: 'gzips/', ext: '.application.cache.css'},
          {expand: true, src: ["dist/*.html"], dest: 'gzips/', ext: '.html'}
        ]

    replace:
      production:
        src: ['dist/index.html', 'dist/coffeescript-apps.js']
        overwrite: true
        replacements:[
          { from: /pokedexDomain = .*/, to: 'pokedexDomain = "https://api.domain.com/api/v1"' }
          { from: /pokedexApiKey = .*/, to: 'pokedexApiKey = "FbFSdA0is_oHtTVUfT1_kw"' }
          { from: 'ee861b262062f0de12e3', to: 'f56593b7930f439b27e6' }
        ]
      staging:
        src: ['dist/index.html']
        overwrite: true
        replacements:[
          { from: /pokedexDomain = .*/, to: 'pokedexDomain = "http://api.domain-staging.com/api/v1"' }
          { from: /pokedexApiKey = .*/, to: 'pokedexApiKey = "FbFSdA0is_oHtTVUfT1_kw"' }
        ]

    connect:
      server:
        options:
          port: 9001
          base: 'dev'
          hostname: '*'

    watch:
      coffee:
        files: 'src/**/*.coffee'
        tasks: devTasks
        options: 
          livereload: true
      eco:
        files: 'src/**/*.eco'
        tasks: devTasks
        options: 
          livereload: true
      sass:
        files: 'src/**/*.scss'
        tasks: devTasks
        options: 
          livereload: true


  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-eco"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-htmlmin"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-csslint"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-hashres"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-compress"
  grunt.loadNpmTasks "grunt-text-replace"

  grunt.registerTask "default", devTasks
  grunt.registerTask "deploy-staging", deployStagingTasks
  grunt.registerTask "deploy-production", deployProductionTasks
  grunt.registerTask "dev", devTasks
  grunt.registerTask "run", runTasks
  grunt.registerTask "rollback-staging", rollbackStaging
  grunt.registerTask "rollback-production", rollbackProduction
  grunt.registerTask "clean-all", cleanTasks

