#encoding: utf-8
require "date"
require File.dirname(__FILE__) + "/demo_base.rb"

# 包含样例：签名、加密、后台post、验签、解customerInfo

# 以下样例使用的接口为无跳转产品的开通状态查询接口，后台类接口可以根据此demo修改代码，注意url参数也请根据不同接口替换
# 不同的值，具体参数如何填写请尽量参考其他语言开发包demo文件夹下的示例和注释说明。

class BatTransQuery < DemoBase

  def BatTransQuery.demoTrade
    req = {}

    req["version"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.version
    req["encoding"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.encoding
    req["signMethod"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.signMethod

    req["txnType"] = "22"
    req["txnSubType"] = "03"
    req["bizType"] = "000401"
    req["accessType"] = "0"
    req["channelType"] = "07"

    req["merId"] = "777290058110097"
    req["txnTime"] = DateTime.parse(Time.now.to_s).strftime("%Y%m%d%H%M%S").to_s
    req["batchNo"] = "0001"

    # 签名示例
    Com::UnionPay::Acp::Sdk::AcpService.sign(req)
    url = Com::UnionPay::Acp::Sdk::SDKConfig.instance.batchTransUrl

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
      if resp["respCode"] == "00"
        path = "d:/file/"  # 先建立好文件夹哦
        result += "文件保存到：" \
                      + path + (Com::UnionPay::Acp::Sdk::AcpService.deCodeFileContent(resp, path) ? "成功<br>\n" : "失败<br>\n")
      end
    end
    return result
  end

end
