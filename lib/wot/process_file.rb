require 'utilities'
module Wot
  class ProcessFile

    def self.load_data(file_path, preview = false)
      results = CsvMapper.import(file_path) do
        start_at_row 1
        stop_at_row(5) if preview

        [week, direct_confirmed, direct_logged_in, direct_first_battle,    direct_first_upgrade, direct_tank_purchase,
         ads_confirmed, ads_logged_in, ads_first_battle,
         ads_first_upgrade, ads_tank_purchase]
      end

      data = {:ads => [], :direct => []}
      results.each do |line|

        dir_confirmed = line.direct_confirmed.gsub(/ /, '').to_i

        data[:direct] << {:week => line.week,
                          :confirmed => dir_confirmed,
                          :logged_in => self.calculate_number(dir_confirmed, line.direct_logged_in),
                          :first_battle => self.calculate_number(dir_confirmed, line.direct_first_battle),
                          :first_upgrade => self.calculate_number(dir_confirmed, line.direct_first_upgrade),
                          :tank_purchase => self.calculate_number(dir_confirmed, line.direct_tank_purchase)}

        ads_confirmed = line.ads_confirmed.gsub(/ /, '').to_i
        data[:ads] << {:week => line.week,
                       :confirmed => ads_confirmed,
                       :logged_in => self.calculate_number(ads_confirmed, line.ads_logged_in),
                       :first_battle => self.calculate_number(ads_confirmed, line.ads_first_battle),
                       :first_upgrade =>self.calculate_number(ads_confirmed, line.ads_first_upgrade),
                       :tank_purchase =>self.calculate_number(ads_confirmed, line.ads_tank_purchase)}
      end
      data
    end

    def self.create_funnels(records, type = "Direct")
      raise "Error: records empty" if records.empty?
      attrs = {:traffic_type => type}
      records.each do |record|
        attrs.merge!(self.calculate_date(record))
        Funnel.create!(attrs)
      end

    end


    private
    def self.check_week(week)
      {:start => /[0-9][0-9] [a-zA-Z][a-zA-Z][a-zA-Z]/.match(week, 0), :end => /[0-9][0-9] [a-zA-Z][a-zA-Z][a-zA-Z]/.match(week, 1)}
    end

    def self.calculate_number(confirmed, percentage)
      if confirmed && percentage
        percentage = percentage.gsub_percentage
        ((confirmed * percentage)/100).round
      end
    end

    def self.calculate_date(record)

      date_range = self.check_week(record[:week])
      record.delete(:week) if date_range
      record.merge!({:start_date => Date.parse(date_range[:start].to_s),
                     :end_date => Date.parse(date_range[:end].to_s)})
    end


  end
end
