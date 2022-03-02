# frozen_string_literal: true

class Admin::SubscriptionsController < Admin::BaseController
  before_action :set_subscription, only: %i[show edit update destroy]

  def index
    @subscriptions = Subscription.paginate(page: nil)
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.create(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: t('controllers.admin.subscriptions.create') }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to @subscription, notice: t('controllers.admin.subscriptions.update') }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to admin_subscriptions_url, notice: t('controllers.admin.subscriptions.destroy') }
      format.json { head :no_content }
    end
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {})
  end
end
