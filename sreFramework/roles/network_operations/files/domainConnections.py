import socket
import sys
#pass the  domain name
#find the ip
#set iptable rules


#action can be:
#1.block Incoming from domainName
#2.block Outgoing to domainName
#3.block both Incoming and Outgoing for a domain name
#4.undo block Incoming from domainName
#5.undo block Outgoing to domainName
#6.undo block Incoming and Outgoing for a domain name


domainName = sys.argv[1]
action = sys.argv[2]




def getIpAddress(domainName):
  print socket.gethostbyname(domainName)
  ipAddress = socket.gethostbyname(domainName)
  return ipAddress


def blockIncoming_domainName(ipAddress):
  print "blockIncoming_domainName : "+str(ipAddress)

def blockOutgoing_domainName(ipAddress):
 print "blockOutgoing_domainName"+str(ipAddress)


def undo_blockIncoming_domainName(ipAddress):
 print "undo_blockIncoming_domainName "+str(ipAddress)


def undo_blockOutgoing_domainName(ipAddress):
 print "undo_blockOutgoing_domainName "+str(ipAddress)





def setRules(domainName,action):
  ipAddress = getIpAddress(domainName)
  print "the returned ipAddress is : "+str(ipAddress)
  options = { "blockIncoming_domainName" : blockIncoming_domainName,
              "blockOutgoing_domainName" : blockOutgoing_domainName,
             "undo_blockOutgoing_domainName" : undo_blockOutgoing_domainName,
            "undo_blockIncoming_domainName" :undo_blockIncoming_domainName

            }
  options.get(action)(ipAddress)



setRules(domainName,action)
