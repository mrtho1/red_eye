module RedEye

  class Bias < Struct.new(:center, :span)

    def initialize options = {}
      self.center = LatLng.new
      self.span = []
    
      options.each_pair {|key, value| send("#{key}=", value)}    
    end
  end
  
  class LatLng < Struct.new(:lat, :lng)
  
    def initialize options = {}
    
      self.lat = 0.0
      self.lng = 0.0
    
      options.each_pair {|key, value| send("#{key}=", value)}
    end
  
    def to_s
      "#{lat},#{lng}"
    end
  
    def to_array
      [lat, lng]
    end
  end
  
  class Placemark < Struct.new(:address, :point, :accuracy)
    def initialize options = {}
    
      options.each_pair {|key, value| send("#{key}=", value)}
    end
  end
  
  class Result < Struct.new(:name, :code, :request, :placemarks, :raw)

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