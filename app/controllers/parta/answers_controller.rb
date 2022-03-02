class Parta::AnswersController < ApplicationController

  def index
    @answers = Parta::Answer.all
  end

  def show
    @answer = Parta::Answer.find(params[:id])
  end

  def new
    @answer = Parta::Answer.new
  end

  def create
    @answer = Parta::Answer.new(params[:answer])
    if @Parta::Answer.save
      redirect_to @answer, notice: "Successfully created Parta::Answer."
    else
      render :new
    end
  end

  def edit
    @answer = Parta::Answer.find(params[:id])
  end

  def update
    @answer = Parta::Answer.find(params[:id])
    if @Parta::Answer.update_attributes(params[:answer])
      redirect_to @answer, notice: "Successfully updated Parta::Answer."
    else
      render :edit
    end
  end

  def destroy
    @answer = Parta::Answer.find(params[:id])
    @answer.destroy
    redirect_to answers_url, notice: "Successfully destroyed Parta::Answer."
  end
end