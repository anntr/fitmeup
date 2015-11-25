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
end
