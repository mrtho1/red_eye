module RedEye ; module Constants
  module StatusCode
    SUCCESS = 200
    SERVER_ERROR = 500
    MISSING_QUERY = 601
    UNKNOWN_ADDRESS = 602
    UNAVAILABLE_ADDRESS = 603
    BAD_KEY = 610
    TOO_MANY_QUERIES = 620
  end
  
  module Accuracy
    UNKNOWN = 0
    COUNTRY = 1
    REGION = 2
    SUB_REGION = 3
    TOWN = 4
    POST_CODE = 5
    STREET = 6
    INTERSECTION = 7
    ADDRESS = 8
    PREMISE = 9
  end
end ; end
