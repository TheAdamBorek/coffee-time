class CoffeeController < ApplicationController
  before_action :prepare_observers

  def show
    redirect_to 'https://hangouts.google.com/call/sEYjJ1cpc3dPStmRl8gqAEEI'
    @observers.each do |observer|
      observer.did_enter_hangouts
    end
  end

  private
  def prepare_observers
    @observers = [SlackNotifier.new]
  end
end