Huesos de Vaquero
=================
A skeleton project for writing Erlang web applications using  [Cowboy](https://github.com/ninenines/cowboy),
using Google [Web Starter Kit](https://github.com/google/web-starter-kit) and
[Grunt](http://gruntjs.com/) for building and [Bower](http://bower.io/) for
front-end dependency management.

[erlydtl](https://github.com/erlydtl/erlydtl) is included and used for templating,
templates compiling as part of the ``grunt compile`` step using the rebar erlydtl
compilation plugin.

For the Erlang parts of the project, [rebar](https://github.com/basho/rebar) is
used for dependency management and building, and [relx](https://github.com/erlware/relx)
is used for release management.

**Note**: This is mainly to demonstrate how to get a working Cowboy app going, serving
templated HTML while using modern front-end tools. At best, you should use it to
figure out how these things are connected and how to get an app up and going. It
was not intended to be a *supported* framework for development. That being said
if you find errors or problems, please [open an issue](https://github.com/gmr/huesos-de-vaquero/issues).

Development Setup
-----------------
[Grunt](http://gruntjs.com/) is used for building in the development environment.
To get started using grunt, make sure that
[nodejs](https://github.com/joyent/node/wiki/installing-node.js-via-package-manager)
is installed.

Because[Web Starter Kit](https://github.com/google/web-starter-kit) uses SASS for
CSS, you'll need to [work through that installation](http://sass-lang.com/install) as well.

Setup Steps:

```bash
# Ensure that sass is installed for Google Web Starter Kit
sudo gem install sass

# Ensure that grunt and it's cli runner are installed in the global scope
npm install -g grunt grunt-cli bower

# Install initial JavaScript project dependencies
npm install

# Install erlang dependencies
grunt deps
```

Compile the app and Google Web Starter Kit
------------------------------------------
```bash
# Just use the default grunt action
grunt compile

# Run the application
grunt run
```

With the application running, you chould be able to access it at
[http://localhost:8080](http://localhost:8080).

Finally to create the stand-alone release of your application, use ``grunt release`` and
the distribution will be placed under the ``_rel`` directory.

Grunt Commands
--------------
- **clean**: Clean files and folders
- **deps**: Install erlang and javascript dependencies
- **compile**: Compile the application and web-starter-kit code
- **run**: Run the application interatively in the console
- **release**: Build the release distribution
