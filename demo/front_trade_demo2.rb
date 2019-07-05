#encoding: utf-8
require "date"
require File.dirname(__FILE__) + "/demo_base.rb"


#包含样例：签名、加密、生成自动提交的html表单，注意涉及加密的业务上规定只能用证书方式签名，请勿使用密钥方式签名的配置文件

class FrontTradeDemo2

  def FrontTradeDemo2.getDemoHtml

    req = {}

    req["version"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.version
    req["encoding"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.encoding
    req["signMethod"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.signMethod

    req["frontUrl"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.frontUrl
    req["backUrl"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.backUrl

    req["txnType"] = "01"
    req["txnSubType"] = "01"
    req["bizType"] = "000201"
    req["channelType"] = "07"
    req["currencyCode"] = "156"
    req["txnAmt"] = "1000"

    req["merId"] = "777290058110048"
    req["orderId"] = DateTime.parse(Time.now.to_s).strftime("%Y%m%d%H%M%S").to_s
    req["txnTime"] = DateTime.parse(Time.now.to_s).strftime("%Y%m%d%H%M%S").to_s
    req["accessType"] = "0"

    #签名示例
    Com::UnionPay::Acp::Sdk::AcpService.sign(req)
    url = Com::UnionPay::Acp::Sdk::SDKConfig.instance.frontTransUrl

    #前台自提交表单示例
    resp = Com::UnionPay::Acp::Sdk::AcpService.createAutoFormHtml(req, url)

    return resp

  end
end
