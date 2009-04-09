module RedEye
  class LatLng
    attr_accessor :lat, :lng
  
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
end