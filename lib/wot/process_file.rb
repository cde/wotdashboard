module Wot
  class ProcessFile
    def self.get_preview(file)
      
      results = CsvMapper.import(file.to_path) do
        start_at_row 2
        stop_at_row 5
        [number, week, without_confirmed, without_number_logged_in, without_logged_in, empty1, without_first_battle, without_first_upgrade, without_tank_purchase, with_confirmed, with_logged_in, with_first_battle, with_first_upgrade, with_tank_purchase]
      end
      
      data = {:with => [], :without => []}
      results.each do |line|
        line.week = self.check_week(line.week)
        data[:with] << {:number => line.number,:confirmed => line.with_confirmed.gsub(/ /, ','),:logged_in => line.with_logged_in, :first_upgrade => line.with_first_upgrade, :tank_purchase => line.with_tank_purchase, :start_date => line.week[:start], :end_date => line.week[:end]}
        data[:without] << {:number => line.number,:confirmed => line.without_confirmed.gsub(/ /, ','),:logged_in => line.without_logged_in, :first_upgrade => line.without_first_upgrade, :tank_purchase => line.without_tank_purchase, :start_date => line.week[:start], :end_date => line.week[:end]}
      end
      
      data
    end
    
    def self.process(file_path)
      
      results = CsvMapper.import(file_path) do
        start_at_row 2
        [number, week, without_confirmed, without_number_logged_in, without_logged_in, empty1, without_first_battle, without_first_upgrade, without_tank_purchase, with_confirmed, with_logged_in, with_first_battle, with_first_upgrade, with_tank_purchase]
      end
      
      results.each do |line|
        line.week = self.check_week(line.week)
        binding.pry
        Funnel.create(:type => 'with',:confirmed => line.with_confirmed.gsub(/,| /,'').to_i,:logged_in => line.with_logged_in.to_f, :first_upgrade => line.with_first_upgrade.to_f, :tank_purchase => line.with_tank_purchase.to_f, :start_date => Time.parse(line.week[:start].to_s + ' ' + Date.today.year.to_s).to_date, :end_date => Time.parse(line.week[:end].to_s + ' '+ Date.today.year.to_s).to_date)
        Funnel.create(:type => 'without',:confirmed => line.without_confirmed.gsub(/,| /,'').to_i, :logged_in => line.without_logged_in.to_f, :first_upgrade => line.without_first_upgrade.to_f, :tank_purchase => line.without_tank_purchase.to_f, :start_date => Time.parse(line.week[:start].to_s + ' ' + Date.today.year.to_s).to_date, :end_date => Time.parse(line.week[:end].to_s + ' '+ Date.today.year.to_s).to_date)
      end
    
    end
    
    private
      def self.check_week(week)
        {:start => /[0-9][0-9] [a-zA-Z][a-zA-Z][a-zA-Z]/.match(week, 0), :end => /[0-9][0-9] [a-zA-Z][a-zA-Z][a-zA-Z]/.match(week, 1)}
      end
  
  end
end