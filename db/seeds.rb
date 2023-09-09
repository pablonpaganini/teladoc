# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Doctor.destroy_all

Doctor.create!([
  {name: "Pablo"},
  {name: "Jose"},
  {name: "Pedro"}
]);

Patient.create!([
  {name: "Pablo"}
])

WorkingDay.create!([
  {day: "monday", doctor_id: 1, start_at: 900, ends_at: 1800},
  {day: "tuesday", doctor_id: 1, start_at: 900, ends_at: 1800},
  {day: "wednesday", doctor_id: 1, start_at: 900, ends_at: 1800},
  {day: "thursday", doctor_id: 1, start_at: 900, ends_at: 1800},
  {day: "friday", doctor_id: 1, start_at: 900, ends_at: 1800},
  {day: "monday", doctor_id: 2, start_at: 1000, ends_at: 1800},
  {day: "wednesday", doctor_id: 2, start_at: 1000, ends_at: 1800},
  {day: "friday", doctor_id: 2, start_at: 1000, ends_at: 1800},
  {day: "monday", doctor_id: 3, start_at: 900, ends_at: 1200},
  {day: "monday", doctor_id: 3, start_at: 1300, ends_at: 1800},
  {day: "tuesday", doctor_id: 3, start_at: 900, ends_at: 1800},
  {day: "wednesday", doctor_id: 3, start_at: 900, ends_at: 1800},
  {day: "thursday", doctor_id: 3, start_at: 900, ends_at: 1800}
])

Appointment.create!([
  {doctor_id: 1, start_at: 900, ends_at: 930, date: "2023-09-08", patient_id: 1},
  {doctor_id: 1, start_at: 1000, ends_at: 1030, date: "2023-09-08", patient_id: 1},
  {doctor_id: 1, start_at: 1700, ends_at: 1730, date: "2023-09-08", patient_id: 1},
  {doctor_id: 1, start_at: 930, ends_at: 1000, date: "2023-09-07", patient_id: 1},
  {doctor_id: 1, start_at: 1700, ends_at: 1800, date: "2023-09-07", patient_id: 1},
  {doctor_id: 3, start_at: 930, ends_at: 1000, date: "2023-09-11", patient_id: 1},
  {doctor_id: 3, start_at: 1730, ends_at: 1800, date: "2023-09-11", patient_id: 1}
])