class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  scope :by_doctor_and_date, -> (doctor_id, date) { select(:id, :start_at, :ends_at).where(doctor_id: doctor_id, date: date) }

  validates :start_at, presence: true, numericality: { only_integer: true }, comparison: { less_than: :ends_at }
  validates :ends_at, presence: true, numericality: { only_integer: true }
  validates :date, presence: true, length: { is: 10 }

end
