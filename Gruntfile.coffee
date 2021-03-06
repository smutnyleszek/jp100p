module.exports = (grunt) ->

    # configuration
    grunt.initConfig(
        pkg: grunt.file.readJSON('package.json')
        svgstore:
            default:
                options:
                    prefix: 'icon-'
                    svg:
                        style: 'width: 0; height: 0; overflow: hidden; position: fixed; visibility: hidden;'
                    formatting:
                        indent_size: 4
                files:
                    '_includes/icons.svg': ['_assets/icons/*.svg']
        responsive_images:
            default:
                options:
                    engine: 'gm'
                    newFilesOnly: false
                    sizes: [
                        {
                            name: 'thumb'
                            rename: false
                            width: 360
                            height: 360
                            aspectRatio: false
                            upscale: true
                            quality: 80
                        }
                        {
                            name: 'thumb-x2'
                            rename: false
                            width: 720
                            height: 720
                            aspectRatio: false
                            upscale: true
                            quality: 80
                        }
                        {
                            name: 'large'
                            rename: false
                            width: 640
                            height: 640
                            aspectRatio: true
                            upscale: true
                            quality: 80
                        }
                        {
                            name: 'large-x2'
                            rename: false
                            width: 1280
                            height: 1280
                            aspectRatio: true
                            upscale: true
                            quality: 80
                        }
                        {
                            name: 'original'
                            rename: false
                            width: '100%'
                            height: '100%'
                            aspectRatio: true
                        }
                    ]
                files: [
                    expand: true
                    cwd: '_assets/images'
                    src: ['**/*.{jpg,gif,png}']
                    custom_dest: 'public/images/{%= path %}/{%= name %}/'
                ]
        compass:
            default:
                options:
                    config: '_assets/config.rb'
                    basePath: '_assets'
        coffee:
            default:
                options:
                    sourceMap: false
                expand: true
                cwd: '_assets/scripts'
                src: ['**/*.coffee']
                dest: 'public/scripts'
                ext: '.js'
        clean:
            images:
                src: ['public/images']
        watch:
            icons:
                options:
                    spawn: false
                    debounceDelay: 250
                files: ['_assets/icons/*.svg']
                tasks: ['svgstore']
            images:
                options:
                    spawn: false
                    debounceDelay: 5000
                files: ['_assets/images/**/*.{jpg,gif,png}']
                tasks: ['clean:images', 'responsive_images']
            styles:
                files: ['_assets/sass/**/*.scss']
                tasks: ['compass']
            scripts:
                files: ['_assets/scripts/**/*.coffee']
                tasks: ['coffee']
    )

    # load tasks
    grunt.loadNpmTasks('grunt-svgstore')
    grunt.loadNpmTasks('grunt-responsive-images')
    grunt.loadNpmTasks('grunt-contrib-compass')
    grunt.loadNpmTasks('grunt-contrib-coffee')
    grunt.loadNpmTasks('grunt-contrib-clean')
    grunt.loadNpmTasks('grunt-contrib-watch')

    # register tasks
    grunt.registerTask('default', ['watch'])
    grunt.registerTask('build', ['svgstore', 'compass', 'coffee', 'clean:images', 'responsive_images'])
