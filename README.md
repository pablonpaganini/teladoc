# README

## Install
I'm using
1. Rails 7
1. SQLlite 3
1. Ruby 2.7.2

For instruction of how to install ruby / rails follow this guide 

https://guides.rubyonrails.org/getting_started.html

When rails is installed run this command to create the database
```bash
rails db:migrate
```
Then, run this to populate the database with some registers
```bash
rails db:seed
```

## Running server
Execute this command on the console
```bash
rails s -b 0.0.0.0
```
This command start a http server listening on port 3000

## Api request
CURL is used for all examples 

### (GET) Endpoint to find a doctors working hours
*Request* 
```bash
curl http://localhost:3000/doctors/
```
*Response*
```json
[
  {
    "id":1,
    "name":"Pablo",
    "working_days":[
      {"day":"monday","start_at":900,"ends_at":1800},
      {"day":"tuesday","start_at":900,"ends_at":1800},
      ...
    ],
    ...
  }
]
```
This API provides information about what days and in what time a doctor works
Hours are expressed like number, e.g. 900 is equal to 9am

### (POST) Endpoint to book a doctors open slot
*Request* 
```bash
curl -X POST http://localhost:3000/appointments -H 'Content-Type: application/json' -d '{"doctor_id":1,"date":"2023-09-08","start_at":900,"ends_at":930,"patient_id":1}'
```
```bash
curl -X POST http://localhost:3000/appointments -H 'Content-Type: application/json' -d '{"doctor_id":1,"date":"2023-09-08","start_at":930,"ends_at":950,"patient_id":1}'
```
This API create an appointment. It needs
+ doctor_id (**integer**)
+ date (**string**) format YYYY-MM-DD
+ start_at (**integer**)
* ends_at (**integer**)
+ patient_id (**integer**)

Hours are expressed like number, e.g. 900 is equal to 9am

### (GET) Endpoint to view a doctors availability
Replace :id with the correspondent doctor_id 

*Request* 
```bash
curl http://localhost:3000/doctors/:id/availability?date=2023-09-09
```
*Response*
```json
{
  "date":"2023-09-08",
  "available_slots":[[930,1000],[1030,1720],[1750,1800]]
}
```
This endpoint provides doctor's schedule without appointments for a specific day

Hours are expressed like number, e.g. 900 is equal to 9am

### (DELETE) Endpoint to delete a doctors appointment
Replace :id with the correspondent appointment_id 

*Request* 
```bash
curl -X "DELETE" http://localhost:3000/appointment/:id
```

This endpoint removes an appointment

### (PUT) Endpoint to update a doctors appointment
Replace :id with the correspondent appointment_id 

*Request* 
```bash
curl -X "PUT" http://localhost:3000/appointment/:id -H 'Content-Type: application/json' -d '{"doctor_id":1,"date":"2023-09-08","start_at":1720,"ends_at":1750,"patient_id":1}'
```

This endpoint changes an appointment. It needs
+ doctor_id (**integer**)
+ date (**string**) format YYYY-MM-DD
+ start_at (**integer**)
* ends_at (**integer**)
+ patient_id (**integer**)


## Data Models
```html
Doctor (1) ===========> (N) Appointment
  (1)
  |
  |===============> (N) WorkingDay
``````

