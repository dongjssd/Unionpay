#encoding: utf-8
require File.dirname(__FILE__) + '/../sdk/acp_service.rb'

class DemoBase

  def DemoBase.map2str(params)
    result = ''
    for key in params.keys
      result = result + key + "=" + params[key] + ', '
      result = result[0, result.length - 1]
    end
    result
  end

end