class CoffeeController < ApplicationController
  before_action :prepare_observers

  def show
    redirect_to VideoCall.instance.link
    @observers.each do |observer|
      observer.did_enter_hangouts request
    end
  end

  private

  def prepare_observers
    @observers = [SlackNotifier.new(join_coffee_url)]
  end
end