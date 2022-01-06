# RAILS IMAGE SALES API

This project aims to implement a rest api involving the following features

* adding and deleting users

* adding and deleting images

* facilitating the exchange of images between 2 users

* User retrieval

key assumptions:

* Users must upload images (no image is without an owner)

* images will be stored as links or hashes (in a real application an image would be BLOBed)

## DEMO

[![Demonstration](http://img.youtube.com/vi/ZRMHZeuGi7E/0.jpg)](http://www.youtube.com/watch?v=ZRMHZeuGi7E "")

## SETUP

To setup the project locally, ensure the code is executed from a unix like shell and the following packages are installed:

- `ruby 2.7`
- `gem`
- `bundler`
- `docker`
- `make`

Once the mentioned packages are installed, run the following command to launch your containers
 * `make setup`
  
this command will launch the main rails app and the postgres server, and run a DB migration script for the server.

## API USAGE

Once the server is up, the following endpoints have been implemented

`GET /image` - list all images

`GET /image/:image_id` - list information about specific image

`POST /image` - create 1 or more images - follow format from post.py 

`DELETE /image/:image_id` - delete a specific image

`GET /user` - list all users

`GET /user/:user_id` - list information about specific user

`POST /user` - create 1 or more users - follow format from post.py 

`DELETE /user/:user_id` - delete a specific user

`GET /property` - list all properties of all images

`GET /property/:name` - list all images with a given property name

`POST /transaction` - execute a transaction between 2 users - see post_transaction.py


## TAKEDOWN

to takedown the project, run `make down`, this will kill all the containers

If you would like to also clean all cached container images on your system (not just from this project), run `make clean` which will delete pretty much all container information stored on your system