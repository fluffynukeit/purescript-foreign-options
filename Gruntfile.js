module.exports = function(grunt) {

  "use strict";

  grunt.initConfig({

    libFiles: [
      "src/**/*.purs",
      "bower_components/purescript-*/src/**/*.purs",
    ],

    clean: ["tmp", "output"],

    pscMake: ["<%=libFiles%>"],
    dotPsci: ["<%=libFiles%>"],
    pscDocs: {
        readme: {
            src: "src/**/*.purs",
            dest: "docs/Module.md"
        }
    },

    psc: {
      example: {
        options: { main: "ForeignOptions" , modules: "ForeignOptions"},
        src : ["examples/ForeignOptions.purs", "<%=libFiles%>"],
        dest : "tmp/ForeignOptions.js"
      }
    },

    copy: [
      {
        expand: true,
        cwd: "node_modules",
        src: "**",
        dest: "tmp/node_modules/"
      }
    ],

    execute: {
      exampleTest: {
        src: "tmp/ForeignOptions.js"
      }
    }
  }
  );

  grunt.loadNpmTasks("grunt-contrib-copy");
  grunt.loadNpmTasks("grunt-contrib-clean");
  grunt.loadNpmTasks("grunt-execute")
  grunt.loadNpmTasks("grunt-purescript");

  grunt.registerTask("make", ["pscMake", "dotPsci", "pscDocs"]);
  grunt.registerTask("default", ["clean", "make", "test"]);
  grunt.registerTask("test", ["psc", "copy", "execute"]);
};

