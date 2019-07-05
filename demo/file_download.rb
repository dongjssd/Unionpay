#encoding: utf-8
require "date"
require File.dirname(__FILE__) + "/demo_base.rb"
require 'zip'

# 包含样例：签名、加密、后台post、验签、解customerInfo

# 以下样例使用的接口为无跳转产品的开通状态查询接口，后台类接口可以根据此demo修改代码，注意url参数也请根据不同接口替换
# 不同的值，具体参数如何填写请尽量参考其他语言开发包demo文件夹下的示例和注释说明。

class FileDownload < DemoBase

  def FileDownload.demoTrade
    req = {}

    req["version"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.version
    req["encoding"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.encoding
    req["signMethod"] = Com::UnionPay::Acp::Sdk::SDKConfig.instance.signMethod

    req["txnType"] = "76"
    req["txnSubType"] = "01"
    req["bizType"] = "000000"
    req["accessType"] = "0"
    req["fileType"] = "00"

    req["merId"] = "700000000000001"
    req["txnTime"] = DateTime.parse(Time.now.to_s).strftime("%Y%m%d%H%M%S").to_s
    req["settleDate"] = "0119"

    # 签名示例
    Com::UnionPay::Acp::Sdk::AcpService.sign(req)
    url = Com::UnionPay::Acp::Sdk::SDKConfig.instance.fileTransUrl

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
        path = "d:/file"  # 先建立好文件夹哦
        result += "文件保存到：" \
                      + path + (Com::UnionPay::Acp::Sdk::AcpService.deCodeFileContent(resp, path) ? "成功<br>\n" : "失败<br>\n")
        result += analyzeFile(path, resp["fileName"])
      end
    end
    return result
  end

end

def analyzeFile(fileDir, fileName)
  result = ""
  filePath = fileDir + "/" + fileName
  if !FileTest.exists?(filePath)
    result += "file not found: " + filePath
    return result
  end
  zip_file = Zip::File.open(filePath)
  entry = zip_file.glob('INN*ZM_*').first
  result += getFileHtml(entry) if !entry.nil?
  entry = zip_file.glob('INN*ZME_*').first
  result += getFileHtml(entry) if !entry.nil?
  return result
end

def parseFile(fileStr, lengthArray)
  dataList = []
  fileStr.each_line do |line|
    line.chomp!
    if line == ''
      next
    end
    left_index = 0
    right_index = 0
    dataMap = {}
    for i in (0...lengthArray.length).to_a
      right_index = left_index + lengthArray[i]
      filed = line[left_index .. left_index + lengthArray[i]]
      left_index = right_index + 1
      dataMap[i + 1] = (filed.rstrip!).encode!('utf-8', 'gbk')
    end
    dataList<<dataMap
  end
  return dataList
end


def parseZMFile(fileStr)
  lengthArray = [3, 11, 11, 6, 10, 19, 12, 4, 2, 21, 2, 32, 2, 6, 10, 13, 13,
                 4, 15, 2, 2, 6, 2, 4, 32, 1, 21, 15, 1, 15, 32, 13, 13, 8, 32, 13, 13, 12, 2, 1,
                 131]
  return parseFile(fileStr, lengthArray)
end


def parseZMEFile(fileStr)
  lengthArray = [3, 11, 11, 6, 10, 19, 12, 4, 2, 2, 6, 10, 4, 12, 13, 13, 15, 15, 1, 12, 2, 135]
  return parseFile(fileStr, lengthArray)
end

def getFileHtml(entry)
  content = entry.get_input_stream.read
  list = parseZMFile(content)
  result = entry.name + "部分参数读取（读取方式请参考Form_7_2_FileTransfer的代码）:<br>\n"
  result += "<table border='1'>\n"
  result += "<tr><th>txnType</th><th>orderId</th><th>txnTime（MMDDhhmmss）</th></tr>"
  # TODO
  # 参看https://open.unionpay.com/ajweb/help?id=258，根据编号获取即可，例如订单号12、交易类型20。
  # 具体写代码时可能边读文件边修改数据库性能会更好，请注意自行根据parseFile中的读取方法修改。
  for dic in list
    result += "<tr>\n"
    result += "<td>" + dic[20] + "</td>\n" # txnType
    result += "<td>" + dic[12] + "</td>\n" # orderId
    result += "<td>" + dic[5] + "</td>\n" # txnTime不带年份
    result += "</tr>\n"
  end
  result += "</table>\n"
  return result
end

