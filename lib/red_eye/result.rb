module RedEye
  class Result
    
    attr_accessor :name, 
                  :code,
                  :request, 
                  :placemarks,
                  :raw
    
    def initialize options = {}
      self.request = "geocode"
      self.placemarks = []
      
      options.each_pair {|key, value| send("#{key}=", value)}      
    end
    
    def success?
      self.code == Constants::StatusCode::SUCCESS
    end        
  end
end
