require 'ostruct'

module RedEye

  class Bias < OpenStruct

    def initialize options = nil
      super(options)
      self.center ||= LatLng.new
      self.span ||= []
    end
  end
  
  class LatLng < OpenStruct
  
    def initialize options = nil
      super(options)
      self.lat ||= 0.0
      self.lng ||= 0.0
    end
    
    def to_s
      "#{self.lat},#{self.lng}"
    end
  end
  
  class Placemark < OpenStruct; end
  
  class Result < OpenStruct
    def initialize options = nil
      super(options)
      self.request ||= "geocode"
      self.placemarks ||= []
    end
    
    def success?
      self.code == Constants::StatusCode::SUCCESS
    end        
  end
end