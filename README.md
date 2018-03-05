# About

An application where people can make the raffle for the joking of the secret friend.

## Purpose

This project has with purpose the learning new skills. The project was developed following the lessons of bootcamp in the [OneBitCode](onebitcode.com), with exception of some features that was developed for to conclude the challenges proposed. Follow the features developed for me (challenges):  
* Tests of the Members Controller.
* Send email of warn, in case of to occur erros in the Job of raffle.
* Test in the RaffleService for verify if a member x don't get a member y that get the member x.
* Create modal of confirmation for the campaign delete.

## Prerequisites

* Docker
* Docker Compose

## Getting started

The steps below will help you in the building this project in the development and test environment:

### 1. Clone the Project
```
git clone git@github.com:rivelinojunior/bootcampSFS-secret-friend.git
```

### 2. Building the project with docker/docker-compose
```
  docker-compose up --build
```

### 3. Access the application in your browser
> localhost:3000

## Running the test
```
docker-compose run --rm website bundle exec rspec
```

## Building with the technologies
* Ruby on Rails
* Postgresql
* Docker / Docker Compose
* Rspec
* Sidekiq
* Redis
* Devise
* Materialize

## Credits
* Rivelino Junior - [@rivelinojunior](http://github.com/rivelinojunior)
* Onebitcode - [blog](http://www.onebitcode.com)