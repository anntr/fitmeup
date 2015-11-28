module MenusHelper

  def index_to_category index
    case index
      when 0
        "śniadanie"
      when 1
        "drugie śniadanie"
      when 2
        "obiad"
      when 3
        "przekąska"
      when 4
        "kolacja"
      else
        ""
    end
  end

  def parse_create_time date
    unless date.dst?
      date += 1.hours
    end
    date.strftime("%m/%d/%Y, %I:%M%p")
  end
end
