Huesos de Vaquero
=================
A skeleton project for writing Erlang web applications using  [Cowboy](https://github.com/ninenines/cowboy),
using Google [Web Starter Kit](https://github.com/google/web-starter-kit) and
[Grunt](http://gruntjs.com/) for building and [Bower](http://bower.io/) for
front-end dependency management.

erlydtl is included and used for templating, templates compiling as part of
the ``grunt compile`` step using the rebar erlydtl compilation plugin.

Development Setup
-----------------
Grunt is used for building in the development environment. To get started using
grunt, make sure that nodejs is installed.

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

Finally to create the stand-alone release of your application, use ``grunt release`` and
the distribution will be placed under the ``_rel`` directory.

Grunt Commands
--------------
- **clean**: Clean files and folders
- **deps**: Install erlang and javascript dependencies
- **compile**: Compile the application and web-starter-kit code
- **run**: Run the application interatively in the console
- **release**: Build the release distribution
