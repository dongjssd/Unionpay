#encoding: utf-8
require "date"
require File.dirname(__FILE__) + "/demo_base.rb"

class BackTradeDemo < DemoBase

  def BackTradeDemo.demoTrade
    req = {}

    req["version"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.version
    req["encoding"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.encoding
    req["signMethod"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.signMethod

    req["txnType"] = "78"
    req["txnSubType"] = "00"
    req["bizType"] = "000301"
    req["channelType"] = "07"

    req["merId"] = "777290058110048"
    req["orderId"] = DateTime.parse(Time.now.to_s).strftime("%Y%m%d%H%M%S").to_s
    req["txnTime"] = DateTime.parse(Time.now.to_s).strftime("%Y%m%d%H%M%S").to_s
    req["accessType"] = "0"
    req["accNo"] = "6226090000000048"

    # 签名示例
    Com::UnionPay::Acp::Sdk::AcpService.sign(req)
    url = Com::UnionPay::Acp::Sdk::SDKConfig.instance.backTransUrl

    #post示例
    resp = Com::UnionPay::Acp::Sdk::AcpService.post(req, url)

    result = "请求报文：" + DemoBase.map2str(req) + "<br>\n"
    result = result + "应答报文：" + DemoBase.map2str(resp) + "<br>\n"

    #验签示例
    result = result + (Com::UnionPay::Acp::Sdk::AcpService.validate(resp) ? "验签成功<br>\n" : "验签失败<br>\n")

    if resp["respCode"]
      #取应答报文里的参数的示例
      result = result + "respCode=" + resp["respCode"] + "<br>\n"
      result = result + "respMsg=" + resp["respMsg"] + "<br>\n"

      #解密示例
      if resp["customerInfo"]
        customerInfo = Com::UnionPay::Acp::Sdk::AcpService.parseCustomerInfo(resp["customerInfo"])
        if(customerInfo["phoneNo"])
          result = result + "phoneNo=" + customerInfo["phoneNo"] + "<br>\n"
        end
      end
    end
    return result
  end

end
