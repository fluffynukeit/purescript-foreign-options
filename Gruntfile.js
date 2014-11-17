module.exports = function(grunt) {

  "use strict";

  grunt.initConfig({

    libFiles: [
      "src/**/*.purs",
      "bower_components/purescript-*/src/**/*.purs",
    ],

    clean: ["output"],

    pscMake: ["<%=libFiles%>"],
    dotPsci: ["<%=libFiles%>"],
    docgen: {
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
    }
  }
  );

  grunt.loadNpmTasks("grunt-contrib-clean");
  grunt.loadNpmTasks("grunt-purescript");

  grunt.registerTask("make", ["pscMake", "dotPsci", "docgen"]);
  grunt.registerTask("default", ["make"]);
  grunt.registerTask("examples", ["psc"]);
};

