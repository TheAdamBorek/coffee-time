class CoffeeController < ApplicationController
  before_action :prepare_observers

  def show
    print_headers
    redirect_to VideoCall.instance.link
    @observers.each do |observer|
      observer.did_enter_hangouts
    end
  end

  private

  def print_headers
    puts "### Request's headers"
    request.headers.each do |key, value|
      puts "#{key}: #{value}"
    end
    puts "###"
  end

  def prepare_observers
    @observers = [SlackNotifier.new(join_coffee_url)]
  end
end