class ExamsController < ApplicationController

  def index
  end

  def new
    stations = []
    # generate random stations as per categories
    anatomy_stations = Category.generate_random_stations("Anatomy", 3)
    stations << anatomy_stations
    communication_stations = Category.generate_random_stations("Communication Skills", 2)
    stations << communication_stations
    critical_stations = Category.generate_random_stations("Critical Care", 3)
    stations << critical_stations
    history_stations = Category.generate_random_stations("History Taking", 3)
    stations << history_stations
    operative_stations = Category.generate_random_stations("Operative Procedures", 2)
    stations << operative_stations
    path_stations = Category.generate_random_stations("Pathology", 1)
    stations << path_stations
    examination_stations = Category.generate_random_stations("Examination", 4)
    stations << examination_stations

    # flatten the arrays and shuffle them up!
    stations = stations.flatten!
    stations = stations.shuffle!

    @exam = Exam.create(user_id: current_user.id, stations: stations, current_station: 0)

    @first_station = Station.find(@exam.stations[@exam.current_station])

    @question_categories = QuestionCategory.all
    @mock_text = MockExamText.last
  end

  def next_station
    begin
      @exam = Exam.find(params[:id])
      if @exam && (@exam.current_station == (@exam.stations.count - 1))
        redirect_to review_exam_path(@exam.id)
      else
        next_station_id = Station.find(@exam.stations[@exam.current_station + 1])
        @exam.current_station += 1
        @exam.save
        redirect_to exam_station_path(@exam.id, next_station_id)
      end
    rescue Exception => e
      "Error #{e}"
    end
    
  end

  def review
    @exam = Exam.find(params[:id])
    @stations = Station.find(@exam.stations)
  end

end
