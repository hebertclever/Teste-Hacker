# Ruby on Rails: COVID-19 Status Daily Report

## Project Specifications

**Read-Only Files**
- spec/*

**Environment**  

- Ruby version: 2.7.1
- Rails version: 6.0.2
- Default Port: 8000

**Commands**
- run: 
```bash
bin/bundle exec rails server --binding 0.0.0.0 --port 8000
```
- install: 
```bash
bin/env_setup && source ~/.rvm/scripts/rvm && rvm --default use 2.7.1 && bin/bundle install
```
- test: 
```bash
RAILS_ENV=test bin/rails db:migrate && RAILS_ENV=test bin/bundle exec rspec
```
    
## Question description

You will need to implement endpoints for displaying COVID-19 report information.

Each report record has the following properties:

* _id_: The unique ID of the report record
* _date_: The date of the report record
* _name_: The infected person's name
* _gender_: The person's gender, where ossible values are `m` (male), `f` (female), or `o` (other)
* _age_: The person's age
* _city_: The person's city of residence
* _state_: The person's state of residence
* _county_: The person's county of residence
* _latitude_: Latitude of the person's location
* _longitude_: Longitude of the person's location
 

Here is a sample JSON for the report record data:

```
{
    "id": 1,
    "date": "2020-05-06",
    "name": "Anna Williams",
    "gender": "f",
    "age": 56,
    "latitude": 30.34494,
    "longitude": -81.683107,
    "city": "Jacksonville",
    "state": "FL",
    "county": "Duval"
}
```
 

The REST service should implement the following functionalities:


`GET /report`:

* returns all report records ordered by `id`
* returns status code 200
* accepts an optional query string parameter, `date_from`, in the format `YYYY-MM-DD`. When this parameter is present, only the records with a date no earlier than `date_from` are returned.
* accepts an optional query string parameter, `date_to`, in the format `YYYY-MM-DD`. When this parameter is present, only the records with a date no later than `date_to` are returned.
* accepts an optional query parameter, `age_from`. When this parameter is present, only the records of people not younger than the specified age are returned.
* accepts an optional query parameter, `age_to`. When this parameter is present, only the records of people not older than the specified age are returned.
* accepts an optional query string parameter, `gender`. When this parameter is present, only the records with the specified gender are returned.
* accepts optional query parameters `latitude`, `longitude`, and `distance` (in kilometers). If all 3 parameters are present, only records that are within the specified distance of the given coordinates are returned.

The current project already has a coordinates distance function implemented: `coordinates_distance`. You can invoke it in the following way:

```
distance = coordinates_distance(latitude1, longitude1, latitude2, longitude2)
```

The function returns the response in kilometers.
