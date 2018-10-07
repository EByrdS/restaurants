# README

This proyect is a REST API with CRUD operations on restaurants.
This API responds in JSON and ignores the requested format if provided.

Behavior Driven Development is guided with `guard`.
Testing with `rspec`.
Ruby style guide with `rubocop`.

Server running with `rails` as an
[API](https://guides.rubyonrails.org/api_app.html),
using `postgresql-9.5` database.

Deployment App is in [Heroku](https://melp-restaurants.herokuapp.com/)

## Database
Data validation on database-level is austere as its requirements were not
specified.

* Latitude `lat` can't be empty.
* Longitude `lng` can't be empty.
* `local_id` can't be empty and has to be unique.

Validation on Rails::ActiveRecord model will check for the presence of
`lat`, `lng` and `local_id`.
It will also validate that the rating is between 0 and 4 inclusive.

Before the record is saved, a `POINT` is created using `lat` and `lng` if they
were changed. (It will happen on creation aswell as they chage from being empty).

The scope `within` was added to class Restaurant to easier find records within
a certain distance of one point, given in latitude, longitude and distance.

The attributes of the table `restaurants` (and thus the model `Restaurant`) are:
* `id`: **PK**, integer (As default by Rails)
* `rating`: integer
* `local_id`: string, index: true, unique: true
* `name`: string
* `site`: string
* `email`: string
* `phone`: string
* `street`: string
* `city`: string
* `state`: string
* `lat`: float, null: false
* `lng`: float, null: false
* `created_at` datetime, null: false (As default by Rails)
* `updated_at` datetime, null: false (As deault by Rails)
* `lonlat`: st_point, srid: 4326, geographic: true (Datatype provided by PostGIS)

### PostGIS
PostGIS is used to make spatial queries. To use it, an extension on
PostgreSQL is needed. This extension may be created manually or using
the command `rails db:gis:setup` after
the gem `activerecord-postgis-adapter` is installed.

The function `ST_Distance` used to calculate the distance between two points
uses *meters* as the distance unit by default.

### Routes
All responses are in JSON format.

Available routes are:

* `GET /restaurants` will show all available restaurants
* `GET /restaurants/:local_id` will show all the attributes of the restaurat
matching that local\_id.
* `POST /restaurants` will expect parameters named exactly as the restaurant
attributes and create a new restaurant.
* `PATCH/PUT /restaurants/:local_id` will update that restaurant with new data.
Note that the parameter `local_id` in the new data will be ignored
so that attribute will remain unchanged.
* `DELETE /restaurants/:local_id` will delete the restaurant from the database.
* `GET /restaurants/statistics` receives the
parameters: `longitude`, `latitude` and `radius` to return how many restaurants
are in that area, and the average & standard deviation of their ratings.
* The root `/` redirects to `/restaurants`

### Specs
`ffaker` gem is use to create random data for columns like city and email.
This random data is sent to `FactoryBot` to build restaurants using the model
`Restaurant` class.

Controller Specs assert correct response format, and changes in database.

Model Specs assert validity of records.

Routing Specs assert correct matching of url with controller actions.

Request Specs were eliminated as there is no need for complex user flows to assert.

For documentation on specific functionality refer to each spec.

### Details
Each restaurant record will have its own id in this database, as an incrementing integer.
This is used to separate database managing from data itself. This local_id must be unique
and has an index on the table `restaurants`.

`rubocop` is used as the style guide enforcer. All code in master is expected
to compel to its rules as long as Specs are still green.

Database configuration is not in this repo, as specified in the `.gitignore` file.
A local `config/database.yml` file may be required.

#### Known Issues
The column `lonlat` should be eliminated and introduce the attributes `lng`
and `lat` to create that point on each query.

The email should be validated to have a correct format in `Restaurant` class.

The telephone should be validated to have a correct format in `Restaurant` class.

