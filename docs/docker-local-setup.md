# Docker Local Setup

**Contents:**
- [Background](#background)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Setup](#setup)
- [Setup - locally FOR docker](#setup-locally-for-docker)
- [Setup - locally WITHOUT docker](#setup-locally-without-docker)
- [Stopping docker](#stopping-docker)
- [Database creation](#database-creation)
- [Database seeding](#database-seeding)
- [How to run the test suite](#how-to-run-the-test-suite)

## Background

In order to run locally we use Docker for development and testing. This allows new developers, qa's, and intereted parties to setup with minimial knowledge of the configuration and should allow operation of `Homey Test` application to be run on various OS's (Windows, Linux, MacOS).

The primary benefit of this is onboarding support should be related to docker and setup, vs various differences that typically exist when individuals choose an OS/Version that has not been tested with the application. It should reduce instances of `works on my machine`

## Prerequisites

The only prerequisite is that Docker is installed on your machine. It can be downloaded and installed from [Docker](https://docs.docker.com/get-docker/)

N.B. Choose the OS of the machine that you want to install for, and follow the details in the docker documentation. Make sure if you are on a Apple Mac that you choose the correct architecture (new macs will use Apple Silicon)

## Configuration

N.B. The project is configured to run on your `local machine` on `port 3025`.
This is to reduce the chance of conflicts with other local projects.

How to change the entry back to the default of `localhost:3000` in the [docker-compose.yml](../docker-compose.yml)

```bash
services:
  web:
    build: .
    ports:
      - 3025:3000  <---- alter the LHS (3025) entry as that represents the outside world

```

## Setup

Detail instructions for setup can be found here. If you do not wish to use docker then run the standard Rails 7 setup here [Setup - locally WITHOUT Docker]():

### Setup - locally FOR docker

The next subsections - Build everything, About the run script and then Database Creation describe in depth how to setup Homey Test to run in a dockerised local environment.

#### Build everything

1. Build the project locally
```bash
docker compose up --build
```

2. Setup the initial database

From another terminal window/tab run the following command. The assumption is that Step 1 completed successfully. Or is logging output to the terminal window

```bash
./run rails db:setup
```

    #TODO: Enhance with ideals from David Copeland's excellent book [Sustainable Web Development with Ruby on Rails](https://sustainable-rails.com/) around setup

3. Run the server via one of several options, two are provided here

In Step 1 `up` was passed to the `docker compose` command, all going well the docker container was built from the `Docker` image in the project and the container is now up and running.
If it is not there are two options:

- `docker-compose up`

optionally run with `-d` to run in detached mode, but no logs will be presented

- `./run rails s`  optionally pass a port option with `-p <port number to use locally>`


#### Stopping docker

To stop the containers running that have been setup run
```bash
  docker-compose stop  -- just stops the containers
  docker-compose down  -- stops and removes the containers
```


#### About the `run` script

This is found in the root folder and is a modified version of that written by Nick Janetakis and provided as part of his esbuild/Node focused [rails docker starter project](https://github.com/nickjj/docker-rails-example).

He suggest alising `./run` in your shell so one can simply type `run` vs `./run help`

Help is available by running `./run help`.

    #FIXME: Clean up know issues with run script - e.g. shell function defaults to bash not Alpine Linux ash


### Setup - locally WITHOUT docker

- Clone this repository
- `bin/setup`
- `rails s -p 3025`
- visit [http://localhost:3000](http://localhost:3025)


## Database creation

The project can be setup with the docker compose/run script cmd below

```bash
  ./run cmd bin/setup`
```

## Database seeding

N/A

## How to run the test suite

To run the specs - RSpec is the testing tool - the following two ways can be used to run the specs when using the docker setup locally

 - from the command line on local machine
```bash
  ./run cmd bundle exec rspec
```

or

- from within a running Alpine docker container

  ```bash
  ./run cmd ash
  bundle exec rspec
  ```

N.B the docker container needs to be up and running.

## Quirks/Learnings/Note(s) (to future self 👨‍💻)

Doing this task I started by developing in Docker - my preferred environment.
I do this for a couple of reasons:
  - so as not to polute my machine (👀 at you Node JS)
  - to reduce the instances of `it doesn't work on my machine` due to environmental/setup differences

### Tailwind CSS with SimpleForm

This was a bit of a steep learning curve, initially the workaround was as follows:
- clone the `simple_form_tailwind_css`
- modify the relevant files
- figure out how to reference code that had all the `utility classes`. Needed to prevent references
  in the browser html code but missing styles upon inspection. This occurs when the `tree-shaking` 
  to purge the 10_000's of utility classes that are not used runs.
  It was complicated at first I thought by using Docker containers. After several fruitless hours on Friday afternoon I gave in. On the weekend I installed all the code necessary locally to have a functioning environment. LSS (Long Story Short 🫤) it turned out that the same issue existed.
  Not having used Tailwind CSS before I had to do some fast reading.
  It took most of a weekend to fix various issues then take them back to Docker environment to determine how to fix under containers. Learnt lots on the way.

  How to locate the tailwind exe - gems are stored in the docker volumes and mapped in the compose file
  `- gem_cache_homey_project_tracker:/gems`

#### How to compile / generate `./app/assets/builds/tailwind.css`
  1. use the run script to run the command in the container
  ```bash
  ./run cmd ash
  ```
  N.B. it's `ash` not bash/zsh/sh as the images are `Alpine Linux`

  2. confirm the location of the `exe`
  ```bash
  / # ls -lrt /gems/ruby/3.2.0/gems/tailwindcss-rails-2.0.29-x86_64-linux/exe/x86_64-linux/
  total 41116
  -rwxr-xr-x    1 root     root      42094864 Jun 15 09:48 tailwindcss
  ```

  3. run the command to read the relevant files and generate the output file via the build process
  ```bash
  /usr/src/app # /gems/ruby/3.2.0/gems/tailwindcss-rails-2.0.29-x86_64-linux/exe/x86_64-linux/tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/tailwind.css -c ./config/tailwind
  .config.js

  Rebuilding...

  Done in 356ms.
  ```
  N.B. Tailwind has various OS flavoured exe's so if on Mac OSX (intel or arm64) the gem will be different from above. This is well documented in the [tailwindcss-rails gem README](https://github.com/rails/tailwindcss-rails#using-a-local-installation-of-tailwindcss)

  The [simple_form_tailwind_css README section on `Tailwind JIT configuration`](https://github.com/abevoelker/simple_form_tailwind_css#tailwind-jit-configuration) lead me to believe that I should quickly be able to get all my styles so I could produce a [styled form and messages form as per these two images](https://github.com/abevoelker/simple_form_tailwind_css#default). How wrong was I given I had not worked with this before.

  The above - or so I thought - certainly the screens were telling me that!

  ![Aspirational new project form with errors preview](/docs/images/actual-form-with-errors.png?raw=true)

  vs.

  ![](/docs/images/aspirational-new-project-with-errors-form.png?raw=true)

  4. make sure all files containing `tailwind` entries are included in `tailwind.config.js`
