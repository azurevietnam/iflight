module FlightFormulas
  include ActionView::Helpers::NumberHelper

  def agent
    agent = Mechanize.new
    agent.set_proxy(proxy, ENV["PROXY_PORT"], ENV["PROXY_USERNAME"], ENV["PROXY_PASSWORD"])

    agent
  end

  def proxy
    REDIS.zrange("proxies", 0, -1).first
  end

  def update_proxy_count(proxy)
    REDIS.zincrby("proxies", 1, proxy)
  end

  def round_trip?(round_type)
    round_type == "RT"
  end

  def format_day(date_str)
    date_str.to_date.strftime("%d")
  end

  def format_date_jet(date_str)
    date_str.to_date.strftime("%d/%m/%Y")
  end

  def format_date_vna(date_str)
    date_str.to_date.strftime("%Y-%m-%d")
  end

  def format_month(date_str)
    date_str.to_date.strftime("%Y-%m")
  end

  def number_to_currency_jetstar(number)
    number_to_currency(number, delimiter: ",", format: "VND %n", precision: 0)
  end
end
