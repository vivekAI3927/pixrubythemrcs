module StationsHelper

  def tracker_flag(station, user)
    attempt = Attempt.where(user_id: user.id, station_id: station.id).first

    if !attempt.started && !attempt.completed
      return NOT_STARTED
    elsif attempt.started && !attempt.completed
      return STARTED
    elsif attempt.completed
      return COMPLETED
    else
      return ERROR
    end
  end

  def parta_tracker_flag(parta_category, user)
    attempt = Parta::Attempt.find_or_create_by(user_id: user.id, parta_category_id: parta_category.id)

    if !attempt.started && !attempt.completed
      return NOT_STARTED
    elsif attempt.started && !attempt.completed
      return STARTED
    elsif attempt.completed
      return COMPLETED
    else
      return ERROR
    end
  end

end
