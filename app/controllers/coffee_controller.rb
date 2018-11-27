class CoffeeController < ApplicationController
  before_action :prepare_observers

  def show
    redirect_to AppConfig.instance.hangouts_redirect_url
    @observers.each do |observer|
      observer.did_enter_hangouts
    end
  end

  private
  def prepare_observers
    @observers = [SlackNotifier.new(join_coffee_url)]
  end
end