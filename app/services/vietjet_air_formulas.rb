require "flight_formulas"

class VietjetAirFormulas
  include FlightFormulas

  def format_year_month(date_str)
    date_str.to_date.strftime("%Y/%m")
  end

  def get_selected_price_element(page, round, flight_code, price)
    flight_code_square = page.search("##{round} tr").at("span.airlineVJ:contains('#{flight_code}')")

    return nil unless flight_code_square

    flight_price_selection = nil

    flight_code_square.parent.parent.parent.parent.parent.search(".FaresGrid td").each do |price_selection|
      if price_selection.text.include? format_currency price
        flight_price_selection = price_selection
        break
      end
    end

    flight_price_selection
  end

  def travel_info(selected_price_element)
    selected_price_element.at("input[type='radio']")["value"]
  end

  def format_currency(number)
    number_to_currency(number, delimiter: ",", format: "%n VND", precision: 0)
  end
end
