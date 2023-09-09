class Doctor < ApplicationRecord
  has_many :working_days
  has_many :appointments

  def is_working?(day, start_time, end_time)
    self.working_days.each do | wd | 
      return true if wd.day == day && wd.start_at <= start_time && wd.ends_at >= end_time
    end
    return false
  end

  def is_available?(date, start_time, end_time) # "2023-09-08", 900, 930
    # Check is doctor works this day
    booking_day = date.to_time.strftime("%A").downcase
    return false unless self.is_working?(booking_day, start_time, end_time)
    # Check if doctor has appointments 
    appointments = Appointment.by_doctor_and_date(self.id, date)
    appointments.each do |a|
      return false if (start_time >= a.start_at && start_time < a.ends_at) || (end_time > a.start_at && end_time <= a.ends_at)
    end
    true
  end

  def working_time(day)
    wd = self.working_days.select{ |w| w.day == day}
    wd.map { |w| [w.start_at, w.ends_at]}
  end

  def available_slots(date)
    # Take dayname
    free_slots_day = date.to_time.strftime("%A").downcase
    # Get working time for that day
    day_time_slots = self.working_time(free_slots_day)
    # Get appointments
    appointments = Appointment.by_doctor_and_date( self.id, date).order(start_at: :asc).pluck(:start_at, :ends_at)

    slots = []
    day_time_slots.each do |fsd|
      i = 0
      a = appointments.select { |as| as[1] <= fsd[1] } # filter only appointments that apply to this working slot

      if a.size == 0 
        slots.push([fsd[0], fsd[1]]) # Beacause doctor does not have any appointment
        next
      end
      # Remove appointments from available time
      while i < a.size do
        # Working hours against appointments
        # [900, 1800] vs [[900, 930], [930, 950], [1000, 1030], [1700, 1730]]
        # [900, 1800] vs [[900, 930], [930, 950], [1000, 1030], [1700, 1800]]
        if a[i][0] > fsd[0] 
          slots.push([fsd[0], a[i][0]])
        end
        fsd[0] = a[i][1]
        i = i + 1
      end
      
      slots.push([a[i-1][1], fsd[1]]) if a[i-1][1] < fsd[1] # Final slot

    end
    slots
  end
end
